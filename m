Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSJVSNG>; Tue, 22 Oct 2002 14:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbSJVSMF>; Tue, 22 Oct 2002 14:12:05 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:35479 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264875AbSJVSKx>;
	Tue, 22 Oct 2002 14:10:53 -0400
Date: Tue, 22 Oct 2002 20:13:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Dreher <dreher@math.tu-freiberg.de>
Cc: Take Vos <Take.Vos@binary-magic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: PS/2 keyboard and mouse not available/working/weird
Message-ID: <20021022201336.A24258@ucw.cz>
References: <200210221603.54816.Take.Vos@binary-magic.com> <200210221428.QAA75603@delphin.mathe.tu-freiberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210221428.QAA75603@delphin.mathe.tu-freiberg.de>; from dreher@math.tu-freiberg.de on Tue, Oct 22, 2002 at 04:37:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 04:37:47PM +0200, Michael Dreher wrote:

> > In 2.5.44 both my PS/2 mice are not available, neither is my keyboard,
> > although after sufficient keystrokes, sometimes 5, sometimes more, the
> > keyboard is found, this is with Xfree.
> 
> Toggling CapsLock etc. does nothing to the LEDs. I can move the Mousepointer
> around with the PS/2 mouse, but I can not click. My USB mouse sort of works, 
> but only in one USB connector. Not the other. 
> 
> The box is a Sony Vaio Picturebook (japanese version). This was working in 
> 2.5.42.
> 
> If you need more info, just ask.

The 'dmesg' trace of the mouse and keyboard init with #define DEBUG
enabled in drivers/input/serio/i8042.c. Your XF86Config mouse-related
part. /proc/bus/usb/devices, /proc/bus/input/devices. Anything else you
deem relevant (exact Vaio model, exact mouse and usb devices models).

-- 
Vojtech Pavlik
SuSE Labs
