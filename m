Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbTI0VKV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 17:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTI0VKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 17:10:21 -0400
Received: from gprs144-234.eurotel.cz ([160.218.144.234]:43648 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262187AbTI0VKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 17:10:18 -0400
Date: Sat, 27 Sep 2003 23:09:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, akpm@osdl.org,
       petero2@telia.com, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
Message-ID: <20030927210948.GA360@elf.ucw.cz>
References: <10645086121286@twilight.ucw.cz> <200309251323.33416.dtor_core@ameritech.net> <20030925223032.GA32130@ucw.cz> <200309260224.54264.dtor_core@ameritech.net> <20030926075408.GA7330@ucw.cz> <20030927201951.GA401@elf.ucw.cz> <20030927210504.GA18178@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030927210504.GA18178@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > One thing I tried to avoid is a 'device class' kind of field, that'd
> > > tell if a device is a mouse a touchpad, touchscreen, tablet, whatever.
> > > I tried to avoid it because there are devices that don't fall into any
> > > predefined class and if we make enough classes, someone someday will
> > > make a device that won't fit again.
> > 
> > I believe having "is overlaid over screen" bit gets it right :-).
> 
> Tablets aren't. And they're handled the same way as touchscreens.

Ouch, so what's the difference between tablet and touchpad? Is it only
in a way you are expected to use it? In such case "this is touchpad"
bit is probably needed :-(.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
