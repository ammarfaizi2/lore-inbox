Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269188AbUIYBnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269188AbUIYBnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269187AbUIYBlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:41:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:1259 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269181AbUIYBky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:40:54 -0400
Subject: Re: [PATCH] matroxfb big-endian update (was Re: [PATCH] ppc64: Fix
	__raw_* IO accessors)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040924095348.GA30132@vana.vc.cvut.cz>
References: <523c1bpghm.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
	 <52mzzjnuq7.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
	 <1095816897.21231.32.camel@gaston> <20040922185851.GA11017@vana.vc.cvut.cz>
	 <1095900539.6359.46.camel@gaston> <20040923152530.GA9377@vana.vc.cvut.cz>
	 <20040923202601.GA6586@vana.vc.cvut.cz> <1096007137.4009.38.camel@gaston>
	 <20040924095348.GA30132@vana.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1096076414.12931.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 25 Sep 2004 11:40:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 19:53, Petr Vandrovec wrote:

> XFree 3.x did not touch BE mode bit and accessed MMIO directly with pointer 
> dereference (expecting firmware to put card into BE mode?), while XFree 4.x (if
> I understand code properly) does not touch BE bit on primary device
> (while it clears it on secondary devices) while expecting hardware to be
> in LE mode...
> 
> So I'm either confused, or XF3 needs BE_ACCEL set while XF4 needs BE_ACCEL
> disabled.  Does anybody actually use matroxfb with XFree server on PPC (or any
> other BE machine) at all?

People here tend to put a radeon card in their pSeries and forget about
the matrox one it seems :) I'll have a look next week.

Ben.


