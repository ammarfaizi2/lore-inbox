Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWHKVZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWHKVZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHKVZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:25:26 -0400
Received: from rtr.ca ([64.26.128.89]:35467 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932316AbWHKVZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:25:25 -0400
Message-ID: <44DCF5C1.4040506@rtr.ca>
Date: Fri, 11 Aug 2006 17:25:21 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
References: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com> <44DCE8BA.2070601@rtr.ca> <44DCEAF7.5020005@rtr.ca> <20060811210104.GL26930@redhat.com> <44DCF360.7050305@rtr.ca>
In-Reply-To: <44DCF360.7050305@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>
>> Venki wrote:
>> Looks like there are thermal events happening that is causing CPU limits
>> to reduce. Are you running anything on the CPU when this happens. Is
>> there a thermal interface in /proc/acpi that can give you the current
>> temperature of the system?
> 
> There are thermal thingies in /proc, and I'm watching the temperature
> value from there (62C --> 65C), and the trip_points value is 95C..
> 
> Think it's thermal?

Yup, thermal.
Trips shortly after I see 66C in /proc/acpi/thermal_zone/THM/temperature

If I stop number crunching for a bit, the temperature drops down to the
low 50's, and the max freq then gets set back to 1100.

Mmmm.. is there a way to control the high/low thermostat values there?

Cheers
