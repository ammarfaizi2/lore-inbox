Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270821AbTHAPfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 11:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270831AbTHAPfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 11:35:00 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:45980 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S270821AbTHAPe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 11:34:58 -0400
Subject: Re: 2.6.0-test1/2: keyboard funnies in textmode
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030801145223.GA3308@win.tue.nl>
References: <1059747945.2809.2.camel@paragon.slim>
	 <20030801145223.GA3308@win.tue.nl>
Content-Type: text/plain
Message-Id: <1059752011.2691.13.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-1) 
Date: 01 Aug 2003 17:33:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-01 at 16:52, Andries Brouwer wrote:

> Can you give some details?
> 
> - When did it last work?

OK, I no longer have compiled 2.5 kernels installed, only 2.6.0-test1/2.
I can only say it does work normally under 2.4.x.
 
> - What does it mean: "am unable to use"?
> (Is the key ignored? Does the system crash? Do you get different keycodes?)
On the laptop with Japanese keyboard the Yen/Pipe key is totally dead.
On the regular PC with USB keyboard only the backslash works. 

How can I check keycodes while in textmode?

> - What are the boot messages about the keyboard?
> 
Very annoying, I can't type dmesg | grep keyboard while in textmode..:-(
But from X:

>From the laptop (2.6.0-test1):
input: PS/2 Generic Mouse on isa0060/serio4
input: AT Set 2 keyboard on isa0060/serio0

>From the PC (2.6.0-test2):
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on
usb-0000:00:1d.1-2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.1-2

> The pipe key is the same as the backslash key (say, on a US keyboard).
> And there is some interesting confusion between Yen and Backslash
> (since ASCII and JIS-Roman coincide, except in the yen and overbar
> positions, where ASCII has backslash and tilde).
> So, I am not surprised by weird things on a Japanese keyboard.
> Do you use scancode Set 3?
Above shows Set 2 for the laptop. I can't tell for the PC.

Cheers,

Jurgen

