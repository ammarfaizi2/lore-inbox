Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268200AbUHTUST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268200AbUHTUST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUHTUST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:18:19 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:20707 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S268721AbUHTURL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:17:11 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 20 Aug 2004 16:17:09 -0400
User-Agent: KMail/1.6.82
Cc: "R. J. Wysocki" <rjwysocki@sisk.pl>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408201329.05176.gene.heskett@verizon.net> <200408202211.46854.rjwysocki@sisk.pl>
In-Reply-To: <200408202211.46854.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408201617.09245.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.62.54] at Fri, 20 Aug 2004 15:17:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 August 2004 16:11, R. J. Wysocki wrote:[...]

>There's a simple test you can do unless your DIMMs must go in pairs
> (I don't remember if it's required by nforce2): remove one of them
> and see what happens.

To get dual channel DDR, they have to be in a pair.  Since this post, 
they've been swapped one for the other, and I'll be curious to see if 
the address goes to an even address when it errors, which it hasn't 
yet.

> If you can reproduce the same symptoms on 
> each of them separately, I'd bet on a cache problem.
>
That makes sense, so I can try that too.  I hadn't thought of that, 
duh!
>Greetings,

Someone else asked if ECC was on, but this board doesn't have it, and 
the memory has a blank pattern where the parity chip would be.  So I 
think its safe to say no :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
