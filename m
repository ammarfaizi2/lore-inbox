Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263615AbVBDNxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263615AbVBDNxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbVBDNxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:53:14 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:12334 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264168AbVBDNvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:51:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OqNesCX4zBzYJFMxRnjuH4VsCfK0gRsb1sBP5k2NLUUW2u9jgBFH0xBvw1UmOZvyoDpJgfLPdodT/ImGLfHtqCJslwL6F2Z5uWBnHuhWMPa9RVxCBkMQ3aenH/tqRgazcwa7Nz406n8FpRtoqY6bKtAcpxg+blWtW8uOzpUPQPQ=
Message-ID: <d120d50005020405513bcf709@mail.gmail.com>
Date: Fri, 4 Feb 2005 08:51:41 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-input@atrey.karlin.mff.cuni.cz,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050204131436.GC10424@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
	 <200501292307.55193.dtor_core@ameritech.net>
	 <Pine.LNX.4.61.0501301639171.30794@scrub.home>
	 <200501301839.37548.dtor_core@ameritech.net>
	 <20050204131436.GC10424@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 14:14:36 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Sun, Jan 30, 2005 at 06:39:37PM -0500, Dmitry Torokhov wrote:
> > On Sunday 30 January 2005 10:45, Roman Zippel wrote:
> > > Hi,
> > >
> > > On Sat, 29 Jan 2005, Dmitry Torokhov wrote:
> > >
> > > > Ok, what about making some submenus to manage number of options, like in
> > > > the patch below?
> > >
> > > I'd rather move it to the bottom and the menus had no dependencies.
> > > Below is an alternative patch, which does a rather complete cleanup.
> >
> > This one looks nice. I still think that hardware port support should go
> > first. My argument is:
> >
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
> 

I'd rather make a patch on top of Roman's, if you don't mind. This way
we will reduce merge conflicts (Sam I believe already grabbed Roman's
changes and applied to his tree).

-- 
Dmitry
