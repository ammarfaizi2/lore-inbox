Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319168AbSHMX0I>; Tue, 13 Aug 2002 19:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319121AbSHMXFB>; Tue, 13 Aug 2002 19:05:01 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:5628 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319147AbSHMXAn>; Tue, 13 Aug 2002 19:00:43 -0400
Date: Tue, 13 Aug 2002 19:04:31 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 20/38: CLIENT: lease time in 'struct nfs_fsinfo'
Message-ID: <Pine.SOL.4.44.0208131904150.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A trivial loose end: add a 'lease_time' field to 'struct nfs_fsinfo'.

--- old/include/linux/nfs_xdr.h	Sat Aug 10 23:55:26 2002
+++ new/include/linux/nfs_xdr.h	Tue Aug  6 10:16:09 2002
@@ -65,6 +65,7 @@ struct nfs_fsinfo {
 	__u64			afiles;	/* # of files available to user */
 	__u32			linkmax;/* max # of hard links */
 	__u32			namelen;/* max name length */
+	__u32			lease_time; /* in seconds */
 };

 /* Arguments to the read call.

