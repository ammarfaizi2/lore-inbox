Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318917AbSH1TXR>; Wed, 28 Aug 2002 15:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318918AbSH1TXR>; Wed, 28 Aug 2002 15:23:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:34054 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S318917AbSH1TXQ>; Wed, 28 Aug 2002 15:23:16 -0400
Date: Wed, 28 Aug 2002 21:27:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [BUG] 2.5.30 swaps with no swap device mounted!!
Message-ID: <20020828192739.GB10487@atrey.karlin.mff.cuni.cz>
References: <20020827135421.A39@toy.ucw.cz> <Pine.LNX.4.44.0208280708020.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208280708020.3234-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It might be interesting to see what happens if you unplug the swap device 
> > > after umounting.
> > 
> > In the same way it might be interesting to see what happens if you put
> > cigarette into gasoline tank?
> 
> Well, you never know what unregistering does. It might happen to be 
> ignored for swap, once unregistered.

I guess it will crash and burn, I'd suggest at least unmounting all
filesystems prior to that test.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
