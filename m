Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTIRTBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 15:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbTIRTBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 15:01:18 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:44748 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S262041AbTIRTBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 15:01:16 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200309181858.h8IIwRB5018673@wildsau.idv.uni.linz.at>
Subject: Re: sig11 is back: old troubles with new hardware
In-Reply-To: <20030916110733.A19900@bitwizard.nl>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Date: Thu, 18 Sep 2003 20:58:27 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, so what I'm saying is: try running the CPU as if it's an
> XP1800. If that works, you at least have a setup that works, but more
> importantly you also have a setup where you can work from trying to
> change things until it actually works at normal speed.
> 
> If you go to your shop now and tell them: "Linux crashes when I do
> this", they will reply: "Sure. So?". "Well linux doesn't normally 
> crash". "Oh.". You won't get a replacement anything this way. 

hi,

I'll Cc: this to linux-kernel because I think it is interesting
for others too. as it turned out, the board has problems.
not especially my board, but all of them.

you are right, it was something like that, blaming it on linux.
allthough they have been able to reproduce the error with a non-linux
memory tester, the still blamed parts of the error on linux (dorks!),
because they have sold a lot of board, and none ever complained about
them not working... "the error only appears only under extreme
situations", they said. ha. "mke2fs /dev/sdc3" is not an extreme
situation, I think.

anyway. the board in question is an "Asus A7n8x Deluxe". It has three
memory slots, colors "black blue blue" (from left to right).
Asus has admitted that the board *does* have problems with the black memory
slot in conjunction with the nForce chipset. they hope to provide
a BIOS-update which fixes the problems. I wonder when and how....*twiddles
thumbs*.

so, if you own a "Asus a7n8x deluxe", use the blue memory slots only (slots
2 and 3, "dual channel mode") --- and probably only with 400Mhz FSB DDRAMs,
at least rumors tell that Asus advises so.
if not, your system will crash, since linux pushes the hardware to its
limits :->



regards,
herbert rosmanith


