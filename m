Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264210AbVBDOCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbVBDOCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbVBDOCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:02:03 -0500
Received: from styx.suse.cz ([82.119.242.94]:4333 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S264450AbVBDN6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:58:17 -0500
Date: Fri, 4 Feb 2005 14:58:34 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-input@atrey.karlin.mff.cuni.cz,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
Message-ID: <20050204135834.GA12191@ucw.cz>
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home> <200501292307.55193.dtor_core@ameritech.net> <Pine.LNX.4.61.0501301639171.30794@scrub.home> <200501301839.37548.dtor_core@ameritech.net> <20050204131436.GC10424@ucw.cz> <d120d50005020405513bcf709@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005020405513bcf709@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 08:51:41AM -0500, Dmitry Torokhov wrote:
> On Fri, 4 Feb 2005 14:14:36 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Sun, Jan 30, 2005 at 06:39:37PM -0500, Dmitry Torokhov wrote:
> > > On Sunday 30 January 2005 10:45, Roman Zippel wrote:
> > > > Hi,
> > > >
> > > > On Sat, 29 Jan 2005, Dmitry Torokhov wrote:
> > > >
> > > > > Ok, what about making some submenus to manage number of options, like in
> > > > > the patch below?
> > > >
> > > > I'd rather move it to the bottom and the menus had no dependencies.
> > > > Below is an alternative patch, which does a rather complete cleanup.
> > >
> > > This one looks nice. I still think that hardware port support should go
> > > first. My argument is:
> > >
> > > When I go into a menu I explore option and submenus from top to bottom.
> > > So I will see PS/2 or serial, and will go there and select what I need.
> > > Then I will see that generic input layer is also needed for keyboard
> > > and go there.
> > >
> > > If generic layer is first one I select options I think are needed I could
> > > skip over the HW I/O ports thinking that I already selected everything I
> > > need as far as keyboard/mouse goes.
> > >
> > > Does this make any sense?
> > 
> > Dmitry, will you make a patch that has the port options first? If no,
> > I'll likely merge Roman's patch.
> > 
> 
> I'd rather make a patch on top of Roman's, if you don't mind. This way
> we will reduce merge conflicts (Sam I believe already grabbed Roman's
> changes and applied to his tree).
 
No problem with that. Shall I apply Roman's patch then?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
