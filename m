Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317505AbSFKS2v>; Tue, 11 Jun 2002 14:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317501AbSFKS2u>; Tue, 11 Jun 2002 14:28:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60151 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317503AbSFKS2m>; Tue, 11 Jun 2002 14:28:42 -0400
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
From: Robert Love <rml@tech9.net>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au
In-Reply-To: <Pine.LNX.4.44.0206111917310.3521-100000@sharra.ivimey.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Jun 2002 11:28:36 -0700
Message-Id: <1023820116.22156.271.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-11 at 11:21, Ruth Ivimey-Cook wrote:

> Perhaps it's just because I'm coming in late, but I cannot understand why
> NR_CPUS cannot be as low as 4 by default, for all archs, and then in the
> kernel boot messages, should more be found than is configured for a message is
> emitted to say "reconfigure your kernel", and continue with the number it was
> configured for. I personally only rarely see 2-way boxes, 4-way is pretty
> rare, and anything more must surely count as very specialized.

Ugh let's stop this thread now.  Two points:

	(a) imo, the kernel should support out-of-the-box the maximum
	    number of CPUs it can handle.  Be lucky we now have a
	    configure option to change that.  But that does not matter..

	(b) Right now it is 32.  Now you can change it... if you want
	    to change the current behavior by _default_ why don't we
	    suggest that _after_ this is accepted into 2.5?  I.e., one
	    battle at a time.

Thanks,

	Robert Love

