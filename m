Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVKJS33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVKJS33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVKJS33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:29:29 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:2214 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932129AbVKJS32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:29:28 -0500
Date: Thu, 10 Nov 2005 10:29:55 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] -rt: Fix ARM IXP4xx compile
Message-ID: <20051110182955.GB27766@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Need to pick up global IRQ_* definitions.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

Index: linux-2.6-git/arch/arm/mach-ixp4xx/ixdpg425-pci.c
===================================================================
--- linux-2.6-git.orig/arch/arm/mach-ixp4xx/ixdpg425-pci.c
+++ linux-2.6-git/arch/arm/mach-ixp4xx/ixdpg425-pci.c
@@ -16,10 +16,10 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 
 #include <asm/mach-types.h>
 #include <asm/hardware.h>
-#include <asm/irq.h>
 
 #include <asm/mach/pci.h>
 

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

When law and duty are one, united by religion, you never become fully
conscious, fully aware of yourself. You are always a little less than
an individual. - Frank Herbert
