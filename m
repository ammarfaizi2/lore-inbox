Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266400AbRGLWrT>; Thu, 12 Jul 2001 18:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266416AbRGLWrJ>; Thu, 12 Jul 2001 18:47:09 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:51984 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S266400AbRGLWq6>; Thu, 12 Jul 2001 18:46:58 -0400
Date: Thu, 12 Jul 2001 22:46:55 +0000 (GMT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: ognen@gene.pbi.nrc.ca
cc: linux-kernel@vger.kernel.org
Subject: Re: strange 2.4.x behavior on a dual-celeron machine
In-Reply-To: <Pine.LNX.4.30.0107121622030.2802-100000@gene.pbi.nrc.ca>
Message-ID: <Pine.LNX.4.10.10107122241290.3018-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> eventually grinds to a halt after a new 2.4.2 (2.4.5 and 2.4.6 also)
> kernel was installed. Worked fine with 2.2.x

2.2 merely ignores APIC errors.  that doesn't mean they don't happen...

> ..... CPU clock speed is 551.2507 MHz.
> ..... host bus clock speed is 100.2273 MHz.

naughty, naughty.  
I've never known any dual FSB100-overclocked celeron machine to run stably.

> APIC error on CPU0: 00(08)

read as "apic hardware detected a corrupt inter-processor message
and automatically retried it".  unfortunately, the checksum is weak,
so with even a modest stream of such errors, there will be uncaught ones.

also, this covered in the kernel FAQ.

regards, mark hahn.

