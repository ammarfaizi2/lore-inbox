Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTEIHNO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTEIHNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:13:14 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:36060 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S262318AbTEIHNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:13:13 -0400
Message-ID: <3EBB57FC.2020107@wmich.edu>
Date: Fri, 09 May 2003 03:25:48 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030318
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Felix von Leitner <felix-kernel@fefe.de>
Subject: Re: 2.5.69: VIA IDE still broken
References: <20030508220910.GA1070@codeblau.de> <20030509002408.GB4328@kroah.com>
In-Reply-To: <20030509002408.GB4328@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Amazing: the only hardware components in my machine that actually work
>as expected with recent Linux 2.5 kernels are the network cards, the RAM
>and the keyboard, and I had to replace a tulip card with an eepro100 for
>that.  Even the CPU appears to run too hot with Linux, causing the
>system to boot spontaneously under load, and because ACPI is terminally
>broken in Linux and has been every time I tried it, I can't do much
>about it.  Firewire does not like me (modprobe eth1394 -> oops), IDE
>loses interrupts (see above), my USB mouse stops working as soon as I
>plug in my USB hard disk (which works fine on my notebook and under
>Windows), using my IDE CD-R causes the machine to freeze while cdrecord
>does OTP, finalizing or eject.  The nvidia graphics card takes major
>patching to work at all with X, and all of these components are
>well-known brand components from tier 1 suppliers that were chosen for
>reliability and market penetration over price.  I envy people who can
>still evangelize Linux under circumstances like this.  I sure as hell
>can not.

that's funny. I'm using a via board with a tulip card with acpi with usb 
and with the via ide controller and with an ide cdr and all of it works 
PERFECTLY (2.5.69 is the first 2.5 kernel which has been as good with 
all my hardware as 2.4.2x) and there are no errors generated and 
everything is working very responsively which is nice for a change.   I 
dont have anything that does firewire so i cant say much about that. I 
have an nvidia card but it's on the P4 box which uses an intel 
motherboard so it's not very useful here.  But my matrox card is running 
  better than with any other kernel according to x11perf. I also have a 
wintv card working perfectly and sblive dido.

The fact that you're having cooling problems causing reboots leads me to 
believe that this is a hardware related problem due to either poor 
construction or insufficient cooling and it's going to be really hard to 
debug problems when you have overheating problems seeing as how 
overheating causes random crap to occur. And even if you did fix the 
cooling you may have already caused irreversible damage to components on 
the motherboard or in the cpu-itself. It's easy to still back linux with 
cases like this because they're not indicative of the kernel overall or 
even in an obvious way.

I for one am extremely pleased with 2.5.69 as it is much more stable 
than 2.3.x kernels were as they approached 2.4.x.  It's user-land 
software that i'm currently fighting with as it takes userland a long 
time to catch up to the latest kernel and with big api changes like no 
more proc i2c interface i've gotta go without some programs (procmeter) 
for sensor data (which works 100% with sysfs).  That and the fact that 
userland really hates bug reports when you're using an odd numbered 
kernel (samba).


