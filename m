Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281865AbRLLUPC>; Wed, 12 Dec 2001 15:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281877AbRLLUOn>; Wed, 12 Dec 2001 15:14:43 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:27894 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S281865AbRLLUOf>;
	Wed, 12 Dec 2001 15:14:35 -0500
Date: Wed, 12 Dec 2001 21:14:27 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: FBdev remains in unusable state
In-Reply-To: <BCDCADB4194@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.4.30.0112122108150.17543-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Dec 2001, Petr Vandrovec wrote:
> On 12 Dec 01 at 19:49, Pozsar Balazs wrote:
> >
> > The video card is a matrox G450, and I am using the vesa framebuffer.
> > (I know there's a seperate mga fb driver, but this should work for this
> > combination)
>
> No. vesafb does not work together with mga driver in X (although
> I believe that vesafb works with XFree mga driver, only Matrox driver
> is binary bad citizen).

I don't clearly understand you. I am using mga driver which is in the
official xfrr86 release.

> > Is this a bug in the kernel fb code, or in X? Are there any workarounds?
> > How could I restore textmode?
>
> Neither. X restore R/W registers to their previous values, while write-only
> registers to their values for normal text mode. Yes, there is a
> 'workaround'. Use (much faster) matroxfb.

What if setting those W-only registers to their appropiate values on
console-switches?
Why isn't it done by the vesafb driver?
How is the mga fb driver handle handling this situation better?


ps: My problem is that I have to use exactly the same kernel on different
machines, and I need fb. If not all machines have mga, than mga fb is
no-go.

thanks,
-- 
Pozsar Balazs

