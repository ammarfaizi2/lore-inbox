Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTDGKK3 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 06:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbTDGKK3 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 06:10:29 -0400
Received: from poup.poupinou.org ([195.101.94.96]:47403 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S263370AbTDGKK1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 06:10:27 -0400
Date: Mon, 7 Apr 2003 12:21:57 +0200
To: Gerassimo Tselentis <g_tselentis@worldonline.co.za>
Cc: linux-kernel@vger.kernel.org, ducrot@poupinou.org
Subject: Re: cpufreq not supported on ALi / ATI chipset
Message-ID: <20030407102157.GD10453@poup.poupinou.org>
Reply-To: ducrot@poupinou.org
References: <1049312788.2048.51.camel@goku.asylum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049312788.2048.51.camel@goku.asylum>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 09:46:30PM +0200, Gerassimo Tselentis wrote:
> Hi
> 
> I see someone posted a message about cpufreq not being supported on an
> Intel 440BX motherboard so I thought I'd post mine too. I have a Compaq
> Evo N1050v laptop with a combination of ALi and ATI bridges. It has an
> Intel Pentium 4-M 1.8GHz I'm not sure which is which, but here is an
> lspci :
> 
> 00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab2 (rev 02)
> 00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 7010
> 00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
> 00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
> Controller Audio Device (rev 02)
> 00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
> 00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem]
> 00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
> 00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21
> IEEE-1394a-2000 Controller (PHY/Link)
> 00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
> 00:11.0 Bridge: ALi Corporation M7101 PMU
> 00:12.0 Ethernet controller: National Semiconductor Corporation DP83815
> (MacPhyter) Ethernet Controller
> 01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 340M
> 
> Also, here is the relevant dmesg output :
> 
> ...
> cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.7.2.6 $
> cpufreq: Intel(R) SpeedStep(TM) for this processor not (yet) available.
> ...
> 
> I've also tried the 2.5.65 kernel release. The above was from a
> 2.4.21-0.13mdk kernel. The ATI bridge itself is not supported, as I
> gathered, so maybe that's why and maybe I should rather address this
> email to a different development group instead of cpufreq. I'd gladly
> provide more verbose info if wanted.
> 

cpufreq mailing list is the right place to ask for help.
I doubt also that 2.4 series could help you (yet).
You may want to subscribe to cpufreq mailing-list.

In short, there is for now only experimental support for the ALi
southbridge, but is not included in cpufreq 'vanilla' due to
the fact that there is not enough testers.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
