Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319336AbSHVMhC>; Thu, 22 Aug 2002 08:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319339AbSHVMhC>; Thu, 22 Aug 2002 08:37:02 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:53164 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319336AbSHVMhC>; Thu, 22 Aug 2002 08:37:02 -0400
Message-ID: <3D64BFCF.3070606@t-online.de>
Date: Thu, 22 Aug 2002 12:41:19 +0200
From: chris.schwemmer@t-online.de (Chris Schwemmer)
User-Agent: Mozilla/5.0 (Windows; U; Win98; de-AT; rv:1.0.0) Gecko/20020530
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Pressing numlock locks up PS/2 mouse and keyboard
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just finished with compiling a Linux system from source using gcc 3.2, 
glibc 2.5, kernel 2.4.19, binutils 2.13 and bash 2.05a running on an 
Athlon TB 1000 MHz, Asus A7V mainboard (VIA KT133 chipset), 384 MByte 
RAM. Now I noticed that when I use GPM and/or X and I press Numlock, 
then the mouse (PS/2 made by Logitech, 3 buttons, 3rd button is a wheel) 
stops working (the cursor disappears). When I kill GPM or X and start it 
again (PS/2 protocol), the keyboard stops working too. The log shows 
kernel messages saying 'unrecognized scancode (70), ignoring' or 
sometimes 'timeout - no AT keyboard connected?'. When I use the imps2 
protocol, keyboard and mouse stop working as soon as I start GPM for the 
first time, but now the keyboard produces wierd characters (e.g. + 
signs) on screen. This affects X without GPM and X with GPM in repeater 
mode, too.
I already tried kernel 2.4.18, disabling APM, changing device 
permissions, using other PS/2 mice and using another gpm binary from a 
system where it works. I checked the archives of this list and the gpm 
and X mailing list archives, and although there seemed to be similar 
problems in the past, I found no fix for my problem. I also asked on the 
gpm mailing list and on comp.os.linux.hardware, but so far no one can 
help me...
When I boot from a KNOPPIX cd (AFAIK only difference to my system: gcc) 
everything works, I can use both GPM and X without any problems. The 
Linux I had before on this PC worked ok, too, so the hardware is alright...
I also tried booting 2.4.13, but it won't boot, oopsing because of a 
null pointer reference and trying to kill init...

Any suggestions?
Thank you,
Chris

