Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269882AbUIDLP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269882AbUIDLP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269891AbUIDLN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:13:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45256 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269883AbUIDLM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:12:29 -0400
Date: Sat, 4 Sep 2004 13:12:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Lenz <lenz@cs.wisc.edu>, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       linux-kernel@vger.kernel.org, Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040904111202.GB28074@atrey.karlin.mff.cuni.cz>
References: <1094157190l.4235l.2l@hydra> <ch8tdd$1uf$1@sea.gmane.org> <20040903120634.GK6985@lug-owl.de> <1094237243l.7429l.1l@hydra> <20040903232507.A8810@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903232507.A8810@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The kernel is NOT in sole control today on ARM platforms:
> 
> echo claim > /sys/devices/system/leds/leds0/event
> echo red on > /sys/devices/system/leds/leds0/event
> echo green on > /sys/devices/system/leds/leds0/event
> echo red off > /sys/devices/system/leds/leds0/event
> echo release > /sys/devices/system/leds/leds0/event
> 
> etc
> 
> Sure, we have a weird naming scheme (red, green, amber, blue) but
> that came around because that's what people were dealing with.
> There's nothing really stopping us from having any name for a LED
> in the existing scheme.
> 
> I just don't buy the "we must have one sysfs node for every LED"
> argument.

sysfs is one-file-one-value. We do not want to end up with /proc-like
mess.

								Pavel
