Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbRBCSq1>; Sat, 3 Feb 2001 13:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129275AbRBCSqR>; Sat, 3 Feb 2001 13:46:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:29706 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129188AbRBCSqN>; Sat, 3 Feb 2001 13:46:13 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: vaio doesn't boot with 2.4.1-ac1, stops at PCI: Probing PCI hardware
Date: 3 Feb 2001 10:45:59 -0800
Organization: Transmeta Corporation
Message-ID: <95hjl7$8qi$1@penguin.transmeta.com>
In-Reply-To: <20010202114102.E484@ookhoi.dds.nl> <E14Oe6c-0006HJ-00@the-village.bc.nu> <20010202122756.B3922@ookhoi.dds.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010202122756.B3922@ookhoi.dds.nl>, Ookhoi  <ookhoi@dds.nl> wrote:
>Hi Alan,
>
>> > Here it hangs hard. It used to boot with 2.4.0 and 2.4.1-prex  Should I
>> > try to determine which patch made the fatal change? Should I send my
>> 
>> That would be great.
>> 
>> Firstly however does 2.4.1 (Linus) boot ?
>
>It does boot. :-)  Is there something I can do now? 

The -ac patchset has the PCI bug re-introduced: in -ac the PCI probing
will basically disable the northbridge while probing for it, thus
killing the machine.. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
