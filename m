Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbTBQXdE>; Mon, 17 Feb 2003 18:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbTBQXdD>; Mon, 17 Feb 2003 18:33:03 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3844 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267725AbTBQXci>;
	Mon, 17 Feb 2003 18:32:38 -0500
Date: Sun, 16 Feb 2003 22:28:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: [2.5] EHCI HID keyboard not unloaded at reboot time ?
Message-ID: <20030216212801.GA2546@elf.ucw.cz>
References: <1045324980.1767.28.camel@rousalka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045324980.1767.28.camel@rousalka>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	This is a question related to :
> http://bugzilla.kernel.org/show_bug.cgi?id=9
> 
> 	Basically I have a usb keyboard plugged on an external USB2 hub. Using
> a monolithic ehci/hid kernel I can get it to work in 2.5. It's also used
> in usb1 mode by the bios and the bootloader.
> 
> 	However when I shut down or reboot from 2.5, I loose keyboard support
> in the bios/bootloader/linux 2.4 (used to loose it in linux 2.5 also but
> recent ehci enhancements enable 2.5 to recover it). Nothing short of a
> PSU stop (neither reset nor stop button works) will recover it.

Well, if reset does not work, it looks like hw bug ;-). OTOH this
might be quite easy to workaround in sw. What happens if you unplug
and replug the keyboard?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
