Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTJaPWC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 10:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263352AbTJaPWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 10:22:02 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:22488 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S263345AbTJaPV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 10:21:59 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: mru@kth.se (=?iso-8859-1?q?M=E5ns?= =?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 vs sound
Date: Fri, 31 Oct 2003 10:21:58 -0500
User-Agent: KMail/1.5.1
References: <200310301008.27871.gene.heskett@verizon.net> <200310310813.02970.gene.heskett@verizon.net> <yw1x8yn1zfb8.fsf@kth.se>
In-Reply-To: <yw1x8yn1zfb8.fsf@kth.se>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200310311021.58400.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.58.154] at Fri, 31 Oct 2003 09:21:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 October 2003 08:50, Måns Rullgård wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> Some of the tutorials in those links would seem to indicate that
>> /etc/modules.conf has been renamed, which I have not, and my
>> modutils are still the same as I've been using for a few months
>> with 2.4.  I saw an announcement regarding a new modutils tool set
>> last night, do I need to install that, and does that then fubar a
>> 2.4.23-pre8 boot?
>
>You need the new module-init-tools.  If you follow the instructions
>provided with them, things will continue to work with 2.4 kernels.

Got it, turns out I already had module-init-tools-0.9.13-pre.tar.bz2 
installed, but just now got module-init-tools-0.9.15-pre3.tar.gz, 
unpacked it, read the INSTALL quickly, then the usual 
./configure;make;make install which went w/o error.  Figured I'd 
reboot to see if that worked any better, and got a message about each 
mountpoint being busy as it went down, each of which hung the 
shutdown for a few seconds.

Booted back to 2.4.23-pre8 things are apparently fine again.
Is this a onetime thing?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

