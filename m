Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288565AbSANB3A>; Sun, 13 Jan 2002 20:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288568AbSANB2u>; Sun, 13 Jan 2002 20:28:50 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36615 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288565AbSANB2i>; Sun, 13 Jan 2002 20:28:38 -0500
Date: Sun, 13 Jan 2002 20:28:29 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020109115859.C4902@borg.org>
Message-ID: <Pine.LNX.3.96.1020113202508.17441L-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Kent Borg wrote:

> How does all this fit into doing a tick-less kernel?
> 
> There is something appealing about doing stuff only when there is
> stuff to do, like: respond to input, handle some device that becomes
> ready, or let another process run for a while.  Didn't IBM do some
> nice work on this for Linux?  (*Was* it nice work?)  I was under the
> impression that the current kernel isn't that far from being tickless.
> 
> A tickless kernel would be wonderful for battery powered devices that
> could literally shut off when there be nothing to do, and it seems it
> would (trivially?) help performance on high end power hogs too.
> 
> Why do we have regular HZ ticks?  (Other than I think I remember Linus
> saying that he likes them.)  

Feel free to quantify the savings over the current setup with max power
saving enabled in the kernel. I just don't see how "wonderful" it would
be, given that an idle system currently uses very little battery if you
setup the options to save power.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

