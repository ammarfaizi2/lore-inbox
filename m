Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbSKORbj>; Fri, 15 Nov 2002 12:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266512AbSKORbj>; Fri, 15 Nov 2002 12:31:39 -0500
Received: from trillium-hollow.org ([209.180.166.89]:47748 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S266514AbSKORbf>; Fri, 15 Nov 2002 12:31:35 -0500
To: Willy Tarreau <willy@w.ods.org>
cc: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Crooke <dave@convio.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dual athlon XP 1800 problems 
In-Reply-To: Your message of "Fri, 15 Nov 2002 18:19:51 +0100."
             <20021115171951.GB553@alpha.home.local> 
Date: Fri, 15 Nov 2002 10:38:05 -0800
From: erich@uruk.org
Message-Id: <E18ClLx-0001F8-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Willy Tarreau <willy@w.ods.org> wrote:

> On Fri, Nov 15, 2002 at 02:40:20PM +0000, Dave Jones wrote:
> > On Fri, Nov 15, 2002 at 02:54:48PM +0000, Alan Cox wrote:
> >  > Make sure you have a current BIOS on dual athlon boxes, the earlier
> >  > bioses were not terribly good on the whole. Make sure you have a PS/2
> >  > mouse in the mouse port even if you aren;t going to use it
> > 
> > Unless he's lucky with steppings, it's also possible he's being
> > bitten by running XP's instead of MPs.
> 
> BTW, since I've upgraded my Asus bios, my 2 XP1800 are reported as MP1800.
> There's absolutely no way for me to tell that they're in fact XPs, except
> from dismounting the cooling fans and read the chips. Although they're quite
> stable even at very high temperatures (I could compile a complete kernel with
> fans unplugged, but the case was as hot as a pizza oven), I know that there
> are people out there with unstable dual XP setups and I frankly don't know
> how they could tell that they're XP if their reseller sold them as MPs and
> installed the fan himself.

I have the ASUS A7M266-D board with 2 XP1800 as well with the same issue
(though it reported them as MP with the early and the later BIOS).

The deal here was that the early steppings of the XP processors,
through about the 1800 series, which didn't have the "MP disable" bridge
cut.  When they released the 1900's and higher, this was changed, but
you can still find XP 1800's and lower which just appear as MP processors.

However, the machine runs rock stable with the stock i686 patch kernel
from RedHat on a 350W power supply (I even tweaked the voltages down quite
a bit to get the processors to run cooler, works great).

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
