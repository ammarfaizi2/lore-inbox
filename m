Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265809AbUFOSHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUFOSHS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUFOSHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:07:17 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:26755 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265809AbUFOSGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:06:54 -0400
Date: Tue, 15 Jun 2004 20:07:38 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org,
       Lubomir Prech <Lubomir.Prech@mff.cuni.cz>
Subject: Re: HID vs. Input Core
Message-ID: <20040615180738.GA2200@ucw.cz>
References: <20040615125800.B5811@beton.cybernet.src> <20040615134153.GA8625@hh.idb.hist.no> <20040615135605.B6090@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615135605.B6090@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 01:56:05PM +0000, Karel Kulhavý wrote:
> On Tue, Jun 15, 2004 at 03:41:53PM +0200, Helge Hafting wrote:
> > On Tue, Jun 15, 2004 at 12:58:00PM +0000, Karel Kulhavý wrote:
> > > Hello
> > > 
> > > I would like to know what's the difference between
> > > Input Core (CONFIG_INPUT) and USB HID (CONFIG_USB_HID) in 2.4.25
> > > 
> > > They seem to enable the same thing - USB HID. However I don't
> > > know which one should I enable or if I should enable both. I find
> > > existence of two options with seemingly the same function confusing.
> > > 
> > They aren't the same:
> > 
> > Enable CONFIG_INPUT if you want to use any input devices _at all_,
> > i.e. if you plan on using some kind of keyboard, mouse, joystick, ...
> > Enable CONFIG_USB_HID also, _if_ such a device might be connected
> > via USB.  (Older devices are not USB, newer may be usb.)
> 
> Bugreport:
> 
> CONFIG_INPUT Help says
> "Say Y here if you want to enable any of the following options for USB
> Human Interface Device (HID) support".
> 
> Helge Hafting from linux-kernel says that CONFIG_INPUT controls enabling input devices at
> all. These two statements are in a direct contradiction. (See above).
 
In 2.4 the only devices (well, except joysticks) using the input core
are USB HID devices.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
