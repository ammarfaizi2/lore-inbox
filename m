Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWGHRta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWGHRta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWGHRta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:49:30 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:54800 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964919AbWGHRta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:49:30 -0400
Date: Sat, 8 Jul 2006 19:49:28 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bojan Smojver <bojan@rexursive.com>, Jan Rychter <jan@rychter.com>,
       Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060708174928.GC36499@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Bojan Smojver <bojan@rexursive.com>, Jan Rychter <jan@rychter.com>,
	Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
	linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
	grundig <grundig@teleline.es>,
	Nigel Cunningham <ncunningham@linuxmail.org>
References: <20060627133321.GB3019@elf.ucw.cz> <20060707215656.GA30353@dspnet.fr.eu.org> <20060707232523.GC1746@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org> <20060708002826.GD1700@elf.ucw.cz> <m2d5cg1mwy.fsf@tnuctip.rychter.com> <1152353698.2555.11.camel@coyote.rexursive.com> <1152355318.3120.26.camel@laptopd505.fenrus.org> <20060708164312.GA36499@dspnet.fr.eu.org> <1152377246.3120.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152377246.3120.65.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 06:47:26PM +0200, Arjan van de Ven wrote:
> On Sat, 2006-07-08 at 18:43 +0200, Olivier Galibert wrote:
> > On Sat, Jul 08, 2006 at 12:41:58PM +0200, Arjan van de Ven wrote:
> > > Very often, choice is good. but for something this fundamental, it is
> > > not. We also don't have 2 scsi layers for example.
> > 
> > We have 2 ide layers, 2 usb-storage drivers, 2 sound systems and we
> > have had 2 pcmcia subsystems and 2 usb subsystems. 
> 
> well not sure about all of them... but it sucks.

- drivers/ide vs. Alan's libata work
- usb-storage vs. ub
- oss vs. alsa

And for the old ones:
- pcmcia-cs vs. Linus' yenta code
- the old usb stuff vs. Linus' rewrite

And I've forgottem v4l1 vs. v4l2 too.

> Just take the alsa/OSS case. It's taken Adrian Bunk a LOT of effort to
> get people to report bugs against alsa; unless you threaten to remove
> the other driver they just won't and switch to the other driver.

You're forgetting some inconvenient facts about alsa though:

- at least for a long while, they didn't care about compatibility
  between versions

- the interface is atrocious (shared library several orders of
  magnitude more complex than necessary, because KISS is not cool
  enough)

- the oss interface compatiblity has always been and still is
  considered a second class citizen

If the gpl-ification of the full OSS system had happened much earlier,
ALSA would have been crushed under its own weight by now.

  OG.
