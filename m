Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279113AbRKHNPF>; Thu, 8 Nov 2001 08:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279420AbRKHNOp>; Thu, 8 Nov 2001 08:14:45 -0500
Received: from [62.14.235.6] ([62.14.235.6]:19204 "HELO [62.14.235.6]")
	by vger.kernel.org with SMTP id <S279274AbRKHNOn>;
	Thu, 8 Nov 2001 08:14:43 -0500
From: "Drizzt Do'Urden" <drizzt.dourden@iname.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <drizzt.dourden@iname.com>
Cc: "LLX" <llx@swissonline.ch>, <linux-kernel@vger.kernel.org>
Subject: RE: Module Licensing?
Date: Thu, 8 Nov 2001 14:19:08 +0100
Message-ID: <NLEDJBJHJDOPHJOIBBAFAEINCGAA.drizzt.dourden@iname.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
In-Reply-To: <E161oUQ-0007ZX-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, Alan, use these tecnique is a mess, and nobody are going to include a
mess like this in a standar kernel. But someone could use this kind of
tricks to include "binary only mess" in the kernel and no break the GPL ...

I also think about a dinamic patching kernel from user space from /dev/kmem,
another mess but, the limits in "what is dinamic linking", is not clear in
the GPL for me, and you can use these kind of tricks.


I can understand the problems with reports to linux-kernel with binary only
drivers, and why is important that tainted kernel. People in this list don't
have to do the work that must be done for a the company that made the driver
who knows what the binary driver do.

But I can understand less the GPLONLY_ option (and I have read another mail
from you where you comment that there are people that doesn't want that
their code are called from "binary only modules"), because there are tricks
that you can use to jump over the GPL and not put "a glue GPL module" (like
I have read in the thread about this question).

I only thinking about all this topic. I prefer the source for the drivers
(simple, easy debugging) , but is better a binary driver (but  the support
must be done by the company that make that driver,of course), that no driver
at all :(, but these is only my opinion.

Saludos
Drizzt



-----Mensaje original-----
De: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Enviado el: jueves, 08 de noviembre de 2001 13:41
Para: drizzt.dourden@iname.com
CC: LLX; linux-kernel@vger.kernel.org
Asunto: Re: Module Licensing?


> (well, I dosn't remember the exact sintax of pointer to funtioncs but .=
> =2E. )
>
> You can put the binary driver like "microcode", and GPL

Nope. The only cases we have microcode like that in the kernel is downloaded
firmware for devices. The same stuff you'd have been finding in the boot
rom instead 12 months ago before the price squeezes reached ripped out any
flash component and doing software download. Richard Stallman doesn't like
that either, but since he currently runs an OS loaded by and using a binary
only BIOS I don't have any direct sympathies right now

