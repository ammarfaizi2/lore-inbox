Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVJZTZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVJZTZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVJZTZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:25:29 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:45029 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964873AbVJZTZ3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:25:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j+okfTgm7BiNs1Uu3VWWLv5EnT0R2bBgMLXx2a1QpktzDhnYEqPixIF4Xgmx+24R0VJWsdxm0MWL4jsjx9gV4wVlVZxPIIkppCMzmdDFfhL/n8G8+i2weR78CA5DF6ERk8wDas4cbm2+tMEQ64+k6DoXvY6DcC4PXWI9GB4PZK4=
Message-ID: <21d7e9970510261225r6b84bc1at4bbb2d7c3754a759@mail.gmail.com>
Date: Thu, 27 Oct 2005 05:25:26 +1000
From: Dave Airlie <airlied@gmail.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Subject: Re: X unkillable in R state sometimes on startx , /proc/sysrq-trigger T output attached
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <5a4c581d0510260620o1a6ad678v6966dba3f40e8601@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0510251335ke8e7ae6n883e0b44a9920ce4@mail.gmail.com>
	 <21d7e9970510260325o2a47e6f5gc64d29eec42de086@mail.gmail.com>
	 <5a4c581d0510260522h3c98d1acsf4715a4d4865121c@mail.gmail.com>
	 <21d7e9970510260528k37cffb12h24d7b6fad7f3ed6e@mail.gmail.com>
	 <5a4c581d0510260620o1a6ad678v6966dba3f40e8601@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > if you just run X, does it always start to the X cursor without hanging..
>
> Will try. Note however, when I experience the problem X doesn't
>  really "hang" - it spins in CPU.

That's a hang from the graphics developers point of view, your
graphics card has crashed and X is spinning waiting for the card to
come back and say it is okay.. something it never does...

>
> For that matter, I'm running it now without issues... it
>  seems to get in the weird state only on startup.

I probably restart X about 5-10 times per working session and I've
never seen this yet, I'll do a few more reboots, we have a known issue
with a bug fix that went into X and I'm not sure if it is in your X
packages but it probably is.. can you tell me the FC4 xorg rpm titles
so I can check it, if it causing problems on AGP systems as well I'll
be pushing RH to release new X packages with a proper fix, that benh
is working on at the moment..

Dave.

>
> Thanks ! Ciao,
>
> --alessandro
>
>  "All it takes is one decision
>   A lot of guts, a little vision to wave
>   Your worries, and cares goodbye"
>
>    (Placebo - "Slave To The Wage")
>
