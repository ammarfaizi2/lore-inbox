Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbSKURRk>; Thu, 21 Nov 2002 12:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbSKURRk>; Thu, 21 Nov 2002 12:17:40 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:26129 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266907AbSKURRi>; Thu, 21 Nov 2002 12:17:38 -0500
Date: Thu, 21 Nov 2002 17:24:44 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrey Panin <pazke@orbita1.ru>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Q] is framebuffer console code in 2.5.4x functional ?
In-Reply-To: <20021120094654.GA319@pazke.ipt>
Message-ID: <Pine.LNX.4.33.0211210753100.9540-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > > console doesn't show a single pixel.
> > 
> > :-( Can you post your .config file. 
> 
> Attached.

Hm. Strange. It should work. Can you get serial console working? 
  
> I did some changes to sgivwfb.c to make it compilable, patch attached.
> Can you take a look at it ?

Applied your patch to the BK tree. 
 
> > I will be posting a new fbdev patch today against 2.5.48 today. Giev it a 
> > try.
> 
> Didn't see proposed fbdev patch yet :(

    Sorry about that. You are not the only one that has asked me. Also I 
keep getting lots of error reports about drivers being broken. The problem 
is having enough time. For example I haven't found the time to create this 
patch. This brings up a serious point which I have been wrestling with. The 
framebuffer layer has been broken for a long time durning the 2.5.X cycle. 
The problem is both maintainers of this subsystem, Geert and I, both have 
very little time to work on it. For both of us we don't work on the 
framebuffer code for a living. I work with wireless networking cards. I 
work 8 hours a day on networking code and travel 3 hours total every day 
to work. Including eating a sleeping and I have at most 1 to 2 hours a day 
to work on the framebuffer stuff. Weekends I have to do other survial 
things like buy food. So the framebuffer developement has gone at a 
snail pace and will continue to do so unless things change. I estimate 
about 20+ more versions before the framebuffer layer properly works. 
    It pains me that this is happening. I really enjoy working on the 
framebuffer and console layer. So I have been thinking about what to 
do ? One which is the most likely is to step down from maintaintership 
and hope someone else who can devote there full time and energy to it 
can take over. Will someone else take over? I seriously doubt it. We all 
have to make a living and that means working on things the linux industry 
cares about which is only server stuff. So I except the framebuffer layer 
will go into serious code decay. So the best situtation which I except to 
happen is that I finish as much as I can for the fbdev layer and then 
step down. 
    I have tried to look for work locallly (can't really affored to move 
cross country very few years) relating to the framebuffer layer. In my 
search I only found one company that seemed interested in this developement, 
strangeberry (http://www.strangeberry.com). I sent them my resume but 
never heard from them. As for funding I serious doubt that would happen 
since it isn't server related. The reality is for proper maintiance of any 
subsystem you need people hired to solely work to keep it going. 
Unfortunely the framebuffer layer is one of those few ones that doesn't 
have that.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net


