Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbULMVG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbULMVG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbULMVG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:06:58 -0500
Received: from smtpout.mac.com ([17.250.248.85]:39126 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261173AbULMVGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:06:45 -0500
In-Reply-To: <200412131910.24255.rudmer@legolas.dynup.net>
References: <20041213020319.661b1ad9.akpm@osdl.org> <Pine.LNX.4.61.0412131603370.14874@student.dei.uc.pt> <200412131910.24255.rudmer@legolas.dynup.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DF0A1C6E-4D4A-11D9-B873-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       linux-kernel@vger.kernel.org
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: 2.6.10-rc3-mm1
Date: Mon, 13 Dec 2004 22:06:34 +0100
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Dec 2004, at 19:10, Rudmer van Dijk wrote:

> On Monday 13 December 2004 17:15, Marcos D. Marado Torres wrote:
>> On Mon, 13 Dec 2004, Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/ 
>>> 2.6.10-rc3/
>>> 2.6.10-rc3-mm1/
>>>
>>> - Lots of new patches, lots of little fixes all over the place.
>>>
>>> - Probably the major change is the readahead rework, which may have
>>>  significant performance impacts on some workloads.  Not necessarily
>>> good, either...
>>>
>>> - See below for the list of 31 patches which I have pending for  
>>> 2.6.10.
>>> If there are other patches here which should go in, please let me  
>>> know.
>>
>> Greetings,
>>
>> Fortunately with this -rc3-mm1 I no longer have the acpi_power_off  
>> problem
>> that I had in -rc2-mm's, described in  
>> http://lkml.org/lkml/2004/12/12/110 .
>>
>> OTOH, while I had no problems with the previous mm's or with  
>> 2.6.10-rc3,
>> with -rc3-mm1 kdm has an weird function: with kdm/unstable uptodate
>> 4:3.3.1-3 from Debian it just restarts X when it's going to show the
>> login/password form, restarting over and over.
>
> saw it too with gdm on Gentoo, I tried to track it down but could not  
> come up
> with a solution... I'm now back to rc2-mm4

Seems a problem with an "ioctl" call.

