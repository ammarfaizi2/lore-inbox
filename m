Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVCSN3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVCSN3c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVCSNW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:22:28 -0500
Received: from coderock.org ([193.77.147.115]:3720 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262466AbVCSNRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:17:48 -0500
Subject: [patch 08/10] arch/i386/kernel/apm.c: fix sparse warnings
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:17:38 +0100
Message-Id: <20050319131738.BCCD31F1EE@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/kernel/apm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/apm.c~sparse-arch_i386_kernel_apm arch/i386/kernel/apm.c
--- kj/arch/i386/kernel/apm.c~sparse-arch_i386_kernel_apm	2005-03-18 20:05:19.000000000 +0100
+++ kj-domen/arch/i386/kernel/apm.c	2005-03-18 20:05:19.000000000 +0100
@@ -346,10 +346,10 @@ extern int (*console_blank_hook)(int);
 struct apm_user {
 	int		magic;
 	struct apm_user *	next;
-	int		suser: 1;
-	int		writer: 1;
-	int		reader: 1;
-	int		suspend_wait: 1;
+	unsigned int	suser: 1;
+	unsigned int	writer: 1;
+	unsigned int	reader: 1;
+	unsigned int	suspend_wait: 1;
 	int		suspend_result;
 	int		suspends_pending;
 	int		standbys_pending;
_
