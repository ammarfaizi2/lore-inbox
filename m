Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbUAJGRq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 01:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbUAJGRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 01:17:46 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:725 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S264899AbUAJGRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 01:17:44 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Q re /proc/bus/i2c
Date: Sat, 10 Jan 2004 01:17:42 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401100117.42252.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.61.108] at Sat, 10 Jan 2004 00:17:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I'm still trying to make sensors (and gkrellm) work when booted to a  
2.6.x kernel.

The lm_sensors people say it should "just work", but so far no one has 
acknowledged that it doesn't work here because I don't have an "i2c" 
in my /proc/bus directory.  Browsing all the sensors-detection stuff, 
in particular the bus detection script, this thing is hard coded to 
look for /proc/bus/i2c by default, or you can pass it an argument.

I don't have a "/proc/bus/i2c".  Passing this script the /sys/bus/i2c 
argument only gets an error return complaining that its a directory.

I can't see the forest for all the trees here, so where do I stand and 
start swinging my chainsaw?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

