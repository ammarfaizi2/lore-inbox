Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279615AbRKGKJ2>; Wed, 7 Nov 2001 05:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279583AbRKGKJS>; Wed, 7 Nov 2001 05:09:18 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:31130 "HELO hazard.jcu.cz")
	by vger.kernel.org with SMTP id <S279615AbRKGKJE>;
	Wed, 7 Nov 2001 05:09:04 -0500
Date: Wed, 7 Nov 2001 11:07:02 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Cannot unlock spinlock... Was: Problem in yenta.c, 2nd edition
Message-ID: <20011107110702.D11351@hazard.jcu.cz>
In-Reply-To: <20011107104044.C11351@hazard.jcu.cz> <20011106123427.A11351@hazard.jcu.cz> <3BE2D37A.D32C6DB1@zip.com.au> <20011105112900.C5919@hazard.jcu.cz> <23001.1005086449@redhat.com> <11670.1005127189@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11670.1005127189@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

On Wed, Nov 07, 2001 at 09:59:49AM +0000, David Woodhouse wrote:
> 
> linux@hazard.jcu.cz said:
> >  Your hack is working for me. I got message: "IRQ storm detected on
> > IRQ 11. Disabling"
> 
> > and everythink works OK. Spinlock was unlocked, procedure setup_irq()
> > ended and PCMCIA package works fine...
> 
> > It is possible to add your patch to the kernel? 
> 
> Absolutely not. In 2.5, we may have some code to deal with IRQ storms, but 
> certainly not like that.

OK... But shall I apply your patch on every kernel while not
exist 2.5 kernel tree?

> 
> > But I don't know, what device asserted IRQ 11 to start the IRQ storm..
> 
> What other PCI devices claim to be on IRQ 11? Do you have ACPI enabled (in 
> the BIOS and/or in Linux)?

I have ACPI enabled and I'm attaching my lspci -vvv... Thank you
very much...

> --
> dwmw2

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
