Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbTBBCMV>; Sat, 1 Feb 2003 21:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbTBBCMU>; Sat, 1 Feb 2003 21:12:20 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:16910 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S265097AbTBBCMU>; Sat, 1 Feb 2003 21:12:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Robert Bisping <rbisping@mindspring.com>
Reply-To: rbisping@mindspring.com
To: "Emiliano Gabrielli" <emiliano.gabrielli@roma2.infn.it>
Subject: Re: yenta-cardbus IRQ0
Date: Sat, 1 Feb 2003 21:16:22 -0500
X-Mailer: KMail [version 1.3.2]
References: <E18eXoy-0000iL-00@tisch.mail.mindspring.net> <E18ejGW-0000bd-00@maynard.mail.mindspring.net> <32788.62.98.209.28.1044095590.squirrel@webmail.roma2.infn.it>
In-Reply-To: <32788.62.98.209.28.1044095590.squirrel@webmail.roma2.infn.it>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E18f9lN-0001RE-00@granger.mail.mindspring.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 February 2003 05:33, Emiliano Gabrielli wrote:
> <quote who="Robert Bisping">
>
> > On Friday 31 January 2003 08:50, you wrote:
> >> <quote who="Robert Bisping">
> >>
> >> > i have been trying to set up a cardbus card on my thinkpad 760ED for
> >> > about  the
> >>
> >> last month and it keeps coming up with IRQ0 and telling me it cant find
> >> a  irq for pin A. what would be causing this and how do I correct it i
> >> have  already tried APCI and it does not work on my laptop so that is no
> >> help. I  have compiled SMP into the kernel though I dont have a dual
> >> processor (of  course) to gain the added functionality. I have
> >> recompiled my kernel about  150 times with different setting hoping it
> >> might just be a conflict in the  kernel with no luck.  I looked at the
> >> yenta driver it's self and noticed that  it accepts IRQ0 as a valid irq
> >> but that appears to mean no irq at all. which  config file would i use
> >> to force it to set a irq?
> >>
> >> > Thanx for any assistanc you might give
> >>
> >> plz send an lspci -vv -xxx -s *your dev*
> >>
> >> what kernel are you using ?
> >
> > i am using 2.4.18 and here is lspci
>
> uhmm, 1th try to upgrade to a newer one, then I experienced the same
> problem with a custom board... the problem was triggered by the Base
> Address too high:
>
>   Region 0: Memory at 10812000 (32-bit, non-prefetchable) [size=4K]
>
> moving id_sel (in the PCI core of the board) in order to obtain a lower bar
> all worked.
>
>
> BTW, has anybody there ever heared about such a costraint in the PCI
> specification ?? Why I got this strange behaviour ???
ok, can you give me some more specifics? i.e how do i do that or what 
howto/man etc. (not the kernel part the id_sel part) thanx
