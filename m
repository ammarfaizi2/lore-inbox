Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSLaRuW>; Tue, 31 Dec 2002 12:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSLaRuW>; Tue, 31 Dec 2002 12:50:22 -0500
Received: from mailrelay.nefonline.de ([212.114.153.196]:23721 "EHLO
	mailrelay1.nefonline.de") by vger.kernel.org with ESMTP
	id <S264617AbSLaRuW>; Tue, 31 Dec 2002 12:50:22 -0500
Message-Id: <200212311758.SAA08176@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "marcel@mesa.nl" <marcel@mesa.nl>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Date: Tue, 31 Dec 2002 18:58:24 +0100 (CET)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <1041281643.13615.131.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: Promise 20376 support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Dec 2002 20:54:03 +0000, Alan Cox wrote:

>> I've got this Asus A7V8X motherboard that contains a promise 20376
>> sata-ide (raid) controller.
>
>No work, no documentation. If its just a SATA bridge with an existing
>ATA controller then you may find you can just add the PCI identifiers
>and pretend its a 20276. If it has other new and wonderous features you
>may be completely screwed

Quite some time ago I had a look at their Windows drivers. From the
driver structure, the function names and the actual register accesses I
had the impression that this chip differs largely from the ATA/ATAPI
Host Adapter Standard as decribed in the ANSI committee T13 document
1510D (which happens to be the basis of most of the Linux ATA/ATAPI
drivers). I may be wrong and happily defer to the opposite.

Ciao,
  Dani


