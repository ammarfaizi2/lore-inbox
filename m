Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbTDAQZw>; Tue, 1 Apr 2003 11:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbTDAQZw>; Tue, 1 Apr 2003 11:25:52 -0500
Received: from pat.uio.no ([129.240.130.16]:51171 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262662AbTDAQZv>;
	Tue, 1 Apr 2003 11:25:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16009.49199.898453.578446@charged.uio.no>
Date: Tue, 1 Apr 2003 18:37:03 +0200
To: Vladimir Serov <vserov@infratel.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: NFS write got EIO on kernel starting from 2.4.19-pre4 (or -pre3 maybe)
In-Reply-To: <3E899128.2050200@infratel.com>
References: <3E899128.2050200@infratel.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Vladimir Serov <vserov@infratel.com> writes:

     > I'm able to trigger problem by 'dd if=/dev/zero of=test bs=32k
     > count=1024' I'm using NFS over UDP, and this problem ccured
     > regardless of soft or hard mounted fs.

You sure about the 'regardless of hard mount' bit? I can write
multi-gigabyte files with 2.4.21-pre6 without ever seeing an error
(just now I ran a 3x3GB read/write using iozone without any trouble).

Cheers,
  Trond
