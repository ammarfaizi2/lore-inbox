Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVCTLQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVCTLQk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVCTLQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:16:39 -0500
Received: from coderock.org ([193.77.147.115]:29323 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262133AbVCTLPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:15:54 -0500
Date: Sun, 20 Mar 2005 12:15:49 +0100
From: Domen Puncer <domen@coderock.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 08/10 with proper signed-off] arch/i386/kernel/apm.c: fix sparse warnings
Message-ID: <20050320111549.GC14273@nd47.coderock.org>
References: <20050319131738.BCCD31F1EE@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131738.BCCD31F1EE@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/kernel/apm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/apm.c~sparse-arch_i386_kernel_apm arch/i386/kernel/apm.c
--- kj/arch/i386/kernel/apm.c~sparse-arch_i386_kernel_apm	2005-03-20 12:11:19.000000000 +0100
+++ kj-domen/arch/i386/kernel/apm.c	2005-03-20 12:11:19.000000000 +0100
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
