Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317470AbSFKSTf>; Tue, 11 Jun 2002 14:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSFKSTe>; Tue, 11 Jun 2002 14:19:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46322 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317470AbSFKSTe>; Tue, 11 Jun 2002 14:19:34 -0400
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
From: Robert Love <rml@tech9.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
In-Reply-To: <Pine.LNX.4.33L2.0206111102110.2449-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Jun 2002 11:19:34 -0700
Message-Id: <1023819574.22156.258.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-11 at 11:09, Randy.Dunlap wrote:

> I don't know what is "typical" for non-x86, but for x86, why not
> use something more like a 'typical' NR_CPUS for SMP, like 8 (?)...
> why still waste all of that memory?

Well right now we set it to 32...

I think out-of-the-box Linux, with SMP set, should support the maximum
number of CPUs.  While we do save some memory I do not think it is going
to be huge with 8 vs 32.

But whatever you, Linus, and the arch maintainers say... all my boxen
are 2-way so I don't care ;)

> What was this problem?  I missed it but would like to see it.
> (or do you know what the Subject: was?)

Not sure to be honest.  The subject was "[patch] CONFIG_NR_CPUS"

Or ask Andrew...

> One spello (typo) below.
> 
> | +  mimimum value which makes sense is 2.

(cough) someone else wrote that ;)

Fixed, thanks.

	Robert Love


