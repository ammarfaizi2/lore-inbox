Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319132AbSHMX1O>; Tue, 13 Aug 2002 19:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319138AbSHMX0U>; Tue, 13 Aug 2002 19:26:20 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:48892 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319132AbSHMXEe>; Tue, 13 Aug 2002 19:04:34 -0400
Date: Tue, 13 Aug 2002 19:08:22 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 28/38: SERVER: expand filehandle to 128 bytes
Message-ID: <Pine.SOL.4.44.0208131908030.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Expand filehandle to 128 bytes.

--- old/include/linux/nfsd/nfsfh.h	Tue Jul 30 22:43:19 2002
+++ new/include/linux/nfsd/nfsfh.h	Mon Jul 29 11:50:09 2002
@@ -96,7 +96,7 @@ struct knfsd_fh {
 					 */
 	union {
 		struct nfs_fhbase_old	fh_old;
-		__u32			fh_pad[NFS3_FHSIZE/4];
+		__u32			fh_pad[NFS4_FHSIZE/4];
 		struct nfs_fhbase_new	fh_new;
 	} fh_base;
 };

