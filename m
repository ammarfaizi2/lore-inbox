Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbTDAPnH>; Tue, 1 Apr 2003 10:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbTDAPnH>; Tue, 1 Apr 2003 10:43:07 -0500
Received: from mons.uio.no ([129.240.130.14]:44939 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262617AbTDAPnG>;
	Tue, 1 Apr 2003 10:43:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16009.46639.143727.69532@charged.uio.no>
Date: Tue, 1 Apr 2003 17:54:23 +0200
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

     > Hi Trond, Belive or not, I've got another NFS related
     > problem. I'm getting EIO in several programs (dd, make) writing
     > relativly large file (several megabytes) over NFS. I've tested
     > several kernels to find out where this problem was
     > introdused. Here the list:

     > Good kernels (doesn't give EIO) : 2.4.18-5asp, 2.4.19,
     > 2.4.20-pre2 Bad kernel (gives EIO): 2.4.20-pre4, 2.4.20-pre6,
     > 2.4.20, 2.4.21-pre5-ac3, 2.4.21-pre6 2.4.20-pre3 unfortunatly
     > hangs on boot on my hardware.

Are there any kernel messages to accompany this EIO?

Cheers,
 Trond
