Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbSK3Sf7>; Sat, 30 Nov 2002 13:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267282AbSK3Sf7>; Sat, 30 Nov 2002 13:35:59 -0500
Received: from [195.223.140.107] ([195.223.140.107]:5037 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267281AbSK3Sf6>;
	Sat, 30 Nov 2002 13:35:58 -0500
Date: Sat, 30 Nov 2002 19:43:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: khromy <khromy@lnuxlab.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021130184317.GH28164@dualathlon.random>
References: <20021130013832.GF15682@jerry.marcet.dyndns.org> <Pine.LNX.4.50.0211292103200.26051-100000@montezuma.mastecende.com> <3DE82A4C.B8332D8E@digeo.com> <Pine.LNX.4.50.0211292306000.2495-100000@montezuma.mastecende.com> <20021130064807.GA20277@lnuxlab.ath.cx> <20021130064910.GD15426@jerry.marcet.dyndns.org> <20021130182345.GA21410@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021130182345.GA21410@lnuxlab.ath.cx>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2002 at 01:23:45PM -0500, khromy wrote:
> On Sat, Nov 30, 2002 at 07:49:10AM +0100, Javier Marcet wrote:
> > * khromy <khromy@lnuxlab.ath.cx> [021130 07:33]:
> > 
> > >BTW, I'm running 2.4.20-rc4-ac1+preempt and it seems to run good but
> > >whenever I leave for a few hours or wake up in the morning mozilla is
> > >swaped out.. Any idea when/how this might be fixed?
> > 
> > I have the problem without leaving it a few hours, but when I do it gets
> > definitely worse. Last vmstat output I quoted here showed around 256MB
> > swapped. A few hours later - the computer had been sitting idle, only
> > the mail server for three users was running which poses no overhead at
> > all -, the entire 512MB SWAP space was used. Why, I don't know.
> > 
> > I'm about to try 2.4.20-jam0, -aa derived. I'll post results from that
> > kernel later.
> 
> aa runs beautifully but it locked up once on me..

send me SYSRQ+T SYSRQ+P and everything else you know about it. if you
have AGP enabled try to reproduce with 10_x86-fast-pte-2 backed out.
thanks,

Andrea
