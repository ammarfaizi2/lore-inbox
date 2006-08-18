Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWHXOjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWHXOjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWHXOjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:39:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19982 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751592AbWHXOjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:39:23 -0400
Date: Fri, 18 Aug 2006 15:11:22 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Mark Lord <lkml@rtr.ca>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
Message-ID: <20060818151122.GA8275@ucw.cz>
References: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com> <44DCE8BA.2070601@rtr.ca> <44DCEAF7.5020005@rtr.ca> <20060811210104.GL26930@redhat.com> <44DCF360.7050305@rtr.ca> <44DCF5C1.4040506@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44DCF5C1.4040506@rtr.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >There are thermal thingies in /proc, and I'm watching 
> >the temperature
> >value from there (62C --> 65C), and the trip_points 
> >value is 95C..
> >
> >Think it's thermal?
> 
> Yup, thermal.
> Trips shortly after I see 66C in 
> /proc/acpi/thermal_zone/THM/temperature
> 
> If I stop number crunching for a bit, the temperature 
> drops down to the
> low 50's, and the max freq then gets set back to 1100.
> 
> Mmmm.. is there a way to control the high/low thermostat 
> values there?

trip_points should be writeable... but you do not have passive cooling
enabled there?!

-- 
Thanks for all the (sleeping) penguins.
