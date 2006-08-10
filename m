Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWHJUYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWHJUYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWHJUPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7338 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932621AbWHJUOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:14:05 -0400
Date: Thu, 10 Aug 2006 16:13:48 -0400
From: Dave Jones <davej@redhat.com>
To: ak@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: remove config.h includes from asm-i386 & asm-x86_64
Message-ID: <20060810201348.GA15387@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, ak@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is now automatically included by kbuild.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/include/asm-i386/tsc.h~	2006-08-10 16:10:24.000000000 -0400
+++ linux-2.6.17.noarch/include/asm-i386/tsc.h	2006-08-10 16:10:28.000000000 -0400
@@ -6,7 +6,6 @@
 #ifndef _ASM_i386_TSC_H
 #define _ASM_i386_TSC_H
 
-#include <linux/config.h>
 #include <asm/processor.h>
 
 /*
--- linux-2.6.17.noarch/include/asm-i386/dwarf2.h~	2006-08-10 16:10:52.000000000 -0400
+++ linux-2.6.17.noarch/include/asm-i386/dwarf2.h	2006-08-10 16:10:56.000000000 -0400
@@ -1,8 +1,6 @@
 #ifndef _DWARF2_H
 #define _DWARF2_H
 
-#include <linux/config.h>
-
 #ifndef __ASSEMBLY__
 #warning "asm/dwarf2.h should be only included in pure assembly files"
 #endif
--- linux-2.6.17.noarch/include/asm-x86_64/calgary.h~	2006-08-10 16:11:27.000000000 -0400
+++ linux-2.6.17.noarch/include/asm-x86_64/calgary.h	2006-08-10 16:11:31.000000000 -0400
@@ -24,7 +24,6 @@
 #ifndef _ASM_X86_64_CALGARY_H
 #define _ASM_X86_64_CALGARY_H
 
-#include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>

-- 
http://www.codemonkey.org.uk
