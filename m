Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbTCEXkb>; Wed, 5 Mar 2003 18:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTCEXkb>; Wed, 5 Mar 2003 18:40:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25092 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267072AbTCEXka>; Wed, 5 Mar 2003 18:40:30 -0500
Date: Wed, 5 Mar 2003 23:50:57 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: Herman Oosthuysen <Herman@WirelessNetworksInc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux vs Windows temperature anomaly
Message-ID: <20030305235057.M20511@flint.arm.linux.org.uk>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	Herman Oosthuysen <Herman@WirelessNetworksInc.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz> <p05210507ba8c20241329@[10.2.0.101]> <3E66842F.9020000@WirelessNetworksInc.com> <200303061038.44872.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303061038.44872.kernel@kolivas.org>; from kernel@kolivas.org on Thu, Mar 06, 2003 at 10:38:44AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 10:38:44AM +1100, Con Kolivas wrote:
> On Thu, 6 Mar 2003 10:11 am, Herman Oosthuysen wrote:
> > Linux is more 'busy' than windoze and I have heard of boxes frying when
> > running Linux.   The solution is to find a better motherboard
> > manufacturer...
> 
> That doesn't make sense. His post said the temperature was 20 degrees lower 
> when it failed.

It makes perfect sense.  Components drawing power produce heat, which
causes a temperature rise above ambient.  Put simply, if a chip that
fails at a case temperature of 50C and you have a 10C rise, it'll fail
at 40C. If you have a 20C rise, it'll fail at 30C.

PS, the efficiency of heatsinks is measured in degC/W - how many degrees
celcius the temperature rises for each watt of power dissipated.  Double
the dissipated power, double the temperature rise.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

