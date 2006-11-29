Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967177AbWK2OEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967177AbWK2OEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967185AbWK2OEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:04:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28177 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S967177AbWK2OEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:04:11 -0500
Date: Wed, 29 Nov 2006 13:57:04 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Airlie <airlied@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Adam Jackson <ajax@nwnk.net>,
       Arjan van de Ven <arjan@infradead.org>,
       Casey Dahlin <cjdahlin@ncsu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Overriding X on panic
Message-ID: <20061129135704.GB4769@ucw.cz>
References: <1164434093.10503.2.camel@localhost.localdomain> <1164443561.3147.54.camel@laptopd505.fenrus.org> <20061125161043.18f1b68d@localhost.localdomain> <1164529121.3147.65.camel@laptopd505.fenrus.org> <20061126142213.52c292d3@localhost.localdomain> <21d7e9970611261419s12da9881h1f19adcf11756769@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970611261419s12da9881h1f19adcf11756769@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> for the Intel hw Keith doesn't seem to think it's all 
> >that much of a
> >> problem though...
> >
> >Including the TV out, odder LCD panels, non BIOS modes 
> >etc ? If so then
> >it might be an interesting test case for intelfb to 
> >grow some kind of
> >console helper interface
...
> I personally think we need to probably just bite the 
> bullet and start
> sticking graphics drivers into the kernel, the new 
> randr-1.2 interface
> for X is probably a good starting point for a generic 
> mode setting
> interface that isn't so X dependent and could replace 
> fbdev with
> something more sane wrt dualhead and multiple outputs... 
> fbdev could
> be implemented on top of that layer then.. also 
> suspend/resume really
> needs this sort of thing....

Yes, pretty please...

> My main worry with integrating graphics drivers into the 
> kernel is
> that when they don't work the user gets no screen, with 
> network/sound
> etc this isn't so bad, but if they can't see a screen 
> debugging gets
> to be a bit more difficult....

You can have my hgc card + monitor if it helps :-). Okay, it is old
ISA, so it probably does not, but with serial or netconsole debugging
should be doable, no?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
