Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUKJUsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUKJUsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUKJUsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:48:02 -0500
Received: from ozlabs.org ([203.10.76.45]:30349 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261920AbUKJUrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:47:15 -0500
Date: Thu, 11 Nov 2004 07:45:00 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Bump MAX_HWIFS in IDE code
Message-ID: <20041110204500.GC1922@krispykreme.ozlabs.ibm.com>
References: <20041109203028.GA26806@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109203028.GA26806@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When fully configured, some POWER5 boxes can have much more than 4 IDE
interfaces. Increase the limit to reflect this.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN include/asm-ppc64/ide.h~bump_ide_hwifs include/asm-ppc64/ide.h
--- gr_work/include/asm-ppc64/ide.h~bump_ide_hwifs	2004-08-25 08:11:54.357759525 -0500
+++ gr_work-anton/include/asm-ppc64/ide.h	2004-08-25 08:11:54.366758100 -0500
@@ -19,7 +19,7 @@
 #ifdef __KERNEL__
 
 #ifndef MAX_HWIFS
-# define MAX_HWIFS	4
+# define MAX_HWIFS	10
 #endif
 
 #define IDE_ARCH_OBSOLETE_INIT
_
