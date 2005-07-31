Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVGaJxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVGaJxo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 05:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVGaJxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 05:53:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10130 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261859AbVGaJxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 05:53:43 -0400
Date: Sun, 31 Jul 2005 11:52:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Cloos <cloos@jhcloos.com>
Cc: Brian Schau <brian@schau.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
Message-ID: <20050731095207.GJ9418@elf.ucw.cz>
References: <42EB940E.5000008@schau.com> <20050730194215.GA9188@elf.ucw.cz> <42EBDEA9.60505@schau.com> <20050730203159.GB9418@elf.ucw.cz> <m3mzo3jriv.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3mzo3jriv.fsf@lugabout.cloos.reno.nv.us>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Pavel> Well, that is if you use /dev/psaux, right? Using event devices
> Pavel> you should be able to access it from userland.
> 
> Would /dev/input/mice not also be affected?

Yes, /dev/input/mice == /dev/psaux.

> Until X can hotplug input devices /dev/input/mice rather than evdev
> will remain necessary in many cases for a reasonable user experience.
> 
> So at least a quirk/whatever to keep that device from being included
> in mice (and psaux) should be added.

Yes... why not. But that should be close to one liner, right?
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
