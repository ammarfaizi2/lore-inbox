Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTLEHBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 02:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTLEHBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 02:01:51 -0500
Received: from legolas.restena.lu ([158.64.1.34]:52170 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263605AbTLEHBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 02:01:47 -0500
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11) - IRQ
	flood related ?
From: Craig Bradney <cbradney@zip.com.au>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3FD01BE0.5030807@nishanet.com>
References: <3FCF25F2.6060008@netzentry.com>
	 <1070551149.4063.8.camel@athlonxp.bradney.info>
	 <20031204163243.GA10471@forming>
	 <frodoid.frodo.87vfow33zm.fsf@usenet.frodoid.org>
	 <20031204175548.GB10471@forming> <20031204200208.GA4167@localnet>
	 <20031204230528.GA189@tesore.local>  <3FCFBFC3.5070403@gmx.de>
	 <1070580108.4100.8.camel@athlonxp.bradney.info>
	 <3FD01BE0.5030807@nishanet.com>
Content-Type: text/plain
Message-Id: <1070607704.4100.11.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Dec 2003 08:01:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nforce net is off. 3com is on. (in bios)

Craig

On Fri, 2003-12-05 at 06:47, Bob wrote:
> Do you have onboard ethernet enabled with nforce2
> mboard? I am fine with pre-emptive kernel but have
> to disable onboard ethernet in cmos setup or I see
> "Disabling IRQ7" and problems develop.
> 
> -Bob
> 
> Craig Bradney wrote:
> 
> >Prakash,
> >
> >try it without preempt.. just to see. As soon as I removed it today the
> >crashes went away (for 5 hours).. PC is now up for 2.5 hours and I'm
> >waiting to see if it will be 5 hrs or 5 days this time around :)
> >
> >Craig
> >
> >On Fri, 2003-12-05 at 00:14, Prakash K. Cheemplavam wrote:
> >  
> >
> >>Jesse Allen wrote:
> >>    
> >>
> >>>On Thu, Dec 04, 2003 at 09:02:08PM +0100, cheuche+lkml@free.fr wrote:
> >>>
> >>>      
> >>>
> >>>>Hello,
> >>>>
> >>>>Along with the lockups already described here, I've noticed an
> >>>>unidentified source of interrupts on IRQ7.
> >>>>        
> >>>>
> >>>...
> >>>
> >>>      
> >>>
> >>>>I wonder if people experiencing lockup problems also have these
> >>>>noise interrupts,
> >>>>        
> >>>>
> >>>I just took a look at this, by setting up parport_pc, and yes I get noise.
> >>>
> >>>This was my first sample with a kernel with APIC:
> >>>  7:      29230    IO-APIC-edge  parport0
> >>>      
> >>>
> >>I just did an experminent with a very light kernel, nearly nothing 
> >>compiled inside, except apic acpi, preempt and needed stuff plus 
> >>scsi+libata and no ide. IRQ 7 was not present and every device had its 
> >>own irq. Nevertheless system locked up at second hdparm run...
> >>
> >>Prakash
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >>    
> >>
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >  
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

