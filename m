Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVC3U0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVC3U0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVC3U0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:26:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54194 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262436AbVC3UZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:25:45 -0500
Message-ID: <424B0B38.9060809@pobox.com>
Date: Wed, 30 Mar 2005 15:25:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: indrek.kruusa@tuleriit.ee
CC: Andi Kleen <ak@muc.de>, Asfand Yar Qazi <ay1204@qazi.f2s.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
References: <4242865D.90800@qazi.f2s.com>	<20050324093032.GA14022@havoc.gtf.org>	<20050324162706.GJ17865@csclub.uwaterloo.ca>	<42432A9F.3090507@pobox.com> <m1ekdz3hz0.fsf@muc.de> <424B013B.3010109@pobox.com> <424B0946.8060909@tuleriit.ee>
In-Reply-To: <424B0946.8060909@tuleriit.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indrek Kruusa wrote:
> Jeff Garzik wrote:
> 
>> Andi Kleen wrote:
>>
>>> Jeff Garzik <jgarzik@pobox.com> writes:
>>>
>>>> I won't disagree with your experiences.  For me, outside of one brief
>>>> moment when the r8169 driver didn't work on Athlon64, it has worked
>>>> flawlessly for me.
>>>>
>>>> RealTek 8169 is currently my favorite gigabit chip.
>>>
>>>
>>>
>>>
>>> It does not seem to support DAC (or rather it breaks with DAC 
>>> enabled), which makes it not very useful on any machine with >3GB of 
>>> memory.
>>
>>
>>
>> Driver bug.  I can futz with it and get it to do 64-bit on my Athlon64.
> 
> 
> 
> Continuing with off-topic questions: is this "checksum off-load" usable 
> with r8169? Is there any other reason (performance?) to use hardware 
> TCP/IP checksumming than just "cool, a little chunk of software is 
> hardwired again"?

It's usable, and enables "zero copy" feature.


> I have seen you mentioned that this causes mainly troubles if you try to 
> set it with ethtool. Is it still true?

Not sure what you are referring to.

	Jeff



