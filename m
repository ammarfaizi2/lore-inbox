Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263064AbSJBMHu>; Wed, 2 Oct 2002 08:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263066AbSJBMHu>; Wed, 2 Oct 2002 08:07:50 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:59045 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263064AbSJBMHs>;
	Wed, 2 Oct 2002 08:07:48 -0400
Date: Wed, 2 Oct 2002 14:07:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Daniel Phillips <phillips@arcor.de>
cc: Jens Axboe <axboe@suse.de>, Rik van Riel <riel@conectiva.com.br>,
       Richard.Zidlicky@stud.informatik.uni-erlangen.de,
       Roman Zippel <zippel@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 mm trouble [possible lru race]
In-Reply-To: <E17wRXo-0005vk-00@starship>
Message-ID: <Pine.GSO.4.21.0210021406550.10060-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Daniel Phillips wrote:
> On Tuesday 01 October 2002 20:04, Jens Axboe wrote:
> > On Tue, Oct 01 2002, Daniel Phillips wrote:
> > > On Tuesday 01 October 2002 19:31, Jens Axboe wrote:
> > > > Again, m68k was the target.
> > > 
> > > Sure fine, no good reason to be cryptic about it though.
> > > 
> > >    #error "m68k doesn't do SMP yet"
> > > 
> > > So SMP must be off or the compile would abort.  Well, the only interesting
> > 
> > There's no CONFIG_SMP in the m68k arch config.in. Anyways, enough
> > beating of dead horse :)
> 
> The horse isn't dead yet, it's still twitching a little.  At this
> point we still need to speculate about wny anyone would want an SMP
> Dragonball machine ;-)

Dragonballs don't have an MMU, so they would run uClinux/m68k, not Linux/m68k.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

