Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266037AbTLIPWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266038AbTLIPWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:22:00 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:21754 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S266037AbTLIPV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:21:57 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Stian Jordet <liste@jordet.nu>
Subject: Re: sensors vs 2.6
Date: Tue, 9 Dec 2003 10:21:42 -0500
User-Agent: KMail/1.5.1
Cc: Sebastian Kaps <seb-keyword-linux.637a6e@toyland.sauerland.de>,
       linux-kernel@vger.kernel.org
References: <200312090258.01944.gene.heskett@verizon.net> <200312090741.31290.gene.heskett@verizon.net> <1070981656.26479.7.camel@chevrolet.hybel>
In-Reply-To: <1070981656.26479.7.camel@chevrolet.hybel>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091021.42283.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.57.120] at Tue, 9 Dec 2003 09:21:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 09:54, Stian Jordet wrote:
>tir, 09.12.2003 kl. 13.41 skrev Gene Heskett:
>> I have this:
>> -----------------------
>> [root@coyote linux-2.6]# grep I2C .config
>> # I2C support
>> CONFIG_I2C=y
>> CONFIG_I2C_CHARDEV=y
>> # I2C Algorithms
>> CONFIG_I2C_ALGOBIT=y
>> # CONFIG_I2C_ALGOPCF is not set
>> # I2C Hardware Bus support
>> # CONFIG_I2C_ALI1535 is not set
>> # CONFIG_I2C_ALI15X3 is not set
>> # CONFIG_I2C_AMD756 is not set
>> # CONFIG_I2C_AMD8111 is not set
>> # CONFIG_I2C_I801 is not set
>> # CONFIG_I2C_I810 is not set
>> # CONFIG_I2C_NFORCE2 is not set
>> # CONFIG_I2C_PHILIPSPAR is not set
>> # CONFIG_I2C_PIIX4 is not set
>> # CONFIG_I2C_PROSAVAGE is not set
>> # CONFIG_I2C_SAVAGE4 is not set
>> # CONFIG_I2C_SIS5595 is not set
>> # CONFIG_I2C_SIS630 is not set
>> # CONFIG_I2C_SIS96X is not set
>> CONFIG_I2C_VIA=y
>> CONFIG_I2C_VIAPRO=y
>> # CONFIG_I2C_VOODOO3 is not set
>> # I2C Hardware Sensors Chip support
>> CONFIG_I2C_SENSOR=y
>
>You seem to be missing support for a sensor chip.

That wasn't covered by this: ??

[root@coyote linux-2.6]# grep SENSORS .config
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_EEPROM=y
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_W83781D=y

I just rebuilt, but haven't rebooted to test it yet, a kernel without 
the VIA686 stuff just in case that was getting in the way.  I should 
reboot and see what I've got now.

>
>Best regards,
>Stian

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

