Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbUKWMqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUKWMqc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 07:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUKWMqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 07:46:32 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:6563 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261193AbUKWMq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 07:46:29 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Stupid question
Date: Tue, 23 Nov 2004 07:46:28 -0500
User-Agent: KMail/1.7
References: <200411212045.51606.gene.heskett@verizon.net> <200411221058.22276.gene.heskett@verizon.net> <87653wydi7.fsf@amaterasu.srvr.nix>
In-Reply-To: <87653wydi7.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411230746.28588.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.10.220] at Tue, 23 Nov 2004 06:46:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 07:08, Nix wrote:
>On 23 Nov 2004, Gene Heskett yowled:
>> On Monday 22 November 2004 09:32, P@draigBrady.com wrote:
>>>Gene Heskett wrote:
>>>> Greetings;
>>>>
>>>> Silly Q of the day probably, but what do I set in a Makefile for
>>>> the -march=option for building on a 233 mhz Pentium 2?
>>>
>>>http://www.pixelbeat.org/scripts/gcccpuopt
>>
>> Thanks very much.  Obviously someone else needed to scratch this
>> itch too.  This should produce the correct results when running on
>> the target machine.  Here, it produces this:
>> [root@coyote CIO-DIO96]# sh ../gcccpuopt
>>  -march=athlon-xp -mfpmath=sse -msse -mmmx -m3dnow
>
>... which is peculiar, as -mmmx -msse is redundant, as is -mmmx
> -m3dnow, and all three of those flags are the end are implied by
> -march=athlon-xp anyway.
>
Humm, as I see it, the choices presented in a make xconfig do not 
allow the choice of the athlon-xp, just the athlon.  Are there any 
worthwhile optimizations the added '-xp' would bring into play?  
Making it enough faster to make that choice a worthwhile choice?

Said another way, what file would I edit after the .config has been 
saved in order to put that into effect for the subsequent build?

>(-mfpmath=sse *is* useful on non-64-bit platforms, though.)

Oh?  As that stuff is pretty invisible during a make today, how would 
one go about determining if thats in effect on this machine?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
