Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268502AbTGIT35 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 15:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268536AbTGIT35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 15:29:57 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:35205 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP id S268502AbTGIT3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 15:29:55 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: linux-kernel@vger.kernel.org
Subject: Old problem, can anything be done?
Date: Wed, 9 Jul 2003 15:44:31 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Organization: None that appears to be detectable by casual observers
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307091544.31783.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [151.205.62.27] at Wed, 9 Jul 2003 14:44:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml;

One thing thats quit working sometime back in the 2.4.17 or 18 area, 
is the bulldog monitor and its upsd for watching my Belkin Regulator 
Pro 1400 va ups.

As near as I can determine, the daemon is no longer talking to the ups 
via its seriel port.  It got intermittent as the kernel versions 
advanced, often requiring a restart of the upsd daemon after the 
monitoring gui was started, and finally quit altogether at about the 
time frame of kernel 2.4.20.

This is Belkins own linux drivers, which while built in the fall of 
2002, were actually built on a RH5.2 system.  I've not succeeded in 
convincing Belkin they really should update their install, and I have 
yelped at them at least 3 times over this.  I've also requested the 
src's to see if I could fix them but the lawyers won't let that 
happen.  Even if I sign an NDA.

Is there anything that can be done from my end to restore whatever was 
changed in the way these modules talk to each other and to the seriel 
port?

The traceing tools I've run here seem to indicate that the 
daemon is getting data from the ups, but its the "keep the circuit 
alive" data only, no queries from the daemon appear to be getting 
*to* the ups to elicit responses in the form of the data requested.

I am not subscribed as the discussions usually go way over my head.  I 
know just enough C to be dangerous.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.


