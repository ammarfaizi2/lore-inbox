Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130128AbQLPW00>; Sat, 16 Dec 2000 17:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130371AbQLPW0Q>; Sat, 16 Dec 2000 17:26:16 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130128AbQLPWZh>;
	Sat, 16 Dec 2000 17:25:37 -0500
Message-ID: <20001215235738.J9506@bug.ucw.cz>
Date: Fri, 15 Dec 2000 23:57:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@wirex.com>, "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
In-Reply-To: <3A3623C6.B2499D4D@haque.net> <Pine.LNX.4.30.0012120929270.6172-100000@viper.haque.net> <20001212181339.F2602@storm.local> <20001212135803.A1148@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001212135803.A1148@wirex.com>; from Greg KH on Tue, Dec 12, 2000 at 01:58:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Someone gave me a really awesome idea about possibly using a palm pilot
> > > to capture the oops. Anyone know if it will be a problem using
> > > /dev/ttyUSB0 as the serial port?
> > 
> > The driver itself has to provide support for serial console.  If the USB
> > serial driver doesn't (I don't know) it won't work.  Check the config
> > options for USB serial, if it doesn't offer an option for console on USB
> > serial port then you're out of luck.
> > 
> > Unless the USB serial driver in some strange way hooks into the standard
> > serial driver, but then someone more knowledgeable should answer that
> > question.
> 
> Nope, it doesn't specifically support the CONFIG_SERIAL_CONSOLE with all
> of the register_console code, etc., so this will not work, sorry.
> 
> But it's something that I would gladly take a patch for :)

Forget it. It is almost impossible, unless you can do usb without
interrupts. (You can't).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
