Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265630AbRF1K5u>; Thu, 28 Jun 2001 06:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265634AbRF1K5k>; Thu, 28 Jun 2001 06:57:40 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:22918 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S265630AbRF1K5b>;
	Thu, 28 Jun 2001 06:57:31 -0400
Date: Thu, 28 Jun 2001 12:57:26 +0200
From: David Weinehall <tao@acc.umu.se>
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: lar@cs.york.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Message-ID: <20010628125726.F4301@khan.acc.umu.se>
In-Reply-To: <JKEGJJAJPOLNIFPAEDHLKECBDEAA.laramie.leavitt@btinternet.com> <Pine.LNX.3.96.1010628105039.30572A-100000@medusa.sparta.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.3.96.1010628105039.30572A-100000@medusa.sparta.lu.se>; from bjorn@sparta.lu.se on Thu, Jun 28, 2001 at 11:19:37AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 11:19:37AM +0200, Bjorn Wesen wrote:
> On Thu, 28 Jun 2001, Laramie Leavitt wrote:
> > > dmesg buffer space is rather limited and IMHO there isn't space to
> > > waste on credit-giving in boot logs.
> > 
> > Here here.  You don't see annoying log-eating copyright messages
> > printed out in the Windows boot. Just imagine:
> 
> There's a difference; someone paid for that Windows code and you paid to
> get windows and don't care about who did what. But when someone puts down
> a lot of work to contributes something for free which others find useful
> and actually use, don't you think it might be prudent to let them at least
> write who contributed it, if a line is going to be printed anyway to say
> device that or that has been registred ?
> 
> I know it sounds a bit like an "advertisment space" but it's always been
> so; people have been releasing code for free since noone knows how long
> and often one major factor has been that their peers will go "wow did
> you do that". Otherwise why would anyone ever write their name in an About
> box when they release a freeware program. And dmesg is the Linux kernels
> About box (someone might argue that the code is the about box but
> unfortunately most people dont read the headers in every .c file they
> use).
> 
> See the old BSD license - distribution-wise it's more free than the GPL
> but you still had to give credit where credit is due when getting a free
> lunch from someone elses work (I think this requirement was dropped in the
> current BSD license)
> 
> The risk is that some people might take it quite personally to get their
> names removed and might not be as interested to see their code in the
> kernel in the future. Of course as long as it's GPL nothing would stop it
> anyway, but I still think it's a good idea to give credit for others hard
> work.

tao@tictac$ grep "^N:" CREDITS | sed -e "s/N: //" | wc
    392     863    5916

Add a little for (c) xxxx and other stuff, and you're getting close
to the size of the dmesg-buffer. Is it worth it?

Now, I can't claim to be 100% innocent; my name appears in the procinfo
for at least one MCA-driver. This will be remedied in due time, I can
assure you. I hope others follow my example.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
