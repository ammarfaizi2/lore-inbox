Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUFONjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUFONjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265539AbUFONjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:39:04 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:12044 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261300AbUFONjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:39:02 -0400
Date: Tue, 15 Jun 2004 15:41:53 +0200
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HID vs. Input Core
Message-ID: <20040615134153.GA8625@hh.idb.hist.no>
References: <20040615125800.B5811@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615125800.B5811@beton.cybernet.src>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 12:58:00PM +0000, Karel Kulhavý wrote:
> Hello
> 
> I would like to know what's the difference between
> Input Core (CONFIG_INPUT) and USB HID (CONFIG_USB_HID) in 2.4.25
> 
> They seem to enable the same thing - USB HID. However I don't
> know which one should I enable or if I should enable both. I find
> existence of two options with seemingly the same function confusing.
> 
They aren't the same:

Enable CONFIG_INPUT if you want to use any input devices _at all_,
i.e. if you plan on using some kind of keyboard, mouse, joystick, ...
Enable CONFIG_USB_HID also, _if_ such a device might be connected
via USB.  (Older devices are not USB, newer may be usb.)

Helge Hafting
