Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbULBU23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbULBU23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbULBU2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:28:25 -0500
Received: from alog0004.analogic.com ([208.224.220.19]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261751AbULBU2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:28:04 -0500
Date: Thu, 2 Dec 2004 15:25:07 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: cliff white <cliffw@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, mbligh@aracnet.com, akpm@osdl.org,
       torvalds@osdl.org, clameter@sgi.com, hugh@veritas.com,
       benh@kernel.crashing.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
In-Reply-To: <20041202101029.7fe8b303.cliffw@osdl.org>
Message-ID: <Pine.LNX.4.61.0412021522210.5287@chaos.analogic.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com>
 <20041201223441.3820fbc0.akpm@osdl.org> <41AEBAB9.3050705@pobox.com>
 <20041201230217.1d2071a8.akpm@osdl.org> <179540000.1101972418@[10.10.2.4]>
 <41AEC4D7.4060507@pobox.com> <20041202101029.7fe8b303.cliffw@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004, cliff white wrote:

> On Thu, 02 Dec 2004 02:31:35 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
>
>> Martin J. Bligh wrote:
>>> Yeah, probably. Though the stress tests catch a lot more than the
>>> functionality ones. The big pain in the ass is drivers, because I don't
>>> have a hope in hell of testing more than 1% of them.
>>
>> My dream is that hardware vendors rotate their current machines through
>> a test shop :)  It would be nice to make sure that the popular drivers
>> get daily test coverage.
>>
>> 	Jeff, dreaming on
>

It isn't going to happen until the time when the vendors
call somebody a liar, try to get them fired, and then
that somebody takes them to court and they lose 100
million dollars or so.

Until that happens, vendors will continue to make junk
and they will continue to lie about the performance of
that junk. It doesn't help that Software Engineering has
become a "hardware junk fixing" job.

Basically many vendors in the PC and PC peripheral
business are, for lack of a better word, liars who
are in the business of perpetrating fraud upon the
unsuspecting PC user.

We have vendors who convincingly change mega-bits
to mega-bytes, improving performance 8-fold without
any expense at all. We have vendors reducing the
size of a kilobyte and a megabyte, then getting
the new lies entered into dictionaries, etc. The
scheme goes on.

In the meantime, if you try to perform DMA
across a PCI/Bus at or near the specified rates,
you will learn that the specifications are
for "this chip" or "that chip", and have nothing
to do with the performance when these chips
get connected together. You will find that real
performance is about 20 percent of the specification.

Occasionally you find a vendor that doesn't lie and
the same chip-set magically performs close to
the published specifications. This is becoming
rare because it costs money to build motherboards
that work. This might require two or more
prototypes to get the timing just right so the
artificial delays and re-clocking, used to make
junk work, isn't required.

Once the PC (and not just the desk-top PC) became
a commodity, everything points to the bottom-line.
You get into the business by making something that
looks and smells new. Then you sell it by writing
specifications that are better than the most
expensive on the market. Your sales-price is
set below average market so you can unload this
junk as rapidly as possible.

Then, you do this over again, claiming that your
equipment is "state-of-the-art"! And if anybody
ever tests the junk and claims that it doesn't
work as specified, you contact the president of
his company and try to kill the messenger.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
