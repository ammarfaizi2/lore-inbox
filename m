Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281807AbRKVWkn>; Thu, 22 Nov 2001 17:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281808AbRKVWkY>; Thu, 22 Nov 2001 17:40:24 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:1801 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S281807AbRKVWkE>;
	Thu, 22 Nov 2001 17:40:04 -0500
Subject: Thinkpad t21 hard lockup when left overnight
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 22 Nov 2001 17:39:44 -0500
Message-Id: <1006468789.5778.7.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I've left my thinkpad on overnight (without apm --suspend'ing it)
when I wake up in the morning, it's locked up hard.  For some reason it
seems to run for a few hours w/o any interaction on the machine itself,
then it just dies.  I did a test where I ssh'd into the box and ran a
simple while [ 1 ] { data ; sleep 30 } test, and it died after 3,4 hours
of inactivity.  

I've seen this at least since 2.4.13-AC5, and see it currently in
.15-pre8.  

I'm using the pcmcia package (instead of the kernel's because I can't
get my orinoco card to work with the kernel's driver) and I always have
my xircom (ibm rebranded) card inside when it crashes (so the associated
module installed). I'm also using the thinkpad module (tpctl related). 
I also have the cs46xx module installed, as well as using devfs + ext3
(though would the last 2 really have anything to do with it?).  The
kernel is compiled with usb support, and the rest should be a fairly
normal kernel build.  How would I go about trying to diagnose why the
machine is locking up hard.  

Nothing is in syslog when I reboot.

thanks,

shaya potter

