Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129325AbQKXQ3S>; Fri, 24 Nov 2000 11:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129737AbQKXQ3I>; Fri, 24 Nov 2000 11:29:08 -0500
Received: from [195.77.234.5] ([195.77.234.5]:16908 "HELO ntdes.cirsa.com")
        by vger.kernel.org with SMTP id <S129325AbQKXQ3F>;
        Fri, 24 Nov 2000 11:29:05 -0500
Message-ID: <01C05636.8794C2F0@wsi_joan.UNIDESA_RD>
From: Joan Bertran <jbertran@cirsa.com>
To: "'Jon Burgess'" <Jon_Burgess@eur.3com.com>
Cc: "'rminnich@lanl.gov'" <rminnich@lanl.gov>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Booting AMD Elan520 without BIOS
Date: Fri, 24 Nov 2000 16:49:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Mensaje original-----
> De: Jon Burgess [mailto:Jon_Burgess@eur.3com.com]
> Enviado el: viernes 24 de noviembre de 2000 16:40
> Para: joan_bertran%DESAR@cirsa.com
> Cc: 'rminnich@lanl.gov'; 'linux-kernel@vger.kernel.org'
> Asunto: Re: Booting AMD Elan520 without BIOS
> 
> 
> 
> I've seen this on a board with a BIOS problem. I think it is 
> caused because 
> the
> Kernel is in a loop waiting for a timer interrupt to occur. If the 
> interrupt
> never arrives it loops forever.
> 
>      Jon
> 
> 
 I think so, because I've read somewhere the kernel needs interrupts 
configured, but as kernel configures i8259 I don't know what is necessary,
the IDT with interrupt service routines ?, sommething special about the chipset ?

			Joan Bertran.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
