Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267740AbTAIVAq>; Thu, 9 Jan 2003 16:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267745AbTAIVAq>; Thu, 9 Jan 2003 16:00:46 -0500
Received: from air-2.osdl.org ([65.172.181.6]:27539 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267740AbTAIVAq>;
	Thu, 9 Jan 2003 16:00:46 -0500
Subject: [NFS] [PATCH] missing export of hash_mem (2.5.55)
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1042146568.4870.57.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 09 Jan 2003 13:09:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't build nfs server as a module because of missing export of hash_mem


diff -Nru a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
--- a/net/sunrpc/sunrpc_syms.c	Thu Jan  9 13:07:34 2003
+++ b/net/sunrpc/sunrpc_syms.c	Thu Jan  9 13:07:34 2003
@@ -104,6 +104,7 @@
 EXPORT_SYMBOL(qword_get);
 EXPORT_SYMBOL(svcauth_unix_purge);
 EXPORT_SYMBOL(unix_domain_find);
+EXPORT_SYMBOL(hash_mem);
 
 /* Generic XDR */
 EXPORT_SYMBOL(xdr_encode_array);



