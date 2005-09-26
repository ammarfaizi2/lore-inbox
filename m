Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVIZUzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVIZUzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVIZUzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:55:32 -0400
Received: from edu.joroinen.fi ([194.89.68.130]:29131 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S1750735AbVIZUzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:55:32 -0400
Date: Mon, 26 Sep 2005 23:55:30 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Olivier Kaloudoff <kalou@kalou.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: watchdog with P4SCI and 2.6.9 (Supermicro)
Message-ID: <20050926205530.GJ10146@edu.joroinen.fi>
References: <Pine.LNX.4.62.0509261920340.15689@s1.ckr-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.62.0509261920340.15689@s1.ckr-solutions.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 07:32:03PM +0200, Olivier Kaloudoff wrote:
> Hi !
> 
> 
> 	I'm happy to say that watchdog for P4SCi is detected
> fine with my 2.6.9-freevps-1.5-1 kernel (centos 4.1 patched with freevps 
> 1.5-1)
>

Sorry to disappoint you, but check the linux-kernel archives for discussion
about supermicro motherboard and watchdog.. 

the watchdog of this motherboard is not (yet) supported by linux..

Or do the latest watchdog patches for 2.6.13/14 already support this mb?

-- Pasi Kärkkäinen
 
> [root@shinwey ~]# uname -a
> Linux shinwey 2.6.9-freevps-1.5-1 #1 SMP Sun Sep 25 23:07:51 CEST 2005 
> i686 i686 i386 GNU/Linux
> 
> 
> Sep 26 10:55:18 shinwey kernel: WDT500/501-P driver 0.10 at 0x0240 
> (Interrupt 11). heartbeat=60 sec (nowayout=0)
> 
> Sep 26 10:55:18 shinwey kernel: wdt: Fan Tachometer is Disabled
> Sep 26 10:55:18 shinwey kernel: w83877f_wdt: cannot register miscdev on 
> minor=130 (err=-16)
> 
> Sep 26 10:55:18 shinwey kernel: WDT driver for the Winbond(TM) W83627HF 
> Super I/O chip initialising.
> 
> Sep 26 10:55:18 shinwey kernel: w83627hf WDT: cannot register miscdev on 
> minor=130 (err=-16)
> 
> 
> Unfortunatelly, I set up a 4 minutes delay in the bios, the server takes 
> less than 2 minutes to boot and detect the watchdog chip, but reboot takes
> place ...
> 
> I don't get what's happening, my /dev/watchdog is existing and conform to 
> the devices.txt;
> 
> [root@shinwey Documentation]# ls -l /dev/watchdog
> crw-------  1 root root 10, 130 Sep 26  2005 /dev/watchdog
> 
> 
> Any tip ?
> 
> 
> 
> Sincere Regards,
> 
> 
> Olivier Kaloudoff
> 
