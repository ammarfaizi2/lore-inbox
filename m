Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVAKVGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVAKVGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVAKVDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:03:30 -0500
Received: from alog0337.analogic.com ([208.224.222.113]:10880 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262788AbVAKVAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:00:41 -0500
Date: Tue, 11 Jan 2005 15:58:15 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: john stultz <johnstul@us.ibm.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: New Linux System time proposal
In-Reply-To: <1105474167.4152.7.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0501111548400.3354@chaos.analogic.com>
References: <Pine.LNX.4.61.0501110930280.26281@chaos.analogic.com>
 <1105474167.4152.7.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, john stultz wrote:

> On Tue, 2005-01-11 at 09:31 -0500, linux-os wrote:
>> I think that Linux time should be re-thought and done over once and
>> for all.
>
> I agree, and I've been working on this for awhile.
>
> You can find an outdated summery of my ideas here:
> http://lwn.net/Articles/100665/
>
> And as soon as I get ppc64 booting I'll be sending out a new release of
> the code.
>
> thanks
> -john
>

I'm glad you are working on it. The system I proposed is the same
thing that was done in VAX/VMS. There was never any need to upset
any timing anywhere because it was just BOOTTIME + OFFSET +
uFORTNIGHT-tick = (quadword) time.

A more modern version for Linux would "simplicate and add lightness",
as well as get rid of the:

    warning:  Clock skew detected.  Your build may be incomplete.

...from `make` as a result of more-and-more-usual time jumps.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
