Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUIKKl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUIKKl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 06:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268090AbUIKKl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 06:41:58 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:31903 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S268089AbUIKKlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 06:41:55 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, regit@inl.fr
Subject: Re: 2.6.9-rc1-mm4 : typo in include/linux/hardirq.h ?
Date: Sat, 11 Sep 2004 06:41:53 -0400
User-Agent: KMail/1.7
References: <1094898290.4533.5.camel@porky>
In-Reply-To: <1094898290.4533.5.camel@porky>
Cc: Eric Leblond <eric@inl.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409110641.53689.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.153.91.225] at Sat, 11 Sep 2004 05:41:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 September 2004 06:24, Eric Leblond wrote:
>Hi,
>
>On my i386 computer, at line 5 of include/linux/hardirq.h we can
> read : #ifdef CONFIG_PREEPT
>It seems it should be
>#ifdef CONFIG_PREEMPT
>
>With this change, compilation of external driver like ndiswrapper
> works again.
>
>Please CC me as I've not subscribed to the list.
>
>BR,

That prompted me to go take a look at my .config in that dir, but I'm 
correct.  Perhaps you have a nilmerg?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
