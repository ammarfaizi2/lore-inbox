Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbUL3FFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbUL3FFs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 00:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUL3FFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 00:05:48 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:59360 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261544AbUL3FFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 00:05:33 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-ac1
Date: Thu, 30 Dec 2004 00:05:31 -0500
User-Agent: KMail/1.7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1104103881.16545.2.camel@localhost.localdomain>
In-Reply-To: <1104103881.16545.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412300005.31211.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.52.185] at Wed, 29 Dec 2004 23:05:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 December 2004 18:31, Alan Cox wrote:
>Linux 2.6.10-ac1 is a merge of the stuff that has not yet been
> accepted upstream along with a couple of small extra changes that
> are needed because of changes in 2.6.10 base. In addition the
> generic IRQ work in 2.6.10 means that the forward port of the
> irqpoll code now covers a lot more platforms.

Maybe I spoke too soon Alan, my logs are being flooded with 
some sort of an error message that looks like it may be memory
related.  There's a pair of half giggers in here, running at 333 fsb,
but they are supposedly rated for a 400 mhz fsb. Thats presumably
because I have turned on the MCE stuffs.

Dec 29 23:43:09 coyote kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 29 23:43:09 coyote kernel: Bank 2: d40040000000017a
Dec 29 23:43:24 coyote kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 29 23:43:24 coyote kernel: Bank 1: d400400000000152
Dec 29 23:43:24 coyote kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 29 23:43:24 coyote kernel: Bank 2: d40040000000017a
Dec 29 23:43:39 coyote kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 29 23:43:39 coyote kernel: Bank 1: 9400400000000152
Dec 29 23:43:39 coyote kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 29 23:43:39 coyote kernel: Bank 2: d40040000000017a
Dec 29 23:43:54 coyote kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 29 23:43:54 coyote kernel: Bank 1: d400400000000152
Dec 29 23:43:54 coyote kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 29 23:43:54 coyote kernel: Bank 2: d40040000000017a
Dec 29 23:44:09 coyote kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 29 23:44:09 coyote kernel: Bank 1: d400400000000152
Dec 29 23:44:09 coyote kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 29 23:44:09 coyote kernel: Bank 2: d40040000000017a

And I've not seen that before.  Does it have a simple and correct answer?

This memory was abused by memtest86 for about 18 hours before I rebooted
and started changing things around because it was a new motherboard
and video card, back in the spring.  No errors were reported then.

Should I worry or just shut that stuff back off?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
