Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTDZDep (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 23:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264606AbTDZDep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 23:34:45 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:36296 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S264605AbTDZDeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 23:34:44 -0400
Message-ID: <3EAA011B.7040104@cox.net>
Date: Fri, 25 Apr 2003 22:46:35 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Robert Ladd <coyote@coyotegulch.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.6x Sound frustration
References: <3EA9AC16.4070903@coyotegulch.com>
In-Reply-To: <3EA9AC16.4070903@coyotegulch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Robert Ladd wrote:
> The 2.5.66 kernel loads the ALSA sound drivers for my Intel i8x0 
> on-board sound, but no sound files make any... well, *sound.*
> 
> Note that, other than sound, the machine is performing flawlessly.
> 
> I've enabled the ALSA drivers, with (and for one etst, without) OSS 
> emulation, integrated into the kernel (no modules).
> 
> I hear a pop while the OS is loading; the log states:
> 
> Apr 25 17:06:18 Tycho kernel: intel8x0: clocking to 41158
> Apr 25 17:06:18 Tycho kernel: ALSA device list:
> Apr 25 17:06:18 Tycho kernel:   #0: Intel 82801BA-ICH2 at 0xe800, irq 17
> 
> Yes, I'm using the latest ALSA tools.
> 
> Yes, I've used a mixer (several, actually) to make sure nothing is muted 
> and that all volumes are maximized.
> 
> Yes, I have the speakers turned on, plugged in, and connected to the 
> proper connector on the motherboard (an Intel D850EMV2). I've even tried 
> different speakers, jacks, and cables. The speakers work fine when 
> attached to a Wintel system, BTW.
> 
> I've tried running several different "sound" apps, along with directly 
> sending sounds to various devices -- and my reward is silence.
> 
> This is the first Linux system on which I've wanted the sound working... 
> I'm willing to admit I may be doing something stupid -- please be 
> gentle! ;)

Have you tried compiling the intel8x0 ALSA driver as a module? I never 
could get mine to work from within the kernel, but I got it to work 
perfectly as modules. Just remember to set the options and whatnot for 
the snd and intel8x0 modules as stated in the ALSA documentation.
Just a thought.

-David

