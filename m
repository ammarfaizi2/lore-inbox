Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310862AbSBRQ63>; Mon, 18 Feb 2002 11:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310867AbSBRQ6U>; Mon, 18 Feb 2002 11:58:20 -0500
Received: from [217.89.50.104] ([217.89.50.104]:57870 "EHLO
	NOTES.INTERCOPE.COM") by vger.kernel.org with ESMTP
	id <S310862AbSBRQ6K>; Mon, 18 Feb 2002 11:58:10 -0500
Subject: Dual Athon Rocks!!! (was :Re: A7M266-D works?)
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.6a  January 17, 2001
Message-ID: <OFA27E733D.512B7DA6-ONC1256B64.005B1A4A@INTERCOPE.COM>
From: "Michael Kwasigroch" <mkwasigr@intercope.com>
Date: Mon, 18 Feb 2002 17:55:15 +0100
X-MIMETrack: Serialize by Router on ICHH1G02/INTERCOPE/DE(Release 5.0.3 (Intl)|21 March
 2000) at 18.02.2002 17:57:22
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

you all might know that already, but http://www.2cpu.com has all the
information one need to know to run a dual athlon system succesfully.

I've bought the Tyan Tiger S2466N which is very similar to the Asus
A7M266-D but has one 32-Bit PCI slot more, and it has got an onboard 3com
10/100 Mbit NIC.

To make it run with a 2.2.19 Linux Kernel get 2.2.19 and patch it with the
io_apic.c-patch from the latest 2.2.20-pre (or use 2.2.20 ;-). Otherwise it
will lock up due to interrupts being not correctly routed by the APIC chip.
Please note that there is currently no way to switch the onboard IDE to
anything UDMA-ish. Kernel 2.2.x will only be able to use the slow PIO-mode
due to the lack of a usable ide-patch for the onboard Viper-7441 IDE
controller.

Because of this all of you would definitely use 2.4.17 and get the latest
ide-patch from www.linux-ide.org. With that patch I was able to switch
onboard IDE to ATA33, although my hard drives are UDMA5 (ATA100). I'm
pretty sure I can push it to ATA100, although I don't care, since this
thing is so damn fast already (I'm running two Athlon MP 1800+ with 512 MB
of RAM). 2.4.18 should have the patch included...

It builds a Linux kernel (bzImage + modules) in 85 seconds!!! And yes: I'm
having around 6100 BogoMips! Not bad for a system worth around 2200 Euro...


P.S.: Please cc me directly on any replies since I'm not subscribed to
linux-kernel. TIA.


Mit freundlichen Gruessen / best regards


"The sooner you fall behind, the more time you'll have to catch up."

Michael Kwasigroch
FaxPlus/Open Development
________________________________________

e-mail:        mkwasigr@intercope.com

INTERCOPE
International Communication Products Engineering GmbH

www.intercope.com


