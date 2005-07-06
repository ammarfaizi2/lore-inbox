Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVGFX3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVGFX3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVGFX1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:27:45 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:31136 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262563AbVGFX1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:27:07 -0400
Date: Wed, 6 Jul 2005 16:27:01 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: dwalker@mvista.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Documentation fixes
Message-Id: <20050706162701.20614562.rdunlap@xenotime.net>
In-Reply-To: <1120691531.16159.42.camel@dhcp153.mvista.com>
References: <1120691531.16159.42.camel@dhcp153.mvista.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2005 16:12:11 -0700 Daniel Walker wrote:

| 
| I noticed some typo's or mis-thoughts .. Here are my corrections. I
| tried to CC all the authors.

Yes, mostly good corrections.  Here are more on top of yours.

Thanks,
~Randy


| Index: linux-2.6.12/Documentation/watchdog/watchdog.txt
| ===================================================================
| --- linux-2.6.12.orig/Documentation/watchdog/watchdog.txt	2005-06-17 19:48:29.000000000 +0000
| +++ linux-2.6.12/Documentation/watchdog/watchdog.txt	2005-07-03 18:12:40.000000000 +0000
| @@ -18,12 +18,12 @@ The following watchdog drivers are curre
|  All six interfaces provide /dev/watchdog, which when open must be written
|  to within a timeout or the machine will reboot. Each write delays the reboot
|  time another timeout. In the case of the software watchdog the ability to 
| -reboot will depend on the state of the machines and interrupts. The hardware
| +reboot will depend on the state of the machine and interrupts. The hardware
|  boards physically pull the machine down off their own onboard timers and
|  will reboot from almost anything.
|  
|  A second temperature monitoring interface is available on the WDT501P cards
| -and some Berkshire cards. This provides /dev/temperature. This is the machine 
| +and some Berkshire cards. This provides /dev/temperature. This is the machines 
                                                                         machine's
  (and kill the trailing space)

|  internal temperature in degrees Fahrenheit. Each read returns a single byte 
|  giving the temperature.
|  
| @@ -37,16 +37,16 @@ The wdt card cannot be safely probed for
|  wdt=ioaddr,irq as a boot parameter - eg "wdt=0x240,11".
|  
|  The SA1100 watchdog module can be configured with the "sa1100_margin"
| -commandline argument which specifies timeout value in seconds.
| +commandline argument which specifies the timeout value in seconds.
|  
|  The i810 TCO watchdog modules can be configured with the "i810_margin"
| -commandline argument which specifies the counter initial value. The counter
| -is decremented every 0.6 seconds and default to 50 (30 seconds). Values can
| +commandline argument which specifies the counters initial value. The counter
                                            counter's
| +is decremented every 0.6 seconds and defaults to 50 (30 seconds). Values can
|  range between 3 and 63.
|  
|  The i810 TCO watchdog driver also implements the WDIOC_GETSTATUS and
|  WDIOC_GETBOOTSTATUS ioctl()s. WDIOC_GETSTATUS returns the actual counter value
| -and WDIOC_GETBOOTSTATUS returns the value of TCO2 Status Register (see Intel's
| +and WDIOC_GETBOOTSTATUS returns the value of the TCO2 Status Register (see Intel's

Please wrap lines at < 80 characters per line.

|  documentation for the 82801AA and 82801AB datasheet). 
