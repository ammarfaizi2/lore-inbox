Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263948AbRFSHgs>; Tue, 19 Jun 2001 03:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263958AbRFSHgi>; Tue, 19 Jun 2001 03:36:38 -0400
Received: from web10407.mail.yahoo.com ([216.136.130.99]:21774 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263948AbRFSHg2>; Tue, 19 Jun 2001 03:36:28 -0400
Message-ID: <20010619073627.14718.qmail@web10407.mail.yahoo.com>
Date: Tue, 19 Jun 2001 17:36:27 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: 2.4 VM & swap question
To: Mike Galbraith <mikeg@wen-online.de>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106190725040.576-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an information for you to compare, now I am
running the kernel compile from mandrake 80; version
2.4.3-20mdk on a 
machine Intel celeron 400Mhz 128M RAM, i810 graphic
card (it will use some memory) ; runing together
Star Office 5.2, Netscape 4.77, Mozilla (shiped with
LM80), compiling alsa driver and you may guess how
much swap it used?

[sk@steve sk]$ free
             total       used       free     shared   
buffers     cached
Mem:        126108     124416       1692          0   
    604      51820
-/+ buffers/cache:      71992      54116
Swap:        72288          0      72288

Okay I dont have any other *bloated* software to run
and try to crash it :-)

The same situation when I ran 2.4.5-acx (try all with
13, 14, 15) swap usage is about 45Mb and it is
increasing by the time). After typing a while in
netscpae email form , netscape eats memory gradually
(or the kernel?) swap ran out and the machine went to
deadlock even without thrashing)

But now it is NOT increasing ( I am typing in yahoo
mail from netscape too) , the system is up for about 3
days.

Regards,


--- Mike Galbraith <mikeg@wen-online.de> wrote: > On
Mon, 18 Jun 2001, root wrote:
> 
> > Regarding to the discussion on the swap size,
> >
> > Recently, Rick van Riel posted a message that
> there is a bug
> > related to "reclaiming" the swap, and said that it
> is on his
> > TODO list.
> 
> That's fixed.
> 
> > If I believe it, the current trouble we have
> regarding to the swap
> > size is not because we do not have a sufficient
> size for the swap,
> > but because there is a bug, although Linus advised
> us to assign
> > 2 times the physical memory for the swap.
> 
> Please try 2.4.6.pre3.  (folks with various load
> types should do this
> and report results.. even if it generates a brief
> spurt of traffic).
> 
> 	-Mike
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


=====
S.KIEU

_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!
