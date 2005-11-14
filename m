Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVKNUyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVKNUyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVKNUyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:54:01 -0500
Received: from nwd2mail1.analog.com ([137.71.25.50]:12438 "EHLO
	nwd2mail1.analog.com") by vger.kernel.org with ESMTP
	id S932115AbVKNUyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:54:00 -0500
Message-Id: <6.1.1.1.0.20051114132644.01ec1170@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Mon, 14 Nov 2005 15:53:42 -0500
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Cc: linux-kernel@vger.kernel.org, luke.adi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
>What _is_ a bluefin, anyway?

He he -- I will have to tell the people doing the ads that their money 
could be better spend on other things...

Since you asked - The Blackfin Processor includes the common 4 processor Ps 
that people request for embedded designs - price, power, performance & 
penguins.

The Blackfin Processor manufactured by Analog Devices is based on the 
MicroSignal Architecture jointly developed by Analog Devices and Intel. It 
combines a RISC programming model, with high performance signal processing 
and power efficiency - and is running uClinux today.

For example - we are running a completely open source WiSIP Phone - via 
LinPhone (VoIP) & a 802.11b Compact Flash card, on a processor which is 
less than $5.00 (BF531).

I personally think that uClinux on a $5.00 processor will increase uClnux's 
use in the embedded market, where it may not have been looked at in the 
past due to the price of the computation power that it has required. You 
now can make a board that runs the Linux networking stack for under $20 
(including CPU, SDRAM, and Flash, and 10/100 Phy).

Greg wrote:
>Does this arch have corporate support behind it to maintain it over time, 
>or is something you are going to do in your spare time (which is fine, 
>just curious.)

As Bernd indicated - there is a small dedicated team (about 12 people, 
split between the Norwood, Munich, and Shanghai) from Analog Devices - 
testing, maintaining and supporting the ports we have done for the 
toolchain, bootLoader, and kernel. We do this primarily through our web 
site at blackfin.uclinux.org - We answer questions, review patches, write 
documentation, and interact with the over 1,200 registered 
developers/users, and 38,000 unregistered users downloading the over 576 
Terabytes/month from our site.

>The process is like maintaining any other part of the kernel:
>   - Try to make sure it works on all releases (harder to do with a full
>     arch, I know, but not impossible.)

A critical part of our development team is our full time testers. We take 
the investment in test pretty seriously - we were the first no-mmu 
architecture to run LTP, and ported this to Tinderbox as an overall test 
tool - to keep cvs as stable as possible. Right now, our tinderbox clients 
pull from our cvs, but it shouldn't be too difficult to make things pull 
from the proper tree once we are in it.

>   - keep it up to date with bugfixes and the such
>   - be responsive to questions from other developers
>   - accept patches from others and intregrate them into the mainline
>     version in a reasonable ammount of time.

Right now, we do most of this on our project web site - I think it is just 
a matter of also keeping track of the lkml, and answering questions that 
pop up here.

-Robin  

