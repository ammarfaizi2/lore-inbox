Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVBDOOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVBDOOF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265616AbVBDOOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:14:05 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:30929 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265465AbVBDONr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:13:47 -0500
Date: Fri, 4 Feb 2005 15:13:31 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
In-Reply-To: <20050204131436.GC10424@ucw.cz>
Message-ID: <Pine.LNX.4.61.0502041511540.6118@scrub.home>
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
 <200501292307.55193.dtor_core@ameritech.net> <Pine.LNX.4.61.0501301639171.30794@scrub.home>
 <200501301839.37548.dtor_core@ameritech.net> <20050204131436.GC10424@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 4 Feb 2005, Vojtech Pavlik wrote:

> > When I go into a menu I explore option and submenus from top to bottom.
> > So I will see PS/2 or serial, and will go there and select what I need.
> > Then I will see that generic input layer is also needed for keyboard
> > and go there.
> > 
> > If generic layer is first one I select options I think are needed I could
> > skip over the HW I/O ports thinking that I already selected everything I
> > need as far as keyboard/mouse goes.
> > 
> > Does this make any sense?
> 
> Dmitry, will you make a patch that has the port options first? If no,
> I'll likely merge Roman's patch.

I don't think that putting this first is a good idea, compare it to scsi 
or alsa, which also have the generic options first and then the lowlevel 
drivers.

bye, Roman
