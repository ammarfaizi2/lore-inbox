Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266051AbUA1Qsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 11:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUA1Qsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 11:48:39 -0500
Received: from gprs192-165.eurotel.cz ([160.218.192.165]:643 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266051AbUA1Qsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 11:48:38 -0500
Date: Wed, 28 Jan 2004 17:48:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Romano Giannetti <romano@dea.icai.upco.es>, linux-kernel@vger.kernel.org
Subject: Re: Half-success: acpi swsusp in stock 2.6.1 on a vaio PGC-FX701 laptop
Message-ID: <20040128164815.GB1200@elf.ucw.cz>
References: <20040127151230.GA22312@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127151230.GA22312@pern.dea.icai.upco.es>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    this mail is to tell you about an half-success. I am trying to run a
> 2.6.1 (stock) kernel with my vaio pgc-fx701 laptop running Mandrake 9.2.I am
> in the phase of trying to have the suspend option working. The stock kernel
> swsusp "almost" work: it suspend the laptop, it resume it almost ok: but
> neither usb mouse nor alsa works in the resumed machine. Ethernet works. 
> 
>     I read on the kernel-list archive of the possibility of unload/reloading
> the drivers on resume, but I have another problem: compiling the "module
> unloading" option in the kernel make kudzu generate an oops at early boot
> stage. 
> 
>     So, before continuing: can I help with debugging? Or all these problems
> are  well-known and simply I have to wait for the 2.6.2 kernel? If
> you need

The usb problem is known, the alsa is not.  Writing suspend/resume
support for your alsa driver should be easy (please do that). USB
would be trickier, ask on usb lists, perhaps they have some
experimental patches.

									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
