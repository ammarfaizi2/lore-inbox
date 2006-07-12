Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWGLMRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWGLMRR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWGLMRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:17:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52640 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750746AbWGLMRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:17:16 -0400
Date: Wed, 12 Jul 2006 14:17:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Uwe Bugla <uwe.bugla@gmx.de>
cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Subject: Re: patch for timer.c - two dmesgs
In-Reply-To: <20060712115110.292550@gmx.net>
Message-ID: <Pine.LNX.4.64.0607121410580.12900@scrub.home>
References: <20060712115110.292550@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 12 Jul 2006, Uwe Bugla wrote:

> Then the boot process does not take any break at all (like in kernel 2.6.18-rc1 and in kernels 2.6.17-mm*), but simply stops completely.
> About 7 message lines are missing before X starts for presenting the graphical login prompt (proftpd, xprint etc.).
> Perhaps two dmesgs help: one for a functionable 2.6.17.4 kernel (dmesg17), another for the kernel in question (dmesg18).

A lot has changed since then...
Did you try using SysRq+P or Alt+ScrollLock? (A SysRq+T might be useful 
too).

> Simply my intuition tells me that a system timer performs very different 
> on two very different machines with two very different CPU frequencies 
> and two very different main processors. 

No offense, it's no intuition, but a shot in the dark.
If you at least tried a few more kernels (at least 2.6.18-mm1 and 
2.6.18-mm2), it would be a much better indication whether it's the timer 
patch.

bye, Roman
