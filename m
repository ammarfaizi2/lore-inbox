Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274830AbTHKT5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274833AbTHKT5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:57:06 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:57063 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S274830AbTHKT5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:57:03 -0400
Date: Mon, 11 Aug 2003 21:55:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Johannes Stezenbach <js@convergence.de>, Gerd Knorr <kraxel@bytesex.org>,
       Flameeyes <dgp85@users.sourceforge.net>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811195554.GR2627@elf.ucw.cz>
References: <1060616931.8472.22.camel@defiant.flameeyes> <20030811163913.GA16568@bytesex.org> <20030811175642.GC2053@convergence.de> <20030811185947.GA8549@ucw.cz> <20030811191709.GN2627@elf.ucw.cz> <20030811193401.GA8957@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811193401.GA8957@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > IMHO there's one problem:
> > > > 
> > > > If a remote control has e.g. a "1" key this doesn't mean that a user
> > > > wants a "1" to be written into your editor while editing source code.
> > > > The "1" key on a remote control simply has a differnt _meaning_ than
> > > > the "1" key on your keyboard -- depending of course on what the user
> > > > thinks this key should mean.
> > > 
> > > That's what BTN_1 is for. ;)
> > 
> > Ahha, I thought BTN_1 would be first mouse button ;-). Will fix that.
> 
> No, that'd be BTN_LEFT.

Okay, then what about this:

The control has keypad labeled 0..9 and at the same time it has arrows
on it (its meant for mouse emulation). Then it has keys DISPLAY/L, and
LOOP/R. If I mark DISPLAY/L as BTN_LEFT, will it be the "right thing"
(tm)?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
