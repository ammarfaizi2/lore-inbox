Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267941AbTCFJfI>; Thu, 6 Mar 2003 04:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbTCFJfI>; Thu, 6 Mar 2003 04:35:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44554 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267941AbTCFJfH>; Thu, 6 Mar 2003 04:35:07 -0500
Date: Thu, 6 Mar 2003 09:45:33 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, Con Kolivas <kernel@kolivas.org>,
       Herman Oosthuysen <Herman@WirelessNetworksInc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux vs Windows temperature anomaly
Message-ID: <20030306094533.A26708@flint.arm.linux.org.uk>
Mail-Followup-To: "Trever L. Adams" <tadams-lists@myrealbox.com>,
	Ed Sweetman <ed.sweetman@wmich.edu>,
	Con Kolivas <kernel@kolivas.org>,
	Herman Oosthuysen <Herman@WirelessNetworksInc.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz> <p05210507ba8c20241329@[10.2.0.101]> <3E66842F.9020000@WirelessNetworksInc.com> <200303061038.44872.kernel@kolivas.org> <20030305235057.M20511@flint.arm.linux.org.uk> <3E66964E.6050101@wmich.edu> <1046911624.1051.35.camel@aurora.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046911624.1051.35.camel@aurora.localdomain>; from tadams-lists@myrealbox.com on Wed, Mar 05, 2003 at 07:47:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 07:47:05PM -0500, Trever L. Adams wrote:
> You are the one mistaken.  Most CPUs don't dissipate a constant amount
> of power as heat.  That depends on what the CPU is doing.

Correct - each time a gate in the CPU switches state, it produces a
small amount of heat.  Have enough gates switching, and you produce
a lot of heat (and your current consumption goes up.)  This is basic
CMOS operation.

> I do believe the previous poster was incorrect about the mathematical
> relationship between case and CPU temperatures.

I never said there was a 1:1 relationship here - you misread my mail.
I talked about _heat sinks_, not the relationship between the temperature
on the silicon die and the external case temperature, with or without a
heatsink, with or without a fan.  If you want to talk about the silicon
die, then you need to take into account thermal resistance between the
die and the case, the case and the heatsink, the heatsink and the
surrounding air, the fact that the heatsink is attached to one side
only, etc.

However, going into it in minute detail with all the maths is NOT a
subject for this list.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

