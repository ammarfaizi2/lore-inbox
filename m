Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265545AbUFON5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbUFON5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUFON5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:57:32 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:44928 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265545AbUFON4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:56:06 -0400
Date: Tue, 15 Jun 2004 13:56:05 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, Lubomir Prech <Lubomir.Prech@mff.cuni.cz>
Subject: Re: HID vs. Input Core
Message-ID: <20040615135605.B6090@beton.cybernet.src>
References: <20040615125800.B5811@beton.cybernet.src> <20040615134153.GA8625@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615134153.GA8625@hh.idb.hist.no>; from helgehaf@aitel.hist.no on Tue, Jun 15, 2004 at 03:41:53PM +0200
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 03:41:53PM +0200, Helge Hafting wrote:
> On Tue, Jun 15, 2004 at 12:58:00PM +0000, Karel Kulhavý wrote:
> > Hello
> > 
> > I would like to know what's the difference between
> > Input Core (CONFIG_INPUT) and USB HID (CONFIG_USB_HID) in 2.4.25
> > 
> > They seem to enable the same thing - USB HID. However I don't
> > know which one should I enable or if I should enable both. I find
> > existence of two options with seemingly the same function confusing.
> > 
> They aren't the same:
> 
> Enable CONFIG_INPUT if you want to use any input devices _at all_,
> i.e. if you plan on using some kind of keyboard, mouse, joystick, ...
> Enable CONFIG_USB_HID also, _if_ such a device might be connected
> via USB.  (Older devices are not USB, newer may be usb.)

Bugreport:

CONFIG_INPUT Help says
"Say Y here if you want to enable any of the following options for USB
Human Interface Device (HID) support".

Helge Hafting from linux-kernel says that CONFIG_INPUT controls enabling input devices at
all. These two statements are in a direct contradiction. (See above).

Cl<
> 
> Helge Hafting
