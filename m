Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288414AbSAUVU3>; Mon, 21 Jan 2002 16:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288420AbSAUVUN>; Mon, 21 Jan 2002 16:20:13 -0500
Received: from zero.tech9.net ([209.61.188.187]:4881 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288414AbSAUVT6>;
	Mon, 21 Jan 2002 16:19:58 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, george anzinger <george@mvista.com>,
        Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16ShcU-0001ip-00@starship.berlin>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
	<E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> 
	<E16ShcU-0001ip-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 21 Jan 2002 16:24:07 -0500
Message-Id: <1011648248.988.475.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-21 at 11:48, Daniel Phillips wrote:

> The disk and the IO thread are active a higher portion of the time, while the 
> kernel hog gets the same amount of time.  So in this case we have improved 
> both latency and throughput.
> 
> Naturally I constructed this case to show the effect most clearly.  There are 
> many possible variations on the above scenario.  It does seem to explain the 
> latency/throughput improvements that have been reported in practice.

Well put.  I think this is exact the scenario we are observing.

Its the same benefit to latency.  We react quicker.

	Robert Love

