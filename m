Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310398AbSCPPML>; Sat, 16 Mar 2002 10:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310399AbSCPPMC>; Sat, 16 Mar 2002 10:12:02 -0500
Received: from pD9E5353E.dip.t-dialin.net ([217.229.53.62]:61923 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S310398AbSCPPLr>;
	Sat, 16 Mar 2002 10:11:47 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dan Maas <dmaas@dcine.com>, Jeremy Jackson <jerj@coplanar.net>,
        linux-kernel@vger.kernel.org
Subject: Re: unwanted disk access by the kernel?
In-Reply-To: <005401c1cc51$ab6c3fe0$1a02a8c0@allyourbase>
	<E16lwyE-0004N7-00@the-village.bc.nu>
	<20020316013027.GD363@matchmail.com>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Sat, 16 Mar 2002 16:11:36 +0100
In-Reply-To: <20020316013027.GD363@matchmail.com> (Mike Fedyk's message of
 "Fri, 15 Mar 2002 17:30:27 -0800")
Message-ID: <m3n0x8pmxj.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:
> On Fri, Mar 15, 2002 at 07:02:30PM +0000, Alan Cox wrote:
>> > By the way, if I enable 'APM makes CPU idle calls when idle,' I get a
>> > constant stream of 'apm_do_idle failed (3)' messages. APM also doesn't seem
>> > to be able to power the machine down... This is a Dell Inspiron 7500...
>> > Maybe I should try ACPI?
>> 
>> ACPI is a bit experimental right now but if you want some fun then obviously
>> the more people who break the ACPI code the better.
>
> For my uses (basically just power down) ACPI has worked on 99% of my
> machines (mix of pii & piii).

Same here (I'd rather say 100%). Temperature reading seems to work in
all machines as well. That's just machines I'm actually touching,
though; so they tend not to be supermarket bargains.

On a halfway related note APM fails to power down my Siemens PCD-5ND
(Pentium 75 laptop) (which obviously doesn't support ACPI).

The interesting thing is that the kernel shipped with RH 7.2 does
power down the machine, just the one from kernel.org doesn't
(2.4.16). (APM compiled as a module).

Is there some patch I could try?


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
