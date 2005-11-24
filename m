Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbVKXWZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbVKXWZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 17:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbVKXWZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 17:25:15 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:44019 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1161063AbVKXWZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 17:25:13 -0500
In-Reply-To: <20051124203250.GA9086@in.ibm.com>
References: <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu> <43822480.6080301@mvista.com> <20051121212653.GA6143@elte.hu> <EDDB1894-5AFB-11DA-A840-000A959BB91E@mvista.com> <20051124145734.GA2717@elte.hu> <20051124202637.GB9098@in.ibm.com> <20051124203250.GA9086@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2D7EF10A-5D39-11DA-90F9-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: "David F. Carlson" <dave@chronolytics.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
From: david singleton <dsingleton@mvista.com>
Subject: Re: PI BUG with -rt13
Date: Thu, 24 Nov 2005 14:25:11 -0800
To: dino@in.ibm.com
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 24, 2005, at 12:32 PM, Dinakar Guniguntala wrote:

> On Fri, Nov 25, 2005 at 01:56:37AM +0530, Dinakar Guniguntala wrote:
>> On Thu, Nov 24, 2005 at 03:57:34PM +0100, Ingo Molnar wrote:
>>>
>>> * david singleton <dsingleton@mvista.com> wrote:
>>>
>>>> Sure.  Attached is the locking fix patch. [...]
>>>
>>> thanks, applied - it should show up in -rt15.
>>>
>>
>> I just noticed with the above fix, Paul's testcase completely
>> hangs up and when killed I hit the BUG mentioned below.
>> Till -rt13, this testcase just ran to completion
>
> Forgot to mention that I notice the same failure with -rt15 as well
>

I'll start looking at this right away.

thanks

David
> 	-Dinakar
>

