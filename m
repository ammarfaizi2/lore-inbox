Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319503AbSH3Ii6>; Fri, 30 Aug 2002 04:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319508AbSH3Ii6>; Fri, 30 Aug 2002 04:38:58 -0400
Received: from AMarseille-201-1-3-142.abo.wanadoo.fr ([193.253.250.142]:15216
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S319502AbSH3Ii5>; Fri, 30 Aug 2002 04:38:57 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>
Subject: Re: ide-2.4.20-pre4-ac2.patch
Date: Fri, 30 Aug 2002 11:43:05 +0200
Message-Id: <20020830094305.29922@192.168.4.1>
In-Reply-To: <Pine.LNX.4.44.0208300141070.8911-100000@serv>
References: <Pine.LNX.4.44.0208300141070.8911-100000@serv>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > It's for m68k and ppc Amigas, but I don't think two separate drivers are
>> > needed.
>>
>> So its actually a false divide and dumping them in "legacy" is probably
>> a lot simpler ?
>
>Hmm, somehow I more like "m68k". :)

If it's PPC side is limited to PPC amiga's (APUS), then leave it
in m68k. PPC Amiga's are really m68k machines with a hacked PPC
in the CPU slot ;)

Though such problems may come back if we ever decide to support
the PPC CPU cards for old m68k macs, and if I finally merge the
support for NuBus pmacs, oh well...

Ben.


