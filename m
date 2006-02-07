Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWBGOmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWBGOmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWBGOmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:42:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21772 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965097AbWBGOmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:42:37 -0500
Date: Tue, 7 Feb 2006 15:42:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ulrich Mueller <ulm@kph.uni-mainz.de>
Cc: Bernd Petrovitsch <bernd@firmix.at>, Herbert Poetzl <herbert@13thfloor.at>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Arjan van de Ven <arjan@infradead.org>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: RFC: add an ADVANCED_USER option
Message-ID: <20060207144236.GH5937@stusta.de>
References: <43E3DB99.9020604@rtr.ca> <Pine.LNX.4.61.0602041204490.30014@yvahk01.tjqt.qr> <1139153913.3131.42.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0602052212430.330@yvahk01.tjqt.qr> <1139174355.3131.50.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0602061554550.31522@yvahk01.tjqt.qr> <20060207004147.GA21620@MAIL.13thfloor.at> <1139305085.13091.17.camel@tara.firmix.at> <20060207121955.GD5937@stusta.de> <17384.43328.181493.272871@a1i15.kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17384.43328.181493.272871@a1i15.kph.uni-mainz.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 03:05:52PM +0100, Ulrich Mueller wrote:
> >>>>> On Tue, 7 Feb 2006, Adrian Bunk wrote:
> 
> > What we could do is to add an additional ADVANCED_USER option that
> > hides options like VMSPLIT or the NAPI options for net drivers.
> 
> > config ADVANCED_USER
> > 	bool "ask questions that require a deeper knowledge of the kernel"
> 
> > config EXPERIMENTAL
> > 	bool "Prompt for development and/or incomplete code/drivers"
> > 	depends on ADVANCED_USER
> 
> Shouldn't this be the other way around, i.e. ADVANCED_USER depending
> on EXPERIMENTAL?

No, if there's a dependency between the two, then in this direction.

> If you implement it as above, people will set ADVANCED_USER to "n" in
> oldconfig and then be surprised that all experimental drivers are
> gone.

What about no dependency between ADVANCED_USER and EXPERIMENTAL?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

