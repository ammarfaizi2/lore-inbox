Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbSJEPpY>; Sat, 5 Oct 2002 11:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262385AbSJEPpY>; Sat, 5 Oct 2002 11:45:24 -0400
Received: from pat.uio.no ([129.240.130.16]:47761 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262384AbSJEPpX>;
	Sat, 5 Oct 2002 11:45:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15775.2654.502424.712655@charged.uio.no>
Date: Sat, 5 Oct 2002 17:50:54 +0200
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: 2.4.19 NFS file perms
In-Reply-To: <20021005122115.A1338@linux-m68k.org>
References: <20021005122115.A1338@linux-m68k.org>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard Zidlicky <rz@linux-m68k.org> writes:

     > Hi, on an NFS mounted fs, executing as root I see this:

     > read(4, 0xefffe4cb, 1) = -1 EIO (Input/output error)

     > glibc crashes in fgets because it doesn't expect the problem
     > after the file has been successfully opened and mapped.. who is
     > at fault here?

The 'soft' mount option perhaps?

Cheers,
  Trond
