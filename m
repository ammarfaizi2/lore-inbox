Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268334AbUIXGaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268334AbUIXGaF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268490AbUIXG2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:28:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:33507 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268334AbUIXG0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:26:21 -0400
Subject: Re: [PATCH] matroxfb big-endian update (was Re: [PATCH] ppc64: Fix
	__raw_* IO accessors)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Roland Dreier <roland@topspin.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040923202601.GA6586@vana.vc.cvut.cz>
References: <1095761113.30931.13.camel@localhost.localdomain>
	 <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
	 <52mzzjnuq7.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
	 <1095816897.21231.32.camel@gaston> <20040922185851.GA11017@vana.vc.cvut.cz>
	 <1095900539.6359.46.camel@gaston> <20040923152530.GA9377@vana.vc.cvut.cz>
	 <20040923202601.GA6586@vana.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1096007137.4009.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 16:25:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 06:26, Petr Vandrovec wrote:
> Hi Andrew & Linus,
> 
> This change disconnects matroxfb accelerator endianess from processor endianess, plus
> ports big-endian accessors from __raw_xxx to xxx + appropriate byte swaps.

Applied to current bk, make oldconfig (FB_MATROX_BIG_ENDIAN_ACCEL is not set),
works like a charm on the ppc POWER3 I have here, haven't had a chance to
test X though.

Ben.


