Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbTBDA7N>; Mon, 3 Feb 2003 19:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbTBDA7N>; Mon, 3 Feb 2003 19:59:13 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:54285 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S267076AbTBDA7M>; Mon, 3 Feb 2003 19:59:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Robert Bisping <rbisping@mindspring.com>
Reply-To: rbisping@mindspring.com
To: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
Subject: Re: yenta-cardbus IRQ0
Date: Mon, 3 Feb 2003 20:03:41 -0500
X-Mailer: KMail [version 1.3.2]
References: <E18eXoy-0000iL-00@tisch.mail.mindspring.net> <E18f9lN-0001RE-00@granger.mail.mindspring.net> <200302031116.37035.gabrielli@roma2.infn.it>
In-Reply-To: <200302031116.37035.gabrielli@roma2.infn.it>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E18frZq-0003TC-00@barry.mail.mindspring.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 February 2003 05:16, you wrote:
> On 03:16, domenica 2 febbraio 2003, Robert Bisping wrote:
> > > >> last month and it keeps coming up with IRQ0 and telling me it cant
> > > >> find a  irq for pin A. what would be causing this and how do I
> > > >> correct it i have  already tried APCI and it does not work on my
> > > >> laptop so that is no help. I  have compiled SMP into the kernel
> > > >> though I dont have a dual processor (of  course) to gain the added
> > > >> functionality. I have recompiled my kernel about  150 times with
> > > >> different setting hoping it might just be a conflict in the  kernel
> > > >> with no luck.  I looked at the yenta driver it's self and noticed
> > > >> that  it accepts IRQ0 as a valid irq but that appears to mean no irq
> > > >> at all. which  config file would i use to force it to set a irq?
> > > >>
> > > >> > Thanx for any assistanc you might give
> > > >>
> > > >> plz send an lspci -vv -xxx -s *your dev*
> > > >>
> > > >> what kernel are you using ?
> > > >
> > > > i am using 2.4.18 and here is lspci
> > >
> > > uhmm, 1th try to upgrade to a newer one, then I experienced the same
> > > problem with a custom board... the problem was triggered by the Base
> > > Address too high:
> > >
> > >   Region 0: Memory at 10812000 (32-bit, non-prefetchable) [size=4K]
> > >
> > > moving id_sel (in the PCI core of the board) in order to obtain a lower
> > > bar all worked.
> > >
> > >
> > > BTW, has anybody there ever heared about such a costraint in the PCI
> > > specification ?? Why I got this strange behaviour ???
> >
> > ok, can you give me some more specifics? i.e how do i do that or what
> > howto/man etc. (not the kernel part the id_sel part) thanx
>
> I think you can't do that if you are not able to put your hand in the HW.
> There's nothing you can do from linux, that I know...
>
> You can take a look to the PCI specification, but i don't think it will aid
> you so much...
when I reformated my drive for linux i lost the ibm configuration utilities 
for windows and havent been able to get them back any other suggestions or 
how do i get to the bios froma floppy with a thinkpad 760ed.

thanx
