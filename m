Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269184AbUJWEaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269184AbUJWEaH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267645AbUJWE3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:29:11 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:7047
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S267708AbUJWE0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:26:17 -0400
Subject: [patch 3/5] uml-unused-label
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Sat, 23 Oct 2004 05:53:18 +0200
Message-Id: <20041023035318.EB65795D1@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/tt/process_kern.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/um/kernel/tt/process_kern.c~uml-unused-label arch/um/kernel/tt/process_kern.c
--- linux-2.6.9-current/arch/um/kernel/tt/process_kern.c~uml-unused-label	2004-10-12 02:13:03.528818872 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/tt/process_kern.c	2004-10-12 02:13:23.258819456 +0200
@@ -305,7 +305,6 @@ int copy_thread_tt(int nr, unsigned long
 
 	change_sig(SIGUSR1, 0);
 	err = 0;
- out:
 	return(err);
 }
 
_
