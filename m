Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTLEDvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 22:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTLEDvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 22:51:43 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:34768 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S263777AbTLEDvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 22:51:41 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: "Rahsheen Porter Sr." <microrahsheen@comcast.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: HPT366 ate my IDE controllers
Date: Thu, 4 Dec 2003 22:51:40 -0500
User-Agent: KMail/1.5.1
References: <20031204211522.01e89897.microrahsheen@comcast.net>
In-Reply-To: <20031204211522.01e89897.microrahsheen@comcast.net>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312042251.40092.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.10.15] at Thu, 4 Dec 2003 21:51:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 December 2003 21:15, Rahsheen Porter Sr. wrote:
>When I boot 2.6.0test11 on my Abit BP6, it *only* sees the HPT366
>controllers. The other 2 controllers built in to the mobo don't show
>up at all. All I see is what's plugged into the 2 HPT366
> controllers.
>
>So my root partition, which resides on /dev/hde1 with 2.4.20,
> becomes /dev/hda1. And my extra partitions that were on /dev/hdg
> are on /dev/hdc. This wouldn't be a problem accept that what was on
> /dev/hda and hdc are now gone.
>
>What would cause the kernel to totally ignore the built in
> controllers?

I'd bet a small amount that there is something in the bios you've set 
that is making that decision for you.  Probably a boot offboard 
controllers first or some such.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

