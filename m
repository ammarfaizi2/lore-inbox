Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277189AbRJDRcG>; Thu, 4 Oct 2001 13:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277197AbRJDRby>; Thu, 4 Oct 2001 13:31:54 -0400
Received: from tangens.hometree.net ([212.34.181.34]:25574 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S277189AbRJDRbi>; Thu, 4 Oct 2001 13:31:38 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Date: Thu, 4 Oct 2001 17:32:06 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9pi6em$itf$1@forge.intermeta.de>
In-Reply-To: <Pine.GSO.4.30.0110032057000.8016-100000@shell.cyberus.ca> <3BBC05EC.AA9BFB4F@candelatech.com> <9ph3qu$g9b$1@forge.intermeta.de> <3BBC89CC.D791C8FA@candelatech.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1002216726 4655 212.34.181.4 (4 Oct 2001 17:32:06 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 4 Oct 2001 17:32:06 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

>"Henning P. Schmiedehausen" wrote:
>> 
>> Does it finally do speed and duplex auto negotiation with Cisco
>> Catalyst Switches? Something I never ever got to work with various 2.0
>> and 2.2 drivers, mode settings, Catalyst settings, IOS versions and
>> almost anything else that I ever tried.

>Check the latest driver, it works with my IBM switch, and with other
>EEPRO and Tulip NICs now, so it may work for you.  The DLINK 4-port

Hi,

thanks for the suggestion, but I'm actually sold on using eepro100 and
3c59x NICs, both flavours never gave me any trouble (yes, I know about
the 3xc59x and I was always careful to choose either the "B" with 2.0
and early 2.2 and now the "C" with later 2.2. Call me a snob for going
the "FreeBSD way" and choosing HW that works and not taking the
challenge to bring even the most obscure HW lying in a bin at a
customer to work but telling the customer "you can now buy a new,
guaranteed flawlessly performing NIC for $25 or pay me for four hours
trying to get _that_ NIC to work. I charge a little more than $25 per
hour..". Got them every time. ;-)

Basically I burned [1] all my tulip NICs around a long time ago.

>several 2-port EEPRO based NICs out there that work really well
>too, but they are expensive...

Hm. If I really need more NICs than PCI slots, I normally use a
Router. And I've even toyed a little with a Gigabit card linked to a
Cisco C3524XL using a certain 802.1q unofficial extension to the Linux
kernel to try and provide 24 100 MBit Ethernet Interfaces from a
single Linux Box [2].

	Regards
		Henning

[1] Put them in the unavoidable Windows NT and 2000 boxes where most of them
    with "vendor supported, MHL approved, certified and signed drivers" 
    crash and burn as happily as under Linux. But the it is the fault of 
    "the other consultant". I don't do Windows. 

[2] Didn't work, though. Got a C7206 instead. O:-)


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
