Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268591AbUIXIxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268591AbUIXIxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUIXIxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:53:43 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:53376 "EHLO ucw.cz")
	by vger.kernel.org with ESMTP id S268591AbUIXIxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:53:40 -0400
Date: Fri, 24 Sep 2004 10:30:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new class for led devices
Message-ID: <20040924083018.GB1189@ucw.cz>
References: <1095829641l.11731l.0l@hydra> <20040922072727.GA4553@ucw.cz> <1095882787l.4629l.0l@hydra> <20040922220715.GA30210@elf.ucw.cz> <1095960505l.4817l.0l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095960505l.4817l.0l@hydra>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 05:28:25PM +0000, John Lenz wrote:

> >So right solution seems to be adding LED_MAIL and LED_CHARGING and be
> >done with that...
> 
> Yeah, that would work.  And if userspace wants to use the led for something
> else, just uses MAIL and CHARGING as the names of the leds.
> 
> Signed-off-by: John Lenz <lenz@cs.wisc.edu>
> 
> --- bk/include/linux/input.h~input
> +++ bk/include/linux/input.h
> @@ -542,6 +542,8 @@
> #define LED_SUSPEND		0x06
> #define LED_MUTE		0x07
> #define LED_MISC		0x08
> +#define LED_MAIL		0x09
> +#define LED_CHARGING		0x0a
> #define LED_MAX			0x0f
 
Thanks, applied. Now where is the driver for those Zaurus LEDs?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
