Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUILVGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUILVGk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUILVGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:06:40 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:6635 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S262406AbUILVGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:06:21 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4 - slowdown?
Date: Sun, 12 Sep 2004 17:06:18 -0400
User-Agent: KMail/1.7
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Andrew Morton <akpm@osdl.org>
References: <20040912161119.GR2260@mail.muni.cz> <200409121852.36844.rjw@sisk.pl>
In-Reply-To: <200409121852.36844.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409121706.18251.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.54.11] at Sun, 12 Sep 2004 16:06:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 September 2004 12:52, Rafael J. Wysocki wrote:
>On Sunday 12 of September 2004 18:11, Lukas Hejtmanek wrote:
>> Hello,
>>
>> I have fish-fillets game ported to linux. Under 2.6.9-rc1-bk9 it
>> eats up to
>
>10%
>
>> with normal speed of game and up to 40% with fast mode.
>> Under 2.6.9-rc1-mm4 it eats up to 40% with normal speed of game
>> and cpu is
>
>too
>
>> slow for fast mode.
>>
>> Any ideas?
>
>Yup.  You've just discovered a difference between the nicksched and
> the "stock" CPU scheduler, it seems. ;-)

Humm, could this explain why, when I was running amflush this morning 
after my journalling failure and subsequent reboot, that the data 
being copied from /dev/hda7 to /dev/hdb2 was moving at the grand 
total of about 40k to 50k/second instead of the >20MB/sec I expected?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
