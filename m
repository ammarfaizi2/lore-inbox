Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129457AbRBAIQI>; Thu, 1 Feb 2001 03:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129409AbRBAIPt>; Thu, 1 Feb 2001 03:15:49 -0500
Received: from pat.uio.no ([129.240.130.16]:14464 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129580AbRBAIPR>;
	Thu, 1 Feb 2001 03:15:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14969.6928.679579.319266@charged.uio.no>
Date: Thu, 1 Feb 2001 09:15:12 +0100 (CET)
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: NFS root mounting in 2.4.1...
In-Reply-To: <200102010003.f1103ll11665@flint.arm.linux.org.uk>
In-Reply-To: <200102010003.f1103ll11665@flint.arm.linux.org.uk>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Russell King <rmk@arm.linux.org.uk> writes:

     > ...fails on ARM with ESTALE (116): Looking up port of RPC
     > 100003/2 on 192.168.0.4 Looking up port of RPC 100005/2 on
     > 192.168.0.4 nfs_get_root: getattr error = 116 nfs_read_super:
     > get root inode failed VFS: Unable to mount root fs via NFS,
     > trying floppy.


Thanks. I'll update the NFS ARM filehandle patch in the course of
today.

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
