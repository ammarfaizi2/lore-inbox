Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271826AbTGXX0U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271827AbTGXX0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:26:20 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:64176 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271826AbTGXX0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:26:17 -0400
Date: Fri, 25 Jul 2003 01:41:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Bryan D. Stine" <admin@kentonet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test1] ACPI slowdown
Message-ID: <20030724234114.GB434@elf.ucw.cz>
References: <878yqpptez.fsf@deneb.enyo.de> <bfn3rj$lql$1@gatekeeper.tmr.com> <1059002183.1484.18.camel@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059002183.1484.18.camel@gaia>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I had that problem with my old Athlon TBird. Changing config to make
> thermal a module and not loading it solved my problem. I don't know how
> to change the thermal limits from within the system using ACPI.

echo "83:83:55:70:0" > /proc/acpi/thermal_zone/THRM/trip_points

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
