Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271827AbTGXX2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271828AbTGXX2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:28:08 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:10417 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271827AbTGXX1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:27:38 -0400
Date: Fri, 25 Jul 2003 01:42:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brugger <ml.dominik83@gmx.net>
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test1] ACPI slowdown
Message-ID: <20030724234236.GC434@elf.ucw.cz>
References: <878yqpptez.fsf@deneb.enyo.de> <20030723114421.34eb7149.dominik83@gmx.net> <87el0gv3g9.fsf@deneb.enyo.de> <20030724112850.0e311b7a.ml.dominik83@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030724112850.0e311b7a.ml.dominik83@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Could you post the output of "tail /proc/acpi/thermal_zone/THRM/*"?
> > Thanks.
> 
> $ tail /proc/acpi/thermal_zone/THRM/*
> ==> /proc/acpi/thermal_zone/THRM/cooling_mode <==
> cooling mode:            active
> 
> ==> /proc/acpi/thermal_zone/THRM/polling_frequency <==
> <polling disabled>
> 
> ==> /proc/acpi/thermal_zone/THRM/state <==
> state:                   ok
> 
> ==> /proc/acpi/thermal_zone/THRM/temperature <==
> temperature:             37 C
> 
> ==> /proc/acpi/thermal_zone/THRM/trip_points <==
> critical (S5):           70 C
> passive:                 70 C: tc1=4 tc2=3 tsp=60 devices=0xdff6cde8
> active[0]:               70 C: devices=0xdff64d68

This is clearly wrong.... But it is probably is not causing your
slowdown as 37 < 70.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
