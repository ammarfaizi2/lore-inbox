Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289118AbSA1Nmr>; Mon, 28 Jan 2002 08:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289171AbSA1Nmh>; Mon, 28 Jan 2002 08:42:37 -0500
Received: from cp66906-a.roemd1.lb.nl.home.com ([213.51.11.249]:61069 "EHLO
	lx01.intranet.invantive.com") by vger.kernel.org with ESMTP
	id <S289101AbSA1NmZ>; Mon, 28 Jan 2002 08:42:25 -0500
Date: Mon, 28 Jan 2002 15:41:57 +0100
Message-Id: <200201281441.g0SEfvp08440@lx01.intranet.invantive.com>
From: "Guido Leenders" <guido.leenders@invantive.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Diego Calleja <grundig@teleline.es>,
        lkml <linux-kernel@vger.kernel.org>, <guido.leenders@invantive.com>
Subject: Re: PROBLEM: 2.4.17 crashes (VM bug?) after heavy system load
X-Mailer: NeoMail 1.25
X-IPAddress: 195.6.68.165
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Roy,

this is indeed the problem I find. Will try 18-pre7.

Regards,

Guido



> On Sun, 27 Jan 2002, Alan Cox wrote:
> 
> > > On 27 ene 2002, 22:49:17, Guido Leenders wrote:
> > > >
> > > > [1.] One line summary of the problem:
> > > >
> > > > Especially during times of heavy I/O, swapping and CPU 
processing, the
> > > > OS crashes with an Oops.
> > > I think andrea's patches should be applied into stable mainline 
NOW.
> >
> > Its up to Andrea to break up his patches and feed them to Marcelo 
as he
> > has been asked. It also won't make any odds to this trace I suspect.
> >
> > Trying 2.4.18pre7 or applying the LRU patch to 2.4.17 that Ben 
LaHaise did
> > should sort most of the 2.4.17 crashes out
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-
kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> What makes Andrea's patches better than Rik's?
> 
> My recent problem with the vm was easily solved with rmap.
> 
> See http://karlsbakk.net/dev/kernel/vm-fsckup.txt for more info
> 
> roy
> 
> --
> Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> 
> Computers are like air conditioners.
> They stop working when you open Windows.
> 
> 

-- 
NeoMail - Webmail that doesn't suck... as much.
http://neomail.sourceforge.net
