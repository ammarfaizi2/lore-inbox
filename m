Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbSLSWF6>; Thu, 19 Dec 2002 17:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbSLSWF5>; Thu, 19 Dec 2002 17:05:57 -0500
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:60422 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S266998AbSLSWF5>; Thu, 19 Dec 2002 17:05:57 -0500
Subject: Re: parport_serial link order bug, NetMos support
In-Reply-To: <Pine.LNX.4.50.0212191049020.2159-100000@montezuma.mastecende.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Date: Thu, 19 Dec 2002 23:13:50 +0100 (CET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E18P8vO-0005Rs-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have local patches which do the same and have been using them for about
> a year too (also at 115k). Regarding the parallel port aspect of the card,
> i have tested using shared IRQs by running an epat cdrom via said port and
> generating a high amount of serial i/o

Could you send me your local patches?  (I use parport in polling mode.)

> 00:10.0 Communication controller: NetMos Technology 222N-2 I/O Card (2S+1P) (rev 01)

Actually, these PCI vendor:device IDs are not specific to any card,
they are hardwired inside the NM9835 chip.  My no-name cards (made in
China) have an empty place instead of the the configuration EEPROM.

> Last time i posted regarding this, Tim Waugh says that the cards brought
> about a number of issues, of which i am unable to recollect.

Would be nice to know exactly what these issues are.  My only issue with
these cards so far is that I have to patch the kernel to use them...

Thanks,
Marek

