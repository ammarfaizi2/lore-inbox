Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbVKCQL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbVKCQL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbVKCQL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:11:26 -0500
Received: from styx.suse.cz ([82.119.242.94]:52662 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030364AbVKCQLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:11:25 -0500
Date: Thu, 3 Nov 2005 17:11:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>, John Lenz <lenz@cs.wisc.edu>,
       Robert Schwebel <robert@schwebel.de>,
       Robert Schwebel <r.schwebel@pengutronix.de>, rpurdie@rpsys.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: best way to handle LEDs
Message-ID: <20051103161124.GA3692@ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de> <20051102211334.GH23943@elf.ucw.cz> <20051102213354.GO23316@pengutronix.de> <38523.192.168.0.12.1130986361.squirrel@192.168.0.2> <20051103081522.GA21663@flint.arm.linux.org.uk> <20051103095725.GA703@openzaurus.ucw.cz> <20051103144904.GG28038@flint.arm.linux.org.uk> <20051103153445.GA3530@ucw.cz> <20051103160123.GI28038@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103160123.GI28038@flint.arm.linux.org.uk>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 04:01:23PM +0000, Russell King wrote:
 
> I think you misunderstand me.  Please read:
> 
>   http://dictionary.reference.com/search?q=busywait
> 
> Since the i2c transfer functions allow drivers to sleep (and some do)
> you can't "just busywait" without modifying the i2c layer to tell
> drivers to busy wait instead of sleeping.
 
Agreed.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
