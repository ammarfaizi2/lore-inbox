Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319308AbSHNUoj>; Wed, 14 Aug 2002 16:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSHNUnO>; Wed, 14 Aug 2002 16:43:14 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:10454 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319292AbSHNUmo>; Wed, 14 Aug 2002 16:42:44 -0400
Date: Wed, 14 Aug 2002 16:46:35 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 21/38: SERVER: error codes in include/linux/nfsd/nfsd.h
Message-ID: <Pine.SOL.4.44.0208141646170.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add some new NFSv4-only error codes to include/linux/nfsd/nfsd.h

--- old/include/linux/nfsd/nfsd.h	Thu Aug  1 16:16:23 2002
+++ new/include/linux/nfsd/nfsd.h	Sun Aug 11 22:51:43 2002
@@ -170,6 +170,16 @@ void		nfsd_lockd_unexport(struct svc_cli
 #define	nfserr_serverfault	__constant_htonl(NFSERR_SERVERFAULT)
 #define	nfserr_badtype		__constant_htonl(NFSERR_BADTYPE)
 #define	nfserr_jukebox		__constant_htonl(NFSERR_JUKEBOX)
+#define nfserr_bad_cookie	__constant_htonl(NFSERR_BAD_COOKIE)
+#define nfserr_same		__constant_htonl(NFSERR_SAME)
+#define nfserr_clid_inuse	__constant_htonl(NFSERR_CLID_INUSE)
+#define	nfserr_resource		__constant_htonl(NFSERR_RESOURCE)
+#define nfserr_nofilehandle	__constant_htonl(NFSERR_NOFILEHANDLE)
+#define nfserr_minor_vers_mismatch	__constant_htonl(NFSERR_MINOR_VERS_MISMATCH)
+#define nfserr_symlink		__constant_htonl(NFSERR_SYMLINK)
+#define nfserr_not_same		__constant_htonl(NFSERR_NOT_SAME)
+#define nfserr_readdir_nospc	__constant_htonl(NFSERR_READDIR_NOSPC)
+#define nfserr_bad_xdr		__constant_htonl(NFSERR_BAD_XDR)

 /* error code for internal use - if a request fails due to
  * kmalloc failure, it gets dropped.  Client should resend eventually

