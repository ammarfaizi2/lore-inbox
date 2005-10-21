Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVJUPsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVJUPsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVJUPsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:48:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:46999 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964993AbVJUPr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:47:57 -0400
Subject: Re: PATCH: Allow users to force a panic on NMI - Header file
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1129900906.26367.33.camel@localhost.localdomain>
References: <1129900906.26367.33.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Oct 2005 17:16:41 +0100
Message-Id: <1129911401.26367.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot the header file in that one.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/include/linux/kernel.h linux-2.6.14-rc4-mm1/include/linux/kernel.h
--- linux.vanilla-2.6.14-rc4-mm1/include/linux/kernel.h	2005-10-20 16:12:41.000000000 +0100
+++ linux-2.6.14-rc4-mm1/include/linux/kernel.h	2005-10-20 17:30:10.000000000 +0100
@@ -170,6 +170,7 @@
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern __deprecated_for_modules int panic_timeout;
 extern int panic_on_oops;
+extern int panic_on_unrecovered_nmi;
 extern int tainted;
 extern const char *print_tainted(void);
 extern void add_taint(unsigned);

