Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUBOPEH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbUBOPEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:04:07 -0500
Received: from colossus.systems.pipex.net ([62.241.160.73]:32977 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264941AbUBOPEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:04:02 -0500
Message-ID: <402F8A5F.5060902@emergence.uk.net>
Date: Sun, 15 Feb 2004 15:03:59 +0000
From: Jonathan Brown <jbrown@emergence.uk.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc3
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org> <m2znbk4s8j.fsf@p4.localdomain>
In-Reply-To: <m2znbk4s8j.fsf@p4.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
>>Benjamin Herrenschmidt:
>>  o New radeonfb
>>  o Fix a link conflict between radeonfb and the radeon DRI
>>  o Fix incorrect kfree in radeonfb
> 
> 
> It doesn't seem to work on my x86 laptop. The screen goes black when
> the framebuffer is enabled early in the boot sequence. The machine
> boots normally anyway and I can log in from the network or log in
> blindly at the console. I can then start the X server which appears to
> work correctly, but switching back to a console still gives me a black
> screen. Running "setfont" doesn't fix it. Here is what dmesg reports
> when running 2.6.3-rc3:

I also get a black screen on boot on my IBM X31, but pressing Fn+F7 a 
couple of times brings it up. Fn+F7 switches between LCD, monitor and 
both. Here is my dmesg:

radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=144.00 Mhz, 
System=144.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1024x768
radeonfb: detected LVDS panel size from BIOS: 1024x768
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon LY  DDR SGRAM 16 MB
