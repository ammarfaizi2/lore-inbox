Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267920AbUGaJeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267920AbUGaJeH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267922AbUGaJeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:34:06 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:26246 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S267920AbUGaJdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:33:22 -0400
Date: Sat, 31 Jul 2004 11:34:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Kristian H?gsberg <krh@bitplanet.net>,
       Olav Kongas <olav@enif.ee>
Subject: Re: input system: EVIOCSABS(abs) ioctl disabled, why?
Message-ID: <20040731093445.GB1579@ucw.cz>
References: <Pine.LNX.4.58.0407281453560.16069@serv.enif.ee> <20040728134313.GB4831@ucw.cz> <410B0486.6060706@bitplanet.net> <200407302354.25041.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407302354.25041.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 11:54:25PM -0500, Dmitry Torokhov wrote:
> On Friday 30 July 2004 09:31 pm, Kristian H?gsberg wrote:
> > Vojtech Pavlik wrote:
> > > On Wed, Jul 28, 2004 at 03:41:28PM +0300, Olav Kongas wrote:
> > > 
> > > 
> > >>When trying to feed calibration information to a touchscreen driver with
> > >>the EVIOCSABS(abs) ioctl command, I noticed that this command is disabled
> > >>in 2.6.7. Only after the modification given in the patch below it was
> > >>possible to use this ioctl command.
> > >>
> > >>Why is the EVIOCSABS command disabled? I cannot imagine that nobody uses
> > > 
> > > 
> > > It's a bug. I'll fix it.
> > 
> > On a related note - shouldn't there also be a EVIOCSLED, or am I missing 
> > something obvious?  How do you set keyboard LEDs?
> > 
> 
> I think you can use KDSKBLED/KDSETLED ioctls, but I agree that that evdev
> should also provide access to the same functions.
 
It does, see my previous e-mail.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
