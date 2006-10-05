Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWJEVrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWJEVrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWJEVl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:41:57 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:39540 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932249AbWJEVlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:41:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=5FZgL/HC2bXSWV7r2r1LHev9ef8pDoxYQ9qsOpFmHplOQYQm4krBpHzkuZm9Oe0lS4AFI1BkFG4Q8f/ndmDTlsuHHqgQXVOdI9PHuKlFxen1PXJ9OUKI2K9viuPNY7Mgt2z+pOLnBRpo6YpoNP6pr3mcl5AHWQbVRzmz+zWIdyM=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 04/14] uml: readd forgot prototype
Date: Thu, 05 Oct 2006 23:38:46 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213846.17268.31893.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This was forgot in a previous patch so UML does not compile with TT mode enabled.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index 120ca21..6516f6d 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -201,6 +201,7 @@ extern int os_getpgrp(void);
 
 #ifdef UML_CONFIG_MODE_TT
 extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
+extern void stop(void);
 #endif
 extern void init_new_thread_signals(void);
 extern int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr);
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
