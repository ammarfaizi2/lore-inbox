Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbULLXnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbULLXnj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 18:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbULLXni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 18:43:38 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:31182 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262173AbULLXnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 18:43:37 -0500
Date: Mon, 13 Dec 2004 00:43:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041212234331.GO16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BCD5F3.80401@kolivas.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 10:36:19AM +1100, Con Kolivas wrote:
> The performance benefit, if any, is often lost in noise during 
> benchmarks and when there, is less than 1%. So I was wondering if you 
> had some specific advantage in mind for this patch? Is there some 
> arch-specific advantage? I can certainly envision disadvantages to lower Hz.

My last number I've here is 1% for kernel compile. We're not talking
fancy desktop stuff here, we're talking about raw computing servers that
runs in userspace 99.9% of the time where the 1% loss is going to be
multiplied dozen or hundred of times. For those HZ=1000 is a pure
tangible disavantage.

For desktops 1% of cpu being lost is not an issue of course.
