Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTIOUzh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbTIOUzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:55:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17862 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261580AbTIOUzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:55:31 -0400
Date: Mon, 15 Sep 2003 22:55:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Bradford <john@grabjohn.com>
Cc: davidsen@tmr.com, zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030915205522.GP126@fs.tum.de>
References: <200309150632.h8F6WnHb000589@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309150632.h8F6WnHb000589@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 07:32:49AM +0100, John Bradford wrote:
>...
> It should be possible, and straightforward, to compile a kernel which:
> 
> 1. Supports, (I.E. has workarounds for), any combination of CPUs.
>    E.G. a kernel which supports 386s, and Athlons _only_ would not
>    need the F00F bug workaround.  Currently '386' kernels include it,
>    because '386' means 'support 386 and above processors'.
> 
> 2. Has compiler optimisations for one particular CPU.
>    E.G. the 386 and Athlon supporting kernel above could have
>    alignment optimised for either 386 or Athlon.
>...

That's the point where even I consider such a system to be too complex.

If you want maximum performance compile a kernel specific for your 
system.

Compiling a kernel that supports more than one CPU is for people that 
can even live with let's say a 10% performance penalty.

If you want to run a kernel on both a 386 and an Athlon it's most likely 
non-optimal for both of them.

> John.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

