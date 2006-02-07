Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWBGCSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWBGCSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWBGCSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:18:15 -0500
Received: from smtp.uaf.edu ([137.229.34.30]:62994 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S932441AbWBGCSO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:18:14 -0500
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: linux-kernel@vger.kernel.org
Subject: Re: What causes "USB disconnect" ?
Date: Mon, 6 Feb 2006 17:18:08 -0900
User-Agent: KMail/1.7.2
References: <Pine.LNX.4.64.0602062122480.5326@dyndns.pervalidus.net> <964857280602061706n72a9ebbeo9a1930f2b0993e0b@mail.gmail.com> <964857280602061812m748d19bew5ef0777e24359029@mail.gmail.com>
In-Reply-To: <964857280602061812m748d19bew5ef0777e24359029@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602061718.08473.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 17:12, Frédéric L. W. Meunier wrote:
> On 2/6/06, Frédéric L. W. Meunier wrote:
> > When it happened, his lights turned off. I pressed a button, but
> > nothing happened. Then, I ignored it and it returned after the minutes
> > you see from the log.
>
> It happened again. This, after an uptime of 3 days and a few hours.
>
> Feb  6 23:59:00 pervalidus kernel: usb 1-2: USB disconnect, address 5
> Feb  6 23:59:39 pervalidus kernel: usb 1-2: new low speed USB device
> using uhci_hcd and address 6
> Feb  6 23:59:40 pervalidus kernel: usb 1-2: configuration #1 chosen
> from 1 choice
> Feb  6 23:59:44 pervalidus kernel: input: Logitech Inc. WingMan
> RumblePad as /class/input/input5
> Feb  6 23:59:44 pervalidus kernel: input: USB HID v1.10 Joystick
> [Logitech Inc. WingMan RumblePad] on usb-0000:00:10.0-2
> Feb  6 23:59:44 pervalidus kernel: usb 1-2: USB disconnect, address 6
> Feb  6 23:59:47 pervalidus kernel: usb 1-2: new low speed USB device
> using uhci_hcd and address 7
> Feb  6 23:59:47 pervalidus kernel: usb 1-2: configuration #1 chosen
> from 1 choice
> Feb  6 23:59:57 pervalidus kernel:
> /usr/local/src/kernel/linux-2.6.16/drivers/usb/input/hid-core.c:
> timeout initializing reports
> Feb  6 23:59:57 pervalidus kernel: input: Logitech Inc. WingMan
> RumblePad as /class/input/input6
> Feb  6 23:59:57 pervalidus kernel: input: USB HID v1.10 Joystick
> [Logitech Inc. WingMan RumblePad] on usb-0000:00:10.0-2
>
> I changed it to other 2 ports and only see a
>
> Feb  7 00:09:10 pervalidus kernel: usb 1-2: USB disconnect, address 7
>
> Any way to know if this is the device's fault ?

I just saw this behavior on a USB keyboard/mouse combo the other day when I 
touched the case and discharged static electricity.  Nothing else was 
affected, but I saw the keyboard and mouse disconnect and then immediately 
reconnect.  Possibly an intolerant chipset or poorly grounded motherboard?

j----- k-----


-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
