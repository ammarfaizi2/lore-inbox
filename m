Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130831AbRCWOYt>; Fri, 23 Mar 2001 09:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRCWOYj>; Fri, 23 Mar 2001 09:24:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9230 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130831AbRCWOYU>; Fri, 23 Mar 2001 09:24:20 -0500
Subject: Re: Linux 2.4.2-ac23
To: bunk@fs.tum.de (Adrian Bunk)
Date: Fri, 23 Mar 2001 14:13:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.33.0103231456500.26499-200000@pluto.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Mar 23, 2001 03:06:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gSJc-0004lf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duh yes.. it would for some people

--- arch/i386/kernel/setup.c~	Thu Mar 22 23:18:21 2001
+++ arch/i386/kernel/setup.c	Fri Mar 23 13:26:08 2001
@@ -2276,7 +2276,7 @@
 	 */
 
 	/* TSC disabled? */
-#ifdef CONFIG_X86_TSC
+#ifndef CONFIG_X86_TSC
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
 #endif

