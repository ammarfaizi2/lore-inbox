Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbTBCKGT>; Mon, 3 Feb 2003 05:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTBCKGT>; Mon, 3 Feb 2003 05:06:19 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:42444 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S264962AbTBCKGS>; Mon, 3 Feb 2003 05:06:18 -0500
From: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
Organization: INFN
To: rbisping@mindspring.com
Subject: Re: yenta-cardbus IRQ0
Date: Mon, 3 Feb 2003 11:16:36 +0100
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <E18eXoy-0000iL-00@tisch.mail.mindspring.net> <32788.62.98.209.28.1044095590.squirrel@webmail.roma2.infn.it> <E18f9lN-0001RE-00@granger.mail.mindspring.net>
In-Reply-To: <E18f9lN-0001RE-00@granger.mail.mindspring.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200302031116.37035.gabrielli@roma2.infn.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03:16, domenica 2 febbraio 2003, Robert Bisping wrote:

> > >> last month and it keeps coming up with IRQ0 and telling me it cant
> > >> find a  irq for pin A. what would be causing this and how do I correct
> > >> it i have  already tried APCI and it does not work on my laptop so
> > >> that is no help. I  have compiled SMP into the kernel though I dont
> > >> have a dual processor (of  course) to gain the added functionality. I
> > >> have recompiled my kernel about  150 times with different setting
> > >> hoping it might just be a conflict in the  kernel with no luck.  I
> > >> looked at the yenta driver it's self and noticed that  it accepts IRQ0
> > >> as a valid irq but that appears to mean no irq at all. which  config
> > >> file would i use to force it to set a irq?
> > >>
> > >> > Thanx for any assistanc you might give
> > >>
> > >> plz send an lspci -vv -xxx -s *your dev*
> > >>
> > >> what kernel are you using ?
> > >
> > > i am using 2.4.18 and here is lspci
> >
> > uhmm, 1th try to upgrade to a newer one, then I experienced the same
> > problem with a custom board... the problem was triggered by the Base
> > Address too high:
> >
> >   Region 0: Memory at 10812000 (32-bit, non-prefetchable) [size=4K]
> >
> > moving id_sel (in the PCI core of the board) in order to obtain a lower
> > bar all worked.
> >
> >
> > BTW, has anybody there ever heared about such a costraint in the PCI
> > specification ?? Why I got this strange behaviour ???
>
> ok, can you give me some more specifics? i.e how do i do that or what
> howto/man etc. (not the kernel part the id_sel part) thanx

I think you can't do that if you are not able to put your hand in the HW.
There's nothing you can do from linux, that I know...

You can take a look to the PCI specification, but i don't think it will aid 
you so much...  

-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"

