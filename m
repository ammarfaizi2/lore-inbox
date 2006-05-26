Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWE0QYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWE0QYA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 12:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWE0QYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 12:24:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39687 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964867AbWE0QX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 12:23:59 -0400
Date: Fri, 26 May 2006 17:39:09 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Stelian Pop <stelian@popies.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] make ams work with latest kernels
Message-ID: <20060526173908.GA3357@ucw.cz>
References: <1148383943.25971.2.camel@johannes> <1148465069.6723.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148465069.6723.26.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Stelian Pop <stelian@popies.net>
> 
> This driver provides support for the Apple Motion Sensor (ams),
> which provides an accelerometer and other misc. data.
> Some Apple PowerBooks (the series the PowerBook5,6 falls into,
> later ones have a slightly different one the driver doesn't handle)
> are supported. The accelerometer data is readable via sysfs.
> 
> This driver also provides an absolute input class device, allowing
> the laptop to act as a pinball machine-esque joystick.

Is it useful to have /sysfs interface when we already have same data
available as joystick?

-- 
Thanks for all the (sleeping) penguins.
