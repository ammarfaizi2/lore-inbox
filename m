Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTDYVcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTDYVcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:32:11 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:52160 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id S264490AbTDYVcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:32:10 -0400
Message-ID: <3EA9AC16.4070903@coyotegulch.com>
Date: Fri, 25 Apr 2003 17:43:50 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.6x Sound frustration
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5.66 kernel loads the ALSA sound drivers for my Intel i8x0 
on-board sound, but no sound files make any... well, *sound.*

Note that, other than sound, the machine is performing flawlessly.

I've enabled the ALSA drivers, with (and for one etst, without) OSS 
emulation, integrated into the kernel (no modules).

I hear a pop while the OS is loading; the log states:

Apr 25 17:06:18 Tycho kernel: intel8x0: clocking to 41158
Apr 25 17:06:18 Tycho kernel: ALSA device list:
Apr 25 17:06:18 Tycho kernel:   #0: Intel 82801BA-ICH2 at 0xe800, irq 17

Yes, I'm using the latest ALSA tools.

Yes, I've used a mixer (several, actually) to make sure nothing is muted 
and that all volumes are maximized.

Yes, I have the speakers turned on, plugged in, and connected to the 
proper connector on the motherboard (an Intel D850EMV2). I've even tried 
different speakers, jacks, and cables. The speakers work fine when 
attached to a Wintel system, BTW.

I've tried running several different "sound" apps, along with directly 
sending sounds to various devices -- and my reward is silence.

This is the first Linux system on which I've wanted the sound working... 
I'm willing to admit I may be doing something stupid -- please be gentle! ;)

..Scott

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)

