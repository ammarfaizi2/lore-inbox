Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269432AbRHMVHo>; Mon, 13 Aug 2001 17:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269782AbRHMVHf>; Mon, 13 Aug 2001 17:07:35 -0400
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:42489 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S269432AbRHMVHW>; Mon, 13 Aug 2001 17:07:22 -0400
Date: Mon, 13 Aug 2001 17:07:38 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Are we going too fast?
Message-ID: <Pine.LNX.4.20.0108131656470.1037-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > of them have suffered from one malady or another - from the dual PIII with
> > the VIA chipset and Matrox G400 card, which locks up nicely when I switch
> 
> Welcome to wacky hardware. To get a G400 stable on x86 you need at least
> 
> XFree86 4.1 if you are running hardware 3D (and DRM 4.1)

I run 4.1.0 on that system.  DRM, I don't believe, is currently enabled,
though I'd like it to be.

> 2.4.8 or higher with the VIA fixes

Oooooh.  So .8 *does* have fixes for VIA... I think I'll give that a try now.

> Preferably a very recent BIOS update for the VIA box

Hmm.  I'll also check VIA to see if they have any updates for this system.
Thanks for the suggestion.

> Of those only the XFree hardware 3d stuff is software bug related.

I'm not currently using 3D - yet the system insists on locking up when I
switch from X to a text console and back.  Again, this only occurs with an
SMP kernel (this is an SMP system).  This does NOT occur with a uniprocessor
kernel.

> > emergency sync) when attempting to use 'ls' on a mounted QNX filesystem
> > (ls comes up fine, then system crashes - nothing sent to syslog, no errors
> > on screen, nothing!) - and this latest is with 2.4.8!
> 
> The qnxfs code is experimental - so I can believe it might fail in 2.4. I'd
> be very interested in info on that one.

Unfortunately, that's all the info I have.  Console switching was still
working, so I tried enabling logging to a console - no output.  System just
hangs.  Any suggestions on what I might try to get more information for you?

> > Should development continue on the latest and supposedly greatest
> > drivers?  Or should the existing bugs be fixed first?  I've got at least
> > three up there that need taking care of, and I'm sure others on this list
> > have found more.  3 seperate crashes on 3 seperate installs on 3 seperate
> > boxes - that's 100% failure rate.  If I get 100% failure on my installs,
> > what are others seeing?
> 
> Near enough 0%. But then I try and avoid buying broken chipsets.

I wasn't aware VIA nor Matrox were broken.  I've seen someone else mention in
this thread that perhaps some old HOWTOs on hardware need to be maintained
again - I think I agree with that.

> > I like Linux.  I'd like to stick with it.  But if it's going to
> > continually crash, I'm going to jump ship - and I'll start recommending to
> 
> If you want maximum stability you want to be running 2.2 or even 2.0. Newer
> less tested code is always less table. 2.4 wont be as stable as 2.2 for a
> year yet.

Perhaps series name should be changed from 'stable' to something else - 
'release'?

> Alan


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.


