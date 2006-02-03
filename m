Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWBCVDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWBCVDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWBCVDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:03:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57613 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030241AbWBCVC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:02:59 -0500
Date: Fri, 3 Feb 2006 22:02:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] missing license tag in intermodule
Message-ID: <20060203210258.GL4408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>

It may suck something awful, but it shouldn't taint the kernel.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Dave Jones on:
- 1 Feb 2006

--- linux-2.6.15.noarch/kernel/intermodule.c~	2006-02-01 18:01:39.000000000 -0500
+++ linux-2.6.15.noarch/kernel/intermodule.c	2006-02-01 18:01:47.000000000 -0500
@@ -179,3 +179,6 @@ EXPORT_SYMBOL(inter_module_register);
 EXPORT_SYMBOL(inter_module_unregister);
 EXPORT_SYMBOL(inter_module_get_request);
 EXPORT_SYMBOL(inter_module_put);
+
+MODULE_LICENSE("GPL");
+
