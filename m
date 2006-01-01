Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWAALuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWAALuj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 06:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWAALuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 06:50:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58639 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751338AbWAALui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 06:50:38 -0500
Date: Sun, 1 Jan 2006 12:50:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bradley Reed <bradreed1@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Message-ID: <20060101115038.GR3811@stusta.de>
References: <20051231202933.4f48acab@galactus.example.org> <1136106861.17830.6.camel@laptopd505.fenrus.org> <20060101115121.034e6bb7@galactus.example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060101115121.034e6bb7@galactus.example.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 11:51:21AM +0200, Bradley Reed wrote:
> On Sun, 01 Jan 2006 10:14:21 +0100
> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > On Sat, 2005-12-31 at 20:29 +0200, Bradley Reed wrote:
> > > I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today
> > > and they all work fine under 2.6.14 and 2.6.14-rt21/22.
> > > 
> > > I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault
> > > on every video I try and play. Yes, I have nvidia modules loaded,
> > > so won't get much help, but thought someone might like to know. 
> > 
> > 
> > you know, you could have done a little bit more effort and reproduced
> > this without the binary crud... it's not that hard you know and it
> > shows that you actually care about the problem enough that you want
> > to make it worthwhile for people to look into it.
> > 
> 
> And you could have saved the time and effort of replying, as you had
> nothing useful to say. Why do you expect kernel users (non-developers) 
> to jump through hoops and cripple their systems in order to provide bug
> reports? Exactly how could I have tested MPLayer realistically without
> Xv support? It isn't that easy to swap video cards in a laptop.
>...

MPlayer has more than enough output drivers including some that work 
without the nvidia module.

If your problem was an RTC one, it might have even trigger using the 
AAlib output driver.

> DO YOU REALLY PREFER USERS NOT REPORT BUGS?

There are _many_ new bug reports every day and too few developers with 
too few spare time to go through all of them.

A binary-only module can do _anything_ even at module load time, and 
_noone_ except people with access to the source code can debug such 
problems.

Many developers know how it feels if after spending hours on debugging a 
problem someone reported it turned out "oh, it goes away if I remove the 
nvidia/vmware/... module".

It usually takes two parties to get a bug found:

A developer willing to look into it and a user willing to provide any 
assistance for the developer.

The latter might include 10 reboots with different kernel patches 
applied, and compared to that it's not a big issue to boot in these 
cases without binary-only modules ever loaded. Your system might be 
crippled, but only for the time you are helping the developer to 
identify your problem.

> Brad

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

