Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVBNSET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVBNSET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVBNSET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:04:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39372 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261504AbVBNSEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:04:12 -0500
Date: Mon, 14 Feb 2005 18:04:03 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Adrian Bunk <bunk@stusta.de>
cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
In-Reply-To: <20050213004729.GA3256@stusta.de>
Message-ID: <Pine.LNX.4.56.0502141756220.7398@pentafluge.infradead.org>
References: <20050213004729.GA3256@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In 2.6, drivers/input/power.c would only have been built if 
> CONFIG_INPUT_POWER was enabled - but it is nowhere possible to enable 
> this option.

That was written a long time ago before the new power management went in. 
On PDA's there is a power button and suspend button. So this was a hook 
so that the input layer could detect the power/suspend button being 
presses and then power down or turn off the device. Now that the new power
management is in what should we do?

