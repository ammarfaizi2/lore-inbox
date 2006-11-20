Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934061AbWKTLu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934061AbWKTLu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934066AbWKTLu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:50:29 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:63666 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S934061AbWKTLu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:50:29 -0500
Message-ID: <45619678.5070400@gmail.com>
Date: Mon, 20 Nov 2006 12:50:16 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Ram <vshrirama@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB Mouse does not work, please advice
References: <8bf247760611200316y761fa18dg4bdfc55e90b70309@mail.gmail.com>
In-Reply-To: <8bf247760611200316y761fa18dg4bdfc55e90b70309@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> Hi,
>   Im using Linux 2.6.13 for PXA270.
> 
> 
>  I have connected a mouse and the mouse is detected.
> 
>  When i do dmesg, i get the
> 
> usb 1-1: new low speed USB device using pxa27x-ohci and address 10
> DEV: registering device: ID = '1-1'
> bus usb: add device 1-1
> bound device '1-1' to driver 'usb'
> DEV: registering device: ID = '1-1:1.0'
> bus usb: add device 1-1:1.0
> usb: Matched Device 1-1:1.0 with Driver usbhid
> input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-pxa27x-1
> bound device '1-1:1.0' to driver 'usbhid'
> usb: Bound Device 1-1:1.0 to Driver usbhid
> 
> When i do 'cat /proc/bus/input/devices': I get the message
> 
> 
> [root@Linux /]#cat /proc/bus/input/devices
> I: Bus=0003 Vendor=046d Product=c001 Version=2010
> N: Name="Logitech USB Mouse"
> P: Phys=usb-pxa27x-1/input0
> H: Handlers= event0
> B: EV=7
> B: KEY=70000 0 0 0 0 0 0 0 0
> B: REL=103
> 
> 
> 
> The Handler field has only event0, But my mouse is not working?.

Where -- console (check your gpm conf) or X (check X conf, do you use evdev)?
[Does cat -A /dev/input/event0 output during mouse movement something?]

> Please provide pointers to solve the problem.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
