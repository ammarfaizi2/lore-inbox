Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUGRTs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUGRTs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 15:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUGRTs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 15:48:27 -0400
Received: from web53805.mail.yahoo.com ([206.190.36.200]:54350 "HELO
	web53805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262418AbUGRTs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 15:48:26 -0400
Message-ID: <20040718194826.6164.qmail@web53805.mail.yahoo.com>
Date: Sun, 18 Jul 2004 12:48:26 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from net/sctp files
To: lkml <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/net/sctp/socket.c linux-2.6.7-new/net/sctp/socket.c
--- linux-2.6.7-orig/net/sctp/socket.c  2004-06-15 22:20:26.000000000 -0700
+++ linux-2.6.7-new/net/sctp/socket.c   2004-07-18 08:54:08.000000000 -0700
@@ -109,7 +109,6 @@
 static char *sctp_hmac_alg = SCTP_COOKIE_HMAC_ALG;

 extern kmem_cache_t *sctp_bucket_cachep;
-extern int sctp_assoc_valid(struct sock *sk, struct sctp_association *asoc);

 /* Look up the association by its id.  If this is not a UDP-style
  * socket, the ID field is always ignored.

