Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289476AbSAOKUc>; Tue, 15 Jan 2002 05:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289482AbSAOKUV>; Tue, 15 Jan 2002 05:20:21 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:19290 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289476AbSAOKUD>;
	Tue, 15 Jan 2002 05:20:03 -0500
Message-ID: <3C4401CD.3040408@debian.org>
Date: Tue, 15 Jan 2002 11:17:49 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Subject: Autoconfiguration: Original design scenario
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2002 10:20:01.0943 (UTC) FILETIME=[31430270:01C19DAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

There are a lot of noise about autoconfiguration.
And the scenarios of ESR are not my original scenarios,
for which I worked autoconfigurator for nearly 1.5 years.


A lot of people already compiles the kernel.
(Why? Maybe ESR or other people haw sudied this, but
I don't know the answer)
proof: using the facts:
- there are a lot of kernel.org mirrors.
- posting in the user lists

The people will ocmpile the kernel without the
distribution's configuration, removing not needed
drivers.
(I don't have a proof, but the people that use .config
from distribution, normally use also the updated kernel
source package in the distribution.)

Finding card -> configuration is not easy.
You buy a network card (ethernet), which is the correct
driver? And the usb photo machine? The sound card?
Some info are in configure.help, but you should parse
20/50 entries before maybe to find your card name.


I designed autoconfigure to help these people.
So (at the beggining) a not complete detection,
but used to help the people that ALREADY normally
compile the kernel.


[ In Alan diary, I found that he tried some drivers
before to find the driver for Telsa new tape.
Autoconfigure will help also hackers.
Hmm. Was the card ISA? so forget the above example
]


So do you think autoconfigure can be usefull for people?


After adding a lot of detection and configuration in my
database I found that in a modern machine, autoconfigure
can build a complete and working configuration.

ESR read me autoconfiguration in this late stage, so
he thinks about the 'single button' step for some
aunts, students...

In summary: the autoconfigure is already usefull (IMHO)
for a lot of people.

The other ESR scenarios are 'add-on' without extra working.
They can be usefull, we can make it, but we should see if
distributions/users like the 'one key configuration and
building kernel'. Reading some *-users lists and doing
some support in IRC, I think think people wuould like
to use it.

Anyway these 'add-on' are nearly off-topic to lkml

	giacomo

