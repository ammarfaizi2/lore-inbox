Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281805AbRLLSuP>; Wed, 12 Dec 2001 13:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281794AbRLLSuG>; Wed, 12 Dec 2001 13:50:06 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:6583 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S281762AbRLLStt>;
	Wed, 12 Dec 2001 13:49:49 -0500
Date: Wed, 12 Dec 2001 19:49:43 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: FBdev remains in unusable state
Message-ID: <Pine.GSO.4.30.0112121942460.18842-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I am currently using 2.4.17-pre8, and X-4.1.0.

My problem is that if I turn on fb (eg pass vga=0x301 parameter), start an
X session, then switch back to the console using CTRL-ALT-Fx (or
ctrl-alt-bs :), i get 'out of sync' messages on my monitor. I can switch
back to the X session properly using ctrl-alt-fx, but i can never get back
again my console.

The video card is a matrox G450, and I am using the vesa framebuffer.
(I know there's a seperate mga fb driver, but this should work for this
combination)

Is this a bug in the kernel fb code, or in X? Are there any workarounds?
How could I restore textmode?


Please help if you can,
-- 
Balazs Pozsar

