Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272553AbRHaDe7>; Thu, 30 Aug 2001 23:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272595AbRHaDet>; Thu, 30 Aug 2001 23:34:49 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:48389 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S272553AbRHaDea>;
	Thu, 30 Aug 2001 23:34:30 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108310334.f7V3YZm442148@saturn.cs.uml.edu>
Subject: Re: Athlon doesn't like Athlon optimisation?
To: david@digitalaudioresources.org (David Hollister)
Date: Thu, 30 Aug 2001 23:34:35 -0400 (EDT)
Cc: jan@gondor.com (Jan Niehusmann), linux-kernel@vger.kernel.org,
        rgooch@atnf.csiro.au
In-Reply-To: <3B8EFF67.9010409@digitalaudioresources.org> from "David Hollister" at Aug 30, 2001 08:07:19 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard, the FAQ could use an entry about this and the other VIA problem.

David Hollister writes:
> Jan Niehusmann wrote:

>> I have a computer with a duron 600 which doesn't like current athlon
>> optimised kernels: It runs fairly well with an old 2.4.0-test7 kernel
...
>> Is it likely to be a broken CPU? 
>> The board is an A7V with the infamous via chipset, but I don't think
>> this looks like the typical via problems, does it?
...
> point is, your hardware is likely fine (fine being relative, I
> suppose) If there are other tricks, I'm all ears.

There are highly optimized memory copy/clear operations that
run twice as fast on the Athlon, thus demanding more from the
motherboard and power supply. You have a VIA chipset and most
likely have a relatively weak power supply.

Don't go blaming Linux when power supply upgrades sometimes
make this problem go away. You could also try one of the
recent SiS or ALi chipsets.

I just saw a reference (maybe www.tomshardware.com) to AMD's new
chips having trouble on VIA boards -- I'd guess that the Palimino
core can push the motherboard too hard without fancy Athlon code.

