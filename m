Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317475AbSFKSVf>; Tue, 11 Jun 2002 14:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSFKSVe>; Tue, 11 Jun 2002 14:21:34 -0400
Received: from ivimey.org ([194.106.52.201]:17191 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S317475AbSFKSVd>;
	Tue, 11 Jun 2002 14:21:33 -0400
Date: Tue, 11 Jun 2002 19:21:18 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>,
        <akpm@zip.com.au>
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
In-Reply-To: <Pine.LNX.4.33L2.0206111102110.2449-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0206111917310.3521-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Randy.Dunlap wrote:

>On 11 Jun 2002, Robert Love wrote:
>
>| Here are the defaults I picked:
>|
>| CONFIG_NR_CPUS=32: i386, mips, parisc, ppc, sparc
>
>I don't know what is "typical" for non-x86, but for x86, why not
>use something more like a 'typical' NR_CPUS for SMP, like 8 (?)...
>why still waste all of that memory?

Perhaps it's just because I'm coming in late, but I cannot understand why
NR_CPUS cannot be as low as 4 by default, for all archs, and then in the
kernel boot messages, should more be found than is configured for a message is
emitted to say "reconfigure your kernel", and continue with the number it was
configured for. I personally only rarely see 2-way boxes, 4-way is pretty
rare, and anything more must surely count as very specialized.

Let the defaults be reasonable for 99% of users (IMO 99.9%), and let the rest 
have to think about config options...

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

