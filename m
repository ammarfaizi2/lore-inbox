Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVBGPWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVBGPWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVBGPWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:22:10 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:37808 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S261153AbVBGPWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:22:04 -0500
Date: Mon, 7 Feb 2005 17:22:03 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [WATCHDOG] support of motherboards with ICH6
Message-ID: <20050207152203.GI1561@edu.joroinen.fi>
References: <41FF9366.5030203@fr.thalesgroup.com> <42072E13.4000903@fr.thalesgroup.com> <20050207142030.GE1561@edu.joroinen.fi> <420782AE.9050505@fr.thalesgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <420782AE.9050505@fr.thalesgroup.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 04:01:02PM +0100, P.O. Gaillard wrote:
> Pasi Kärkkäinen
> >Hi!
> >
> >I have P8SCi motherboard, and I just tried the watchdog with Linux 2.6.10.
> >
> >I loaded w83627hf_wdt driver, and the watchdog was detected:
> >
> >WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.
> >w83627hf WDT: initialized. timeout=60 sec (nowayout=0)
> >
> >But it is not working. I tried setting the timeout to 1 minute, and to
> >8 minute in the BIOS, but the machine reboots after the delay no matter 
> >what
> >the delay is.. the watchdog driver is loaded before the timeout of course.
> >
> >For some reason, the driver is not working.
> >
> >I mailed supermicro support about this, and they told me one of their
> >customers is using watchdog with Debian 2.6.10 kernel. 
> >So it should work, but..
> >
> >Is there some patches I could try? 
> Hi !
> I am so glad to find somebody interested in this issue ;-)
>

Me too :)
 
> I am not sure about which watchdog is working in the P8SCi. On my P4Sci, 
> the working watchdog was the one in Intel's southbridge with the i8xx-tco 
> driver. I tried to use this driver with the P8SAA. To do that I had to use 
> 2.6.11rc2bk9 to get ICH6 support in the i8xx-tco driver. But as you may 
> know, the watchdog is not working on the P8SAA.
> 
> This might be a good bet for you.
> 

Currently building 2.6.11rc3 i8xx-tco driver to test this.. 

I'll let you know what happens.

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
