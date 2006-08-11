Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWHKVPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWHKVPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWHKVPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:15:17 -0400
Received: from rtr.ca ([64.26.128.89]:47312 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932345AbWHKVPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:15:16 -0400
Message-ID: <44DCF360.7050305@rtr.ca>
Date: Fri, 11 Aug 2006 17:15:12 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
References: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com> <44DCE8BA.2070601@rtr.ca> <44DCEAF7.5020005@rtr.ca> <20060811210104.GL26930@redhat.com>
In-Reply-To: <20060811210104.GL26930@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mmm.. spoke too soon.

I have not actually rebooted since killing powernowd,
and it just happened again now.  No powernowd running.

Limit dropped from 1100Mhz to 800Mhz (log below).

> Venki wrote:
> Looks like there are thermal events happening that is causing CPU limits
> to reduce. Are you running anything on the CPU when this happens. Is
> there a thermal interface in /proc/acpi that can give you the current
> temperature of the system?


There are thermal thingies in /proc, and I'm watching the temperature
value from there (62C --> 65C), and the trip_points value is 95C..

Think it's thermal?
