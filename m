Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVBPCmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVBPCmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 21:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVBPCmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 21:42:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:38544 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261972AbVBPCmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 21:42:15 -0500
Subject: Re: Radeon FB troubles with recent kernels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vincent C Jones <vcjones@networkingunlimited.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050216015323.GA7223@NetworkingUnlimited.com>
References: <3y1SR-5K6-1@gated-at.bofh.it>
	 <20050215150713.EE7721DE4A@X31.nui.nul> <1108504921.13376.21.camel@gaston>
	 <20050216015323.GA7223@NetworkingUnlimited.com>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 13:41:20 +1100
Message-Id: <1108521681.13376.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 20:53 -0500, Vincent C Jones wrote:

> 
> Kernel command line: auto BOOT_IMAGE=Test_9.2 ro root=306 pci=usepirqmask desktop idebus=66 video=radeonfb:1024x768-24@60
> 
> Note the "video=radeonfb:1024x768-24@60" which used to be required to
> get the console into 1024x768 mode but is documented in "modefb.txt"
> as an invalid combination of mode specifications (and also states
> that radeonfb does not support mode specification...). So other
> than the loss of temporary working of backlight controls, I just
> see undocumented progress :-)
> 
> Thanks again, and keep up the great work!

Heh, good. Well, the mode spec should work in fact, provided that you
get the syntax right, though I haven't tried. I'll have a look later,
but if it doesn't work, then it was always broken and it's not a
regression :) I still want to fix more stuff in this area, but for now,
I'm concerned mostly about regressions.

Can you remind me exactly what's up with the backlight control ?

Ben.


