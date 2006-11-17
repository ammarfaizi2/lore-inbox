Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933531AbWKQLpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933531AbWKQLpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 06:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933534AbWKQLpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 06:45:21 -0500
Received: from main.gmane.org ([80.91.229.2]:3757 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S933531AbWKQLpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 06:45:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [patch 2.6.19-rc6] Documentation/rtc.txt updates (for rtc class)
Date: Fri, 17 Nov 2006 11:45:07 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelr8ji.7lr.olecom@flower.upol.cz>
References: <200611162309.31879.david-b@pacbell.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, David.

On 2006-11-17, David Brownell wrote:
> This updates the RTC documentation to summarize the two APIs now available:
> the old PC/AT one, and the new RTC class drivers.  It also updates the
> included "rtctest.c" file to better meet Linux style guidelines, and to
> work with the new RTC drivers.

How about documenting  things you've told me back  in September?  I.e.
i386/amd64 have motorola RTC (and  clones) based system clock setup in
boot  sequence "arch/x86_64/kernel/time.c".  Also,  how it  interferes
with time_hpet.c? There seem to  be confusion what RTC timer and
RTC clock is: <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=386226>

Also  util-linux  package  maintaining  was  under  question  in  lkml
recently.  I  think, i should update  rc script i  rewrote for hwclock
with  more info.  I agree  with you,  that on  PC hwclock  is useless,
unless dual-boot users are not in consern.

I'll try to review and test patches. I wonder, why they were not posted
before, but just before 2.6.19?

Thanks!
____

