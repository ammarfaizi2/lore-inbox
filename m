Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312492AbSCVWH4>; Fri, 22 Mar 2002 17:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312632AbSCVWHq>; Fri, 22 Mar 2002 17:07:46 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:24592 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312492AbSCVWHg>; Fri, 22 Mar 2002 17:07:36 -0500
Message-ID: <3C9BAAC8.15580DE@zip.com.au>
Date: Fri, 22 Mar 2002 14:06:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rahul Karnik <rahul@genebrew.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3Com 556B Tornado not working
In-Reply-To: <3C9822CD.47ED9565@zip.com.au> <58299.165.89.84.249.1016832733.squirrel@porsche.genebrew.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Karnik wrote:
> 
> Andrew,
> 
> > And try another you-know-which operating system.  If that works OK then
> > we know the hardware's good.
> 
> Finally bit the bullet and installed Windows 2000 on the laptop. Now the
> card works fine. This means the hardware is good (Thank God!), and that the
> vortex driver needs to be fixed.
> 
> By the way, I contacted some of the other people who noted similar behavior
> with this card on the vortex mailing list and they confirmed that their
> problems continue. Being a developer, I would really like to ditch the
> Windows install; how can I help debug this problem?

Well, please work off current 2.4.18/2.4.19-pre kernels.

Apply http://www.zip.com.au/~akpm/3c59x.patch so that
we're in sync.

Have a BIOS fiddle - disable any power management options,
disable APM/ACPI in kernel config, etc.

Then please go through the steps in the final section of
vortex.txt and send me all the output.

The 556 and 556B documentation has never been sighted,
but it's probably something silly.    Also please send
me the `lspci -vvvxxx' output when the card is fully
initialised, so I can compare it with my 556b.

Thanks.

-
