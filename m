Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157374-27302>; Sat, 30 Jan 1999 19:08:18 -0500
Received: by vger.rutgers.edu id <157237-27302>; Sat, 30 Jan 1999 19:07:55 -0500
Received: from z.ml.org ([209.208.36.5]:17525 "EHLO z.ml.org" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157363-27300>; Sat, 30 Jan 1999 19:07:11 -0500
Date: Sat, 30 Jan 1999 19:19:36 -0500 (EST)
From: Gregory Maxwell <linker@z.ml.org>
To: linux-kernel@vger.rutgers.edu
Cc: alan@redhat.com
Subject: Re: CMI-8338/Pci SoundPro
In-Reply-To: <Pine.LNX.3.96.990130172312.2763A-100000@z.ml.org>
Message-ID: <Pine.LNX.3.96.990130191738.2872J-100000@z.ml.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


As an update to my own message..
This card comes with a 2k dos com file which sets the dma/int/irq for sb16
compatibility. I dont think it's a TSR. 

I dont have a copy of dos around here and I can't mount my freedos image
to put the file there (dont have msdos kernel module.. :) )... I'm
reasonable sure I can just disassemble this executable and find the ports
it plays with.. :)

It should then work (though without the fancy features).


On Sat, 30 Jan 1999, Gregory Maxwell wrote:

> 
> Is there currently any work on supporting the CMI8338 PCI sound chip?
> 
> This sound chip support 4ch analog out, 2 chanel 24bit S/PDIF in/out, and
> various other nicities. It's ISA cousin was well supported in Linux (via
> the stock SB16 drive). Probably the nicest feature of this card is it's
> price: You can get these cards for $20 (with nice RCA S/PDIF output).
> 
> The page claims that it has legacy SB16 support via on board ISA DMA
> emulaton (which supposdity works under real dos). I havn't gotten it
> working under Linux yet, but I only spent about 5 seconds trying so far.
> 
> I'd like to see native support for it (to be able to use the full 24bit
> output, and all four channels), and I'd imagine that the company should be
> fairly open w/ specs. 
> 
> http://www.cmedia.com.tw/e_news3.htm
> 
> Thanks for any pointers.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
