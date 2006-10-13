Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWJMEZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWJMEZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 00:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWJMEZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 00:25:48 -0400
Received: from gw.goop.org ([64.81.55.164]:34709 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751618AbWJMEZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 00:25:47 -0400
Message-ID: <452F15DC.8080701@goop.org>
Date: Thu, 12 Oct 2006 21:28:12 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Strange entries in /proc/acpi/thermal_zone for Thinkpad X60
References: <fa.P/oAhFV0AVrh8PKSKzP+xVGih2s@ifi.uio.no> <452F0EB7.2060508@shaw.ca>
In-Reply-To: <452F0EB7.2060508@shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> I would expect they wouldn't, otherwise there would be no reason for 
> the BIOS people to set up two thermal zones..

Ah, OK.  I misunderstood what thermal zones are.

> How do you know they are one for each core? ACPI thermal zones can be 
> anywhere in the machine that needs OS-controlled cooling. Could be the 
> CPU heatsink, voltage regulator, or someplace else.

Right, bad assumption on my part.  Is there any way to find out what 
they might correspond to?  /proc/acpi/ibm/thermal has a bunch of 
temperature-like numbers in them; I guess there should be some 
correlation between those and the thermal zones.

> I think we need more information to decide what is going on here.. 
> what temperatures are registering in the thermal zones when the CPU 
> clock is being limited?

I'll gather a bit more info.

    J
