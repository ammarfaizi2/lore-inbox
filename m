Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbUKWMVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUKWMVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 07:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbUKWMUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 07:20:32 -0500
Received: from gate.corvil.net ([213.94.219.177]:5383 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S262530AbUKWMT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 07:19:29 -0500
Message-ID: <41A32ABC.1090000@draigBrady.com>
Date: Tue, 23 Nov 2004 12:19:08 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: Stupid question
References: <200411212045.51606.gene.heskett@verizon.net>	<41A1F881.1000900@draigBrady.com>	<200411221058.22276.gene.heskett@verizon.net> <87653wydi7.fsf@amaterasu.srvr.nix>
In-Reply-To: <87653wydi7.fsf@amaterasu.srvr.nix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:
> On 23 Nov 2004, Gene Heskett yowled:
> 
>>On Monday 22 November 2004 09:32, P@draigBrady.com wrote:
>>
>>>Gene Heskett wrote:
>>>
>>>>Greetings;
>>>>
>>>>Silly Q of the day probably, but what do I set in a Makefile for
>>>>the -march=option for building on a 233 mhz Pentium 2?
>>>
>>>http://www.pixelbeat.org/scripts/gcccpuopt
>>
>>Thanks very much.  Obviously someone else needed to scratch this itch 
>>too.  This should produce the correct results when running on the 
>>target machine.  Here, it produces this:
>>[root@coyote CIO-DIO96]# sh ../gcccpuopt
>> -march=athlon-xp -mfpmath=sse -msse -mmmx -m3dnow
> 
> 
> ... which is peculiar, as -mmmx -msse is redundant, as is -mmmx -m3dnow,
> and all three of those flags are the end are implied by -march=athlon-xp
> anyway.
> 
> (-mfpmath=sse *is* useful on non-64-bit platforms, though.)

I added those in so that they were explicit.
They do no harm. I had a version that didn't print
these redundant options but got many requests
about whether they were needed. You can't win.

Pádraig.
