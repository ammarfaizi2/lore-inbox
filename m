Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317586AbSFMMEu>; Thu, 13 Jun 2002 08:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317591AbSFMMEt>; Thu, 13 Jun 2002 08:04:49 -0400
Received: from mail.medav.de ([213.95.12.190]:1034 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S317586AbSFMMEs> convert rfc822-to-8bit;
	Thu, 13 Jun 2002 08:04:48 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "Martin Wilck" <Martin.Wilck@Fujitsu-Siemens.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
Date: Thu, 13 Jun 2002 14:04:56 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <1023969547.23733.858.camel@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: Serverworks OSB4 in impossible state
Message-Id: <20020613110130.897E0109F6@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jun 2002 13:59:06 +0200, Martin Wilck wrote:

>Am Don, 2002-06-13 um 13.50 schrieb Daniela Engert:

>> are transferred before IRQ14 is asserted. The IRQ14 INTACK
>> cycle is the last transaction on the PCI bus ever, the
>> machine is completely frozen!
>
>You say (dma_base+2) is never read?

Exactly. If checked this twice, the PCI tracer was configured to gather
*all* PCI bus events.

>Was that a Linux system?

No, I think this doesn't matter here at all, because the hardware
stalls completely - full stop.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


