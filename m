Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbUKVQdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbUKVQdW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUKVQac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:30:32 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:23229 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262157AbUKVP60
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:58:26 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Stupid question
Date: Mon, 22 Nov 2004 10:58:22 -0500
User-Agent: KMail/1.7
References: <200411212045.51606.gene.heskett@verizon.net> <41A1F881.1000900@draigBrady.com>
In-Reply-To: <41A1F881.1000900@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411221058.22276.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.10.220] at Mon, 22 Nov 2004 09:58:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2004 09:32, P@draigBrady.com wrote:
>Gene Heskett wrote:
>> Greetings;
>>
>> Silly Q of the day probably, but what do I set in a Makefile for
>> the -march=option for building on a 233 mhz Pentium 2?
>
>http://www.pixelbeat.org/scripts/gcccpuopt

Thanks very much.  Obviously someone else needed to scratch this itch 
too.  This should produce the correct results when running on the 
target machine.  Here, it produces this:
[root@coyote CIO-DIO96]# sh ../gcccpuopt
 -march=athlon-xp -mfpmath=sse -msse -mmmx -m3dnow

-- 
Cheers & thanks again, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
