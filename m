Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262199AbREQWmO>; Thu, 17 May 2001 18:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262204AbREQWmE>; Thu, 17 May 2001 18:42:04 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:21009 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262200AbREQWly>; Thu, 17 May 2001 18:41:54 -0400
Date: 17 May 2001 22:33:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <811oo7Xmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.21.0105151328160.2470-100000@penguin.transmeta.com>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.GSO.4.21.0105151607100.21081-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0105151328160.2470-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 15.05.01 in <Pine.LNX.4.21.0105151328160.2470-100000@penguin.transmeta.com>:

> They might also be exactly the same channel, except with certain magic
> bits set. The example peter gave was fine: tty devices could very usefully
> be opened with something like
>
> 	fd = open("/dev/tty00/nonblock,9600,n8", O_RDWR);
>
> where we actually open up exactly the same channel as if we opened up
> /dev/cua00, we just set the speed etc at the same time. Which makes things
> a hell of a lot more readable, AND they are again easily done from
> scripts. The above is exactly the kind of thing that UNIX has not done
> well, and some others have done better (let's face it, even _DOS_ did it
> better, for chrissake! Those callout devices and those ioctl's are a pain
> in the ass, for no really good reason).

Umm ... where to begin.

1. No, DOS didn't do it better - DOS devices were mostly a bad copy of  
Xenix devices.

2. DOS definitely didn't do it better for serial ports. Serial ports are  
the single most broken devices that DOS supports by default, so much so  
that literally *no* serious program that needed the serial ports used the  
built-in driver. Only toy programs did that. Because those drivers weren't  
anything but toys themselves.

I know this the hard way. I used serial ports under DOS for something like  
ten years.

MfG Kai
