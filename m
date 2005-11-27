Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVK0NjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVK0NjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 08:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVK0NjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 08:39:19 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:57738 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1750971AbVK0NjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 08:39:18 -0500
Date: Sun, 27 Nov 2005 14:39:17 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PC speaker beeping on high CPU loads on an nForce2
In-Reply-To: <43892897.9020900@vc.cvut.cz>
Message-ID: <Pine.LNX.4.60.0511271436150.23991@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
 <43892897.9020900@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005, Petr Vandrovec wrote:

> Martin Drab wrote:
>
> > on an nForce2 system (GigaByte 7NNXP) when the CPU is under heavy load (like
> > during kernel compilation for instance, or any compilation of any bigger
> > project, for that matter), I hear some beeps comming out of the PC speaker.
> > It's like few short beeps per second for a while, then silence for few
> > seconds, then a beep here and there, and again, and so on. It is quite
> > strange. It happens ever since I remember (I mean in kernel versions of
> > course, I have the board for about 1.5 years). I've just been kind of
> > ignoring it until now. Does anybody else happen to see the same symptoms?
> > What could be the cause of this. Is it something about timing? But how come
> > the PC speaker gets kiced in, while it's not being used at all (well, at
> > least not intentionally) for anything. Perhaps something is writing some
> > ports it is not supposed to?
> 
> Nope.  Your system is overheating, and on-board temperature sensors are
> complaining.  Probably you should find whether lm-sensors have drivers for
> chips your motherboard has, and look at sensors output in that case...
> 
> Maybe ACPI could report thermal zone as well, try looking at
> /proc/acpi/thermal_zone/* tree.

Ah, that didn't occur to me. You are right. I'm about to install a new 
water cooling, so I hope that would help.

Sorry for bothering,
Martin
