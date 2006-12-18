Return-Path: <linux-kernel-owner+w=401wt.eu-S1752710AbWLRDqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbWLRDqr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbWLRDqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:46:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4287 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752717AbWLRDqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:46:31 -0500
Date: Mon, 18 Dec 2006 04:46:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/cpu/mcheck/mce.c should #include <asm/mce.h>
Message-ID: <20061218034631.GA10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should include the headers containing the prototypes for
it's global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc1-mm1/arch/i386/kernel/cpu/mcheck/mce.c.old	2006-12-18 03:23:55.000000000 +0100
+++ linux-2.6.20-rc1-mm1/arch/i386/kernel/cpu/mcheck/mce.c	2006-12-18 03:24:11.000000000 +0100
@@ -12,6 +12,7 @@
 
 #include <asm/processor.h> 
 #include <asm/system.h>
+#include <asm/mce.h>
 
 #include "mce.h"
 

