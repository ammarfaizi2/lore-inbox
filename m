Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbUKWMtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbUKWMtD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 07:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUKWMtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 07:49:03 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:60870 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261191AbUKWMs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 07:48:56 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Stupid question
Date: Tue, 23 Nov 2004 07:48:55 -0500
User-Agent: KMail/1.7
References: <200411212045.51606.gene.heskett@verizon.net> <87653wydi7.fsf@amaterasu.srvr.nix> <41A32ABC.1090000@draigBrady.com>
In-Reply-To: <41A32ABC.1090000@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411230748.55252.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.10.220] at Tue, 23 Nov 2004 06:48:55 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 07:19, P@draigBrady.com wrote:
>Nix wrote:
>> On 23 Nov 2004, Gene Heskett yowled:
>>>On Monday 22 November 2004 09:32, P@draigBrady.com wrote:
>>>>Gene Heskett wrote:
>>>>>Greetings;
>>>>>
>>>>>Silly Q of the day probably, but what do I set in a Makefile for
>>>>>the -march=option for building on a 233 mhz Pentium 2?
>>>>
>>>>http://www.pixelbeat.org/scripts/gcccpuopt
>>>
>>>Thanks very much.  Obviously someone else needed to scratch this
>>> itch too.  This should produce the correct results when running
>>> on the target machine.  Here, it produces this:
>>>[root@coyote CIO-DIO96]# sh ../gcccpuopt
>>> -march=athlon-xp -mfpmath=sse -msse -mmmx -m3dnow
>>
>> ... which is peculiar, as -mmmx -msse is redundant, as is -mmmx
>> -m3dnow, and all three of those flags are the end are implied by
>> -march=athlon-xp anyway.
>>
>> (-mfpmath=sse *is* useful on non-64-bit platforms, though.)
>
>I added those in so that they were explicit.
>They do no harm. I had a version that didn't print
>these redundant options but got many requests
>about whether they were needed. You can't win.
>
>Pádraig.

I've heard that expression before :-)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
