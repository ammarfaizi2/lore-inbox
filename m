Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbULOC72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbULOC72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 21:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbULOC72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 21:59:28 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:54665 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261824AbULOC7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 21:59:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: USB making time drift [was Re: dynamic-hz]
Date: Tue, 14 Dec 2004 21:59:23 -0500
User-Agent: KMail/1.7
Cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>
References: <20041213002751.GP16322@dualathlon.random> <20041214220239.GA19221@elf.ucw.cz> <20041214231649.GR16322@dualathlon.random>
In-Reply-To: <20041214231649.GR16322@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412142159.23488.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.42.94] at Tue, 14 Dec 2004 20:59:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 December 2004 18:16, Andrea Arcangeli wrote:
>On Tue, Dec 14, 2004 at 11:02:39PM +0100, Pavel Machek wrote:
>> How much drift do you see?
>
>huge drift, minutes per hour or similar.

Which way?  I was running quite fast here, several minutes an
hour, then I discovered the tickadj command, found its default
was 10000, and started reducing it.  At 9926, I'm staying within
a sec an hour now.  I have no idea when this started, I didn't
discover it till I had already been running Ingo's realtime
patches for a while, then checked with a stock 2.6.9 and found it
was doing it then.

[...]

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

