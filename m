Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTE2VPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTE2VPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:15:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42444 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262818AbTE2VPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:15:08 -0400
Date: Thu, 29 May 2003 23:28:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: trond.myklebust@fys.uio.no, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       Frank Cusack <fcusack@fcusack.com>
Subject: [PATCH] fs/nfs/nfs3xdr.c trivial comment fix (fwd)
Message-ID: <20030529212818.GK5643@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial comment fix by Frank Cusack forwarded below still apply 
against 2.5.70.

Please apply
Adrian


----- Forwarded message from Frank Cusack <fcusack@fcusack.com> -----

Date:	Mon, 19 May 2003 21:12:21 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/nfs/nfs3xdr.c trivial comment fix

--- linux-2.5.69/fs/nfs/nfs3xdr.c.orig	Mon May 19 21:05:20 2003
+++ linux-2.5.69/fs/nfs/nfs3xdr.c	Mon May 19 21:05:37 2003
@@ -124,8 +124,6 @@
 
 /*
  * Encode/decode time.
- * Since the VFS doesn't care for fractional times, we ignore the
- * nanosecond field.
  */
 static inline u32 *
 xdr_encode_time3(u32 *p, struct timespec *timep)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

