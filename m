Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbUBYQM6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbUBYQM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:12:57 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:26898 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261383AbUBYQM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:12:56 -0500
Message-ID: <403CCBE0.7050100@techsource.com>
Date: Wed, 25 Feb 2004 11:22:56 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: Chris Wedgwood <cw@f00f.org>, Pavel Machek <pavel@ucw.cz>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@fs.tum.de>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
References: <7F740D512C7C1046AB53446D37200173EA2718@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D37200173EA2718@scsmsx402.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nakajima, Jun wrote:
> No, it's not a problem. Branches with 16-bit operand size are not useful
> for compilers.

 From AMD's documentation, I got the impression that 66H caused near 
branches to be 32 bits in long mode (default is 64).

So, Intel makes it 16 bits, and AMD makes it 32 bits?

Either way, I don't see much use for either one.

> 
> Jun 
> 
>>-----Original Message-----
>>From: Chris Wedgwood [mailto:cw@f00f.org]
>>Sent: Tuesday, February 24, 2004 5:53 PM
>>To: Nakajima, Jun
>>Cc: Pavel Machek; Linus Torvalds; Adrian Bunk; Herbert Poetzl; Mikael
>>Pettersson; Kernel Mailing List
>>Subject: Re: Intel vs AMD x86-64
>>
>>On Tue, Feb 24, 2004 at 03:15:18PM -0800, Nakajima, Jun wrote:
>>
>>
>>>Near branch with 66H prefix:
>>>  As documented in PRM the behavior is implementation specific and
>>>  should avoid using 66H prefix on near branches.
>>
>>Presumably this isn't a problem with current gcc's right?
>>

