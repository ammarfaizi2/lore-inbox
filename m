Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263309AbSJCMq1>; Thu, 3 Oct 2002 08:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSJCMq1>; Thu, 3 Oct 2002 08:46:27 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:37084 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263309AbSJCMqZ>;
	Thu, 3 Oct 2002 08:46:25 -0400
Date: Thu, 3 Oct 2002 14:51:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Portnoy <portnoy@tellink.net>
Cc: Tobias Ringstrom <tori@ringstrom.mine.nu>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021003145142.A38898@ucw.cz>
References: <Pine.LNX.4.44.0210030846180.11746-100000@boris.prodako.se> <Pine.LNX.4.44.0210030847200.24905-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210030847200.24905-100000@localhost.localdomain>; from portnoy@tellink.net on Thu, Oct 03, 2002 at 08:48:19AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 08:48:19AM -0400, Jon Portnoy wrote:

> Reproduced with an AT keyboard here, too.

I know where the problem is now - it's pressing two keys, one with
scancode 'e0 xx', the other 'yy' where xx == yy at the same time. 

Now I'm looking for a nice clean way to fix it.

> On Thu, 3 Oct 2002, Tobias Ringstrom wrote:
> 
> [snip]
> > 
> > If I press and hold my left Alt key, press and release the right AltGr
> > key, and then release the left Alt key, I get one of the following
> > messages in dmesg:
> > 
> > atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
> [snip]
> > 
> > The left Alt key is now stuck until I press and release it again.
> > 
> > The same thing happens for a few other combinations as well. I happens 
> > both in X and in the console.
> > 
> > Please let me know if you need more info.
> > 
> > /Tobias

-- 
Vojtech Pavlik
SuSE Labs
