Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbTB1GkM>; Fri, 28 Feb 2003 01:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTB1GkM>; Fri, 28 Feb 2003 01:40:12 -0500
Received: from tag.witbe.net ([81.88.96.48]:273 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S267540AbTB1GkL>;
	Fri, 28 Feb 2003 01:40:11 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Andrey Nekrasov'" <andy@spylog.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: eepro100: wait_for_cmd_done timeout
Date: Fri, 28 Feb 2003 07:50:27 +0100
Message-ID: <023a01c2def5$ae59a6e0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20030227203013.GA25009@an.spylog.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Hello Paul Rolland,
> 
> > Feb 27 13:50:01 rms-01 Feb 27 13:50:01:30726 kernel: eepro100: 
> > wait_for_cmd_done  timeout!
> > 
> > eth0: OEM i82557/i82558 10/100 Ethernet, 00:06:5B:39:69:2B, IRQ 16.
> >   Board assembly 02d484-000, Physical connectors present: RJ45
> >   Primary interface chip i82555 PHY #1.
> >   General self-test: passed.
> >   Serial sub-system self-test: passed.
> >   Internal registers self-test: passed.
> >   ROM checksum self-test: passed (0x04f4518b).
> > Anyone knows why ?
> 
>  try update bios on motherboard.
>  i am use INTEL STL2 and after update bios to last version 
> network card work ok

Thanks for the suggestion...
I got another one, telling me to have a look at the e100 driver,
and this raises a question I have for quite a long time : why does
the Kernel have two different supports for the same hardware ?
Is this a migration plan, a long run "please switch from eepro100
to e100" ?
Is there a better working one ?

I don't say that, once a driver exists, no one should ever think
of doing another one, but there are little indication as to which
one people should select...

Quite puzzling ;-)

Regards,
Paul

