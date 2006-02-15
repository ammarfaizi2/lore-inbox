Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945924AbWBOO2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945924AbWBOO2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWBOO2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:28:18 -0500
Received: from solarneutrino.net ([66.199.224.43]:13833 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932453AbWBOO2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:28:17 -0500
Date: Wed, 15 Feb 2006 09:28:09 -0500
To: Jean Delvare <khali@linux-fr.org>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Nick Warne <nick@linicks.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Random reboots
Message-ID: <20060215142809.GA17842@tau.solarneutrino.net>
References: <20060213210435.GC16566@tau.solarneutrino.net> <20060213211044.066CE5E401E@latitude.mynet.no-ip.org> <20060213212243.GE16566@tau.solarneutrino.net> <7c3341450602131332x2fcd7d8co@mail.gmail.com> <20060213213929.GG16566@tau.solarneutrino.net> <20060214132904.GI16566@tau.solarneutrino.net> <20060214232222.5d4384a8.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060214232222.5d4384a8.khali@linux-fr.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 11:22:22PM +0100, Jean Delvare wrote:
> You seem to have hardware monitoring drivers loaded on the system, so
> I'd suggest that you watch the returned values over time. If the
> hardware is going wrong it might show there. Your system could be
> overheating for some reason (stuck fan...)
> 
> The fact that older kernels were seemingly working better doesn't prove
> much. You were running these kernels before, not now, and hardware
> *does* age, contrary to what people seem to think. If you want to make
> certain that older kernels were indeed working better for purely
> software reasons, you should switch back to such an old kernel and see
> if things actually improve or not.
> 
> Note that the first case ("a kernel came out that fixed the problem")
> doesn't mean that the hardware was not at fault. There are quite a few
> quirks in the Linux kernel code which are just there to workaround
> known hardware or BIOS bugs.

No, the old kernels still have all the bugs they ever did (of course).
I tested it during the st-iommu-doublefree debugging.  I do not plan on
running the old kernel again, mainly because it has so many irritating
bugs (df doesn't work, the serial console stalls on boot, so it won't
boot without handholding, etc. etc.).  I'd have to run it for at least a
month to verify, and the old kernel has security vulnerabilities and so
on.

The sensors report a bunch of obvious nonsesne as always...  I keep them
configured in with the hope that one day they'll report useful
information, but that day hasn't come yet.  I just checked, and all the
fans are still fine.  It's in a huge case with lots of fans and it's
hardly warmer than room temp.  The opteron 240s don't put out much heat.

I'm still thououghly convinced it's a kernel bug.

-ryan
