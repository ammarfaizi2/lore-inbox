Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVBRMZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVBRMZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 07:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVBRMZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 07:25:38 -0500
Received: from gprs214-36.eurotel.cz ([160.218.214.36]:47273 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261336AbVBRMZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 07:25:34 -0500
Date: Fri, 18 Feb 2005 13:22:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: James Simmons <jsimmons@www.infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218122217.GA1523@elf.ucw.cz>
References: <20050213004729.GA3256@stusta.de> <Pine.LNX.4.56.0502141756220.7398@pentafluge.infradead.org> <20050214193438.GB7763@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214193438.GB7763@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > In 2.6, drivers/input/power.c would only have been built if 
> > > CONFIG_INPUT_POWER was enabled - but it is nowhere possible to enable 
> > > this option.
> > 
> > That was written a long time ago before the new power management went in. 
> > On PDA's there is a power button and suspend button. So this was a hook 
> > so that the input layer could detect the power/suspend button being 
> > presses and then power down or turn off the device. Now that the new power
> > management is in what should we do?
>  
> Change power.c to generate power events like ACPI does, most likely.

Actually I believe you want to fix ACPI to use inputs. You hardly want
/proc/acpi/events on PDA, right?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
