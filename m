Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264131AbRFHQVf>; Fri, 8 Jun 2001 12:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFHQVY>; Fri, 8 Jun 2001 12:21:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18962 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264131AbRFHQVO>; Fri, 8 Jun 2001 12:21:14 -0400
Date: Fri, 8 Jun 2001 18:20:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [driver] New life for Serial mice
Message-ID: <20010608182046.H13825@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010606125556.A1766@suse.cz> <20010606232133.E38@toy.ucw.cz> <20010608181521.A1998@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010608181521.A1998@suse.cz>; from vojtech@suse.cz on Fri, Jun 08, 2001 at 06:15:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > If you still have your 3-button MouseSystems (or any other serial) mouse
> > > somewhere in your driver, forgotten becase of the incredibly slow update
> > > rate causing so much jumping of the pointer on the screen that it is
> > > unusable, you may want to pull it out and give it a try.
> > > 
> > > Or if you're still using it with some old 486 computer, this driver is
> > > for you. 
> > > 
> > > What it does is that it enhances the update rate from 24 (with current
> > > GPM and X drivers) to 96. This is almost what the best USB mice do.
> > 
> > What's the "prediction" stuff? Does it mean you are guessing some values
> > by interpolation?
> 
> Extrapolation, yes.

Can't it make mouse jump forward and back when user suddenly stops?

> > [If so, what kind of update rate would it do on USB?]
> 
> It wouldn't make any difference - on USB you always get whole packets,
> while over serial port the data is processed byte by byte and thus we
> know a little of the information before the whole packet arrives.

Ouch, nice trick!
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
