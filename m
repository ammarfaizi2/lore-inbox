Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVBNTeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVBNTeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 14:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVBNTeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 14:34:09 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:59881 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261537AbVBNTeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 14:34:07 -0500
Date: Mon, 14 Feb 2005 20:34:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: James Simmons <jsimmons@www.infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050214193438.GB7763@ucw.cz>
References: <20050213004729.GA3256@stusta.de> <Pine.LNX.4.56.0502141756220.7398@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0502141756220.7398@pentafluge.infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 06:04:03PM +0000, James Simmons wrote:
> 
> > In 2.6, drivers/input/power.c would only have been built if 
> > CONFIG_INPUT_POWER was enabled - but it is nowhere possible to enable 
> > this option.
> 
> That was written a long time ago before the new power management went in. 
> On PDA's there is a power button and suspend button. So this was a hook 
> so that the input layer could detect the power/suspend button being 
> presses and then power down or turn off the device. Now that the new power
> management is in what should we do?
 
Change power.c to generate power events like ACPI does, most likely.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
