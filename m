Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWKGK2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWKGK2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 05:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbWKGK2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 05:28:54 -0500
Received: from ensim03.ffm.m2soft.com ([195.38.20.12]:6047 "EHLO
	ensim03.ffm.m2soft.com") by vger.kernel.org with ESMTP
	id S1751638AbWKGK2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 05:28:53 -0500
X-ClientAddr: 85.126.108.208
Date: Tue, 7 Nov 2006 11:06:06 +0100
From: Nicolas Kaiser <nikai@nikai.net>
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] arch/i386: double inclusions
Message-ID: <20061107110606.1505e19a@lucky.kitzblitz>
Organization: -
X-Face: "fF&[w2"Nws:JNH4'g|:gVhgGKLhj|X}}&w&V?]0=,7n`jy8D6e[Jh=7+ca|4~t5e[ItpL5
 N'y~Mvi-vJm`"1T5fi1^b!&EG]6nW~C!FN},=$G?^U2t~n[3;u\"5-|~H{-5]IQ2
X-Mailer: Sylpheed-claws (Linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-M2Soft-MailScanner-Information: Please contact the ISP for more information
X-M2Soft-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: nikai@nikai.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

double inclusions in arch/i386

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---

 arch/i386/kernel/cpuid.c |    1 -
 arch/i386/kernel/tsc.c   |    1 -
 2 files changed, 2 deletions(-)

diff -uprN a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
--- a/arch/i386/kernel/cpuid.c	2006-09-20 05:42:06.000000000 +0200
+++ b/arch/i386/kernel/cpuid.c	2006-11-07 10:05:17.000000000 +0100
@@ -34,7 +34,6 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
-#include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
diff -uprN a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
--- a/arch/i386/kernel/tsc.c	2006-09-20 05:42:06.000000000 +0200
+++ b/arch/i386/kernel/tsc.c	2006-11-07 10:05:42.000000000 +0100
@@ -13,7 +13,6 @@
 
 #include <asm/delay.h>
 #include <asm/tsc.h>
-#include <asm/delay.h>
 #include <asm/io.h>
 
 #include "mach_timer.h"

