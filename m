Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUIPARy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUIPARy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 20:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUIPAQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 20:16:19 -0400
Received: from smtp2.cavium.com ([209.113.159.134]:5651 "EHLO smtp2.cavium.com")
	by vger.kernel.org with ESMTP id S267474AbUIOVdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:33:20 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "Wes Felter" <wesley@felter.org>, <linux-kernel@vger.kernel.org>
Cc: <netdev@oss.sgi.com>
Subject: Re: The ultimate TOE design
Date: Wed, 15 Sep 2004 14:25:51 -0700
Message-ID: <CNEJKAHIKPFGKOPLKCGDOEMJAGAB.imran.badr@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <ciaao4$crc$1@sea.gmane.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-OriginalArrivalTime: 15 Sep 2004 21:33:11.0538 (UTC) FILETIME=[99AE9D20:01C49B6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please see:

Cavium Networks Introduces OCTEON(TM) Family of Integrated Network Services
Processors With up to 16 MIPS64(R)-Based Cores for Internet Services,
Content and Security Processing"

http://www.linuxelectrons.com/article.php?story=20040913082030668&mode=print




-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Wes Felter
Sent: Wednesday, September 15, 2004 2:04 PM
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: [SPAM] Re: The ultimate TOE design


Neil Horman wrote:
> Paul Jakma wrote:
>
>> On Wed, 15 Sep 2004, Jeff Garzik wrote:
>>
>>> Put simply, the "ultimate TOE card" would be a card with network
>>> ports, a generic CPU (arm, mips, whatever.), some RAM, and some
>>> flash.  This card's "firmware" is the Linux kernel, configured to run
>>> as a _totally indepenent network node_, with IP address(es) all its own.
>>>
>>> Then, your host system OS will communicate with the Linux kernel
>>> running on the card across the PCI bus, using IP packets (64K fixed
>>> MTU).

>> The intel IXP's are like the above, XScale+extra-bits host-on-a-PCI
>> card running Linux. Or is that what you were referring to with "<cards
>> exist> but they are all fairly expensive."?

> IBM's PowerNP chip was also very simmilar (a powerpc core with lots of
> hardware assists for DMA and packet inspection in the extended register
> area).  Don't know if they still sell it, but at one time I had heard
> they had booted linux on it.

An IXP or PowerNP wouldn't work for Jeff's idea. The IXP's XScale core
and PowerNP's PowerPC core are way too slow to do any significant
processing; they are intended for control tasks like updating the
routing tables. All the work in the IXP or PowerNP is done by the
microengines, which have weird, non-Linux-compatible architectures.

To do 10 Gbps Ethernet with Jeff's approach, wouldn't you need a 5-10
GHz processor on the card? Sounds expensive.

A 440GX or BCM1250 on a cheap PCI card would be fun to play with, though.

Wes Felter - wesley@felter.org - http://felter.org/wesley/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

