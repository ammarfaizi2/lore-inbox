Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTLDXO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTLDXO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:14:27 -0500
Received: from pop.gmx.de ([213.165.64.20]:40168 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263698AbTLDXOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:14:20 -0500
X-Authenticated: #4512188
Message-ID: <3FCFBFC3.5070403@gmx.de>
Date: Fri, 05 Dec 2003 00:14:11 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Jesse Allen <the3dfxdude@hotmail.com>
CC: cheuche+lkml@free.fr, linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11) - IRQ
 flood related ?
References: <3FCF25F2.6060008@netzentry.com> <1070551149.4063.8.camel@athlonxp.bradney.info> <20031204163243.GA10471@forming> <frodoid.frodo.87vfow33zm.fsf@usenet.frodoid.org> <20031204175548.GB10471@forming> <20031204200208.GA4167@localnet> <20031204230528.GA189@tesore.local>
In-Reply-To: <20031204230528.GA189@tesore.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Allen wrote:
> On Thu, Dec 04, 2003 at 09:02:08PM +0100, cheuche+lkml@free.fr wrote:
> 
>>Hello,
>>
>>Along with the lockups already described here, I've noticed an
>>unidentified source of interrupts on IRQ7.
> 
> ...
> 
>>I wonder if people experiencing lockup problems also have these
>>noise interrupts,
> 
> 
> I just took a look at this, by setting up parport_pc, and yes I get noise.
> 
> This was my first sample with a kernel with APIC:
>   7:      29230    IO-APIC-edge  parport0

I just did an experminent with a very light kernel, nearly nothing 
compiled inside, except apic acpi, preempt and needed stuff plus 
scsi+libata and no ide. IRQ 7 was not present and every device had its 
own irq. Nevertheless system locked up at second hdparm run...

Prakash

