Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbTGGThF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbTGGThF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:37:05 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:726 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267190AbTGGThC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:37:02 -0400
Message-Id: <200307071951.h67JpVEp005152@eeyore.valparaiso.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.7x: No vga=0x317?
X-Mailer: MH-E 7.1; nmh 1.0.4; XEmacs 21.4
Date: Mon, 07 Jul 2003 15:51:31 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Toshiba Satellite notebook 1800 (P3 mobile/1100, 256MiB RAM,
Trident CyberBlade XPAi1 (rev 82) graphics card; RH 9.

STFW for this machine I found that adding "vga=0x317" to the kernel args
uses the full screen on the virtual TTYs (normal is 80x24 in a small
rectangle at the center of the screen). I tried several 2.5 kernels, and
was convinced they didn't boot (no time to investigate further, sorry).
With 2.5.74 I noticed that the machine does in fact boot, but nothing at
all shows up on the screen until X starts. Deleting the "vga=..." stuff
shows the customary 80x24 rectangle, vga=ask gives a only a few 80x<mumble>
modes. The ones I tried are useless.

Anything I can try/hack to pieces? Not exactly urgent, but having
fullscreen vt's is quite nice.

Thanks!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
