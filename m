Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293099AbSB1L3B>; Thu, 28 Feb 2002 06:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293315AbSB1L0l>; Thu, 28 Feb 2002 06:26:41 -0500
Received: from gate.perex.cz ([194.212.165.105]:10003 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S293314AbSB1LZN>;
	Thu, 28 Feb 2002 06:25:13 -0500
Date: Thu, 28 Feb 2002 12:24:58 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Pavel Machek <pavel@suse.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch - sharing RTC timer between kernel and user space
In-Reply-To: <20020228094453.GA774@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0202281224030.539-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> > 	it would be really nice to include this patch to allow using of
> > RTC timer inside the kernel space. We can use the RTC timer as timing
> > source for ALSA sequencer.
> 
> I wonder... how does alsa work on sparc/alpha/.... then? Not everyone
> has RTC, right? Why don't you use regular kernel timers, instead?

Using the RTC timer is optional. The default timer is system timer, of 
course.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

