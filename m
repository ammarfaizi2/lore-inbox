Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319310AbSHNUrZ>; Wed, 14 Aug 2002 16:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319318AbSHNUqy>; Wed, 14 Aug 2002 16:46:54 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:4311 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319312AbSHNUpp>; Wed, 14 Aug 2002 16:45:45 -0400
Date: Wed, 14 Aug 2002 16:49:35 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 27/38: SERVER: expand filehandle to 128 bytes
Message-ID: <Pine.SOL.4.44.0208141649100.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Expand filehandle to 128 bytes.

--- old/include/linux/nfsd/nfsfh.h	Sun Aug 11 22:57:20 2002
+++ new/include/linux/nfsd/nfsfh.h	Sun Aug 11 22:58:05 2002
@@ -96,7 +96,7 @@ struct knfsd_fh {
 					 */
 	union {
 		struct nfs_fhbase_old	fh_old;
-		__u32			fh_pad[NFS3_FHSIZE/4];
+		__u32			fh_pad[NFS4_FHSIZE/4];
 		struct nfs_fhbase_new	fh_new;
 	} fh_base;
 };

