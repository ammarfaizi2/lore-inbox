Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319299AbSHNUsf>; Wed, 14 Aug 2002 16:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319301AbSHNUrc>; Wed, 14 Aug 2002 16:47:32 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:64213 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319299AbSHNUmA>; Wed, 14 Aug 2002 16:42:00 -0400
Date: Wed, 14 Aug 2002 16:45:48 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 19/38: CLIENT: lease time in 'struct nfs_fsinfo'
Message-ID: <Pine.SOL.4.44.0208141645300.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A trivial loose end: add a 'lease_time' field to 'struct nfs_fsinfo'.

--- old/include/linux/nfs_xdr.h	Sun Aug 11 22:19:39 2002
+++ new/include/linux/nfs_xdr.h	Sun Aug 11 22:24:08 2002
@@ -66,6 +66,7 @@ struct nfs_fsinfo {
 	__u64			afiles;	/* # of files available to user */
 	__u32			linkmax;/* max # of hard links */
 	__u32			namelen;/* max name length */
+	__u32			lease_time; /* in seconds */
 };

 /* Arguments to the read call.

