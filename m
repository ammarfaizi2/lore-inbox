Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWCVOLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWCVOLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 09:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWCVOLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 09:11:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14025 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750795AbWCVOLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 09:11:48 -0500
Date: Wed, 22 Mar 2006 15:11:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ucb1x00 audio & zaurus touchscreen
Message-ID: <20060322141126.GA23975@elf.ucw.cz>
References: <20060322122052.GN14075@elf.ucw.cz> <20060322135337.GA26357@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322135337.GA26357@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 22-03-06 13:53:37, Russell King wrote:
> On Wed, Mar 22, 2006 at 01:20:53PM +0100, Pavel Machek wrote:
> > First, I'd like to ask: what is status of ucb1x00 audio in 2.6? I do
> > have .c file here, but do not have corresponding header files...
> 
> I never included the ucb1x00 audio patch into mainline because it
> depended on some obsolete SA11x0 OSS audio support, and I haven't had
> time to:

Do you still have copy, somewhere? I have something here, but it does
not even compile due to missing headers.

> (a) finish my SA11x0 ALSA audio support (the stuff which is in mainline
>     is under the guise of being generic, but is actually completely ipaq
>     specific.)

Do you mean ./sound/arm/sa11xx-uda1341.c here? Do you have any patches?

> (b) convert the ucb1x00 stuff to use this generic ALSA support.
> 
> Plus there's issues surrounding where it should live (as ever).  It
> would be stretched between drivers/mfd and sound/arm and would be very
> ARM specific.

								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
