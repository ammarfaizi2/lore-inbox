Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWCMTAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWCMTAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWCMTAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:00:07 -0500
Received: from macferrin.com ([65.98.32.91]:39172 "EHLO macferrin.com")
	by vger.kernel.org with ESMTP id S1750820AbWCMTAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:00:05 -0500
Message-ID: <4415C104.4000600@macferrin.com>
Date: Mon, 13 Mar 2006 11:59:16 -0700
From: Ken MacFerrin <lists@macferrin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Thunderbird/1.0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ken MacFerrin <lists@macferrin.com>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Dave Spring <dspring@acm.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
References: <43E0FC55.6080503@acm.org> <43EBD67E.9020308@acm.org> <200602100013.15276.s0348365@sms.ed.ac.uk> <43ED48AD.6060106@macferrin.com>
In-Reply-To: <43ED48AD.6060106@macferrin.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken MacFerrin wrote:
> Alistair John Strachan wrote:
> 
>> On Thursday 09 February 2006 23:55, Dave Spring wrote:
>>
>>> Just for closure's sake:
>>> This turned out to be a hardware problem.
>>> Memtest86+ http://www.memtest.org/ found an intermittent and
>>> pattern-sensitive memory error,
>>> and only appearing at one or two random locations within the 256M 
>>> module.
>>> Replacing the dodgy RAM module did the trick.
>>
>>
>>
>> Thanks Dave. Any update on your problem Ken? I'm keen to hear whether 
>> you had crashes without the NVIDIA driver loaded.
>>
> 
> Sorry, I got called out of town last weekend so I didn't get a chance to 
> try this out yet..
> -Ken

As a follow-up to close out this thread.  I only had a chance to test 
the nv driver for a short time before needing to go back to the xinerama 
capabilities of the Nvidia driver again.  I subsequently had a severe 
crash that beat up the filesystem pretty badly so I did a data backup 
and a clean install of Gentoo/KDE3.5 (kernel 2.6.15-r1) along with the 
binary Nvidia driver (1.0.8178-r3) and have not had the problem re-occur 
since.  The new install is using the same hardware and kernel config 
which has been stable for over a week of uptime now.  This would lead me 
to believe my previous install suffered from some evil filesystem 
gremlin that had snuck in from an earlier crash and continued to pop up 
to cause havok versus a genuine kernel bug.

I appreciate the help and feedback in trying to get this figured out.

Thanks,
Ken
