Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTCDXJJ>; Tue, 4 Mar 2003 18:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTCDXIc>; Tue, 4 Mar 2003 18:08:32 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:65432 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S265285AbTCDXDS>;
	Tue, 4 Mar 2003 18:03:18 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200303042312.CAA06199@sex.inr.ac.ru>
Subject: Re: PCI init issues
To: ink@jurassic.park.msu.ru (Ivan Kokshaysky)
Date: Wed, 5 Mar 2003 02:12:50 +0300 (MSK)
Cc: torvalds@transmeta.com, ink@jurassic.park.msu.ru, raarts@office.netland.nl,
       david.knierim@tekelec.com, alexander@netintact.se, becker@scyld.com,
       greg@kroah.com, hadi@cyberus.ca, jgarzik@pobox.com,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       Robert.Olsson@data.slu.se
In-Reply-To: <20030305014656.B678@localhost.park.msu.ru> from "Ivan Kokshaysky" at Mar 5, 3 01:46:56 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>   - XP is able to reprogramm the IO_APIC so that all four pins are
>     routed properly.
> 
> Sounds a bit heretical, I know. :-)

Let me to cite message from Znyx engineer.

>>The question is important. Looking into our implemenation, I see
>>that it is strongly bound to correctness of mp table.
>
>We had a similar problem in about 1994, when we designed
>the first multi-port adapters with a bridge. Most BIOSes at that
>point did not initialize PPBs, or they did not do it correctly. We
>decided to build the required support into our drivers. That meant
>that some vendors with broken BIOS would point to us and say 'see
>it works'. Our advantage in selling these people adapters, but
>maybe it took a bit longer for the market to force vendors to fix
>BIOSes.

So, maybe the workaround is in znyx driver for XP. :-)
BIOSes were fixed to understand the first level bridges,
but I guess none of them construct correct tables
for second level bridges.

Alexey
