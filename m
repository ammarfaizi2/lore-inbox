Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbRFEEcW>; Tue, 5 Jun 2001 00:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbRFEEcM>; Tue, 5 Jun 2001 00:32:12 -0400
Received: from smtp7.xs4all.nl ([194.109.127.133]:22753 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S263212AbRFEEcF>;
	Tue, 5 Jun 2001 00:32:05 -0400
From: thunder7@xs4all.nl
Date: Mon, 4 Jun 2001 20:31:39 +0200
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (lkml)2.4.5-ac7 usb-uhci appears twice in /proc/interrupts
Message-ID: <20010604203139.A8060@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <Pine.LNX.4.33.0106040258200.2088-100000@portland.hansa.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106040258200.2088-100000@portland.hansa.lan>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2001 at 03:07:56AM -0400, Pavel Roskin wrote:
> Hello!
> 
> I don't know, maybe it's Ok, but it looks confusing - usb-uhci is listed
> twice on the same IRQ 9.
> 
My Abit VP6 (VIA694) says in dmesg:

usb.c: registered new driver hub
uhci.c: USB UHCI at I/O 0xa000, IRQ 19
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: USB UHCI at I/O 0xa400, IRQ 19
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c:  Linus Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti Fliegl, Thomas Sailer, Roman Weissgaerber
uhci.c: USB Universal Host Controller Interface driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.

And more, if I read the handbook I get an adapter to get another two usb
plugs at the backside. So yes, this motherboard has 2 usb controllers.

I think it is okay - you may want to check your own manual.

Good luck,
Jurriaan
-- 
BOFH excuse #131:

telnet: Unable to connect to remote host: Connection refused
GNU/Linux 2.4.5-ac7 SMP/ReiserFS 2x1402 bogomips load av: 0.00 0.00 0.00
