Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272388AbTHNOtV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 10:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272393AbTHNOtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 10:49:21 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:45020 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S272388AbTHNOtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 10:49:19 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm2, and my no audio whine, updated
Date: Thu, 14 Aug 2003 10:49:18 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308141049.18442.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.62.221] at Thu, 14 Aug 2003 09:49:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I guess we can forget about parts of my "no audio" whine.  It turns 
out there are alsa options in the "make menuconfig" that somehow are 
not in "make xconfig".  Hint...

I turned on what I thought was the right stuff, and was greeted by the 
drum solo when I started kde just now.  So at least kde can make 
noises now.

However, xawtv and gnomeradio are still mute, gnomeradio complaining 
about not being able to access /dev/radio, and xawtv silently exiting 
after the launch timeout.  Do I need to relink those devices in /dev?  
If so, what to, or to what as the case may be?

Also, FYI, I had to turn the APIC stuff completely off in the .config 
in order to get rid of that "I found it & turned it on" message in 
dmesg.  It was ignoreing, or reporting no such option when noapic or 
pci=noapic was appended to the kernel arguments line in grub.conf.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

