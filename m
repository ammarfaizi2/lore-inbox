Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbULPBFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbULPBFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbULPBDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:03:39 -0500
Received: from mail.dif.dk ([193.138.115.101]:7077 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262632AbULPAeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:34:31 -0500
Date: Thu, 16 Dec 2004 01:45:01 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 30/30] return statement cleanup - kill pointless parentheses
  in kernel/intermodule.c   
Message-ID: <Pine.LNX.4.61.0412160143220.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




This patch removes pointless parentheses from return statements in kernel/intermodule.c


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>




--- linux-2.6.10-rc3-bk8-orig/kernel/intermodule.c	2004-10-18 23:53:05.000000000 +0200
+++ linux-2.6.10-rc3-bk8/kernel/intermodule.c	2004-12-16 00:06:30.000000000 +0100
@@ -129,7 +129,7 @@ const void *inter_module_get(const char 
 		}
 	}
 	spin_unlock(&ime_lock);
-	return(result);
+	return result;
 }
 
 /**
@@ -146,7 +146,7 @@ const void *inter_module_get_request(con
 		request_module("%s", modname);
 		result = inter_module_get(im_name);
 	}
-	return(result);
+	return result;
 }
 
 /**







