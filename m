Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbRGRHSj>; Wed, 18 Jul 2001 03:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbRGRHS3>; Wed, 18 Jul 2001 03:18:29 -0400
Received: from penguin-ext.wise.edt.ericsson.se ([194.237.142.110]:13022 "EHLO
	penguin-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S267844AbRGRHSP>; Wed, 18 Jul 2001 03:18:15 -0400
Message-ID: <3B553838.6DB92928@eth.ericsson.se>
Date: Wed, 18 Jul 2001 09:18:16 +0200
From: Ferenc Kubinszky <Ferenc.Kubinszky@eth.ericsson.se>
X-Mailer: Mozilla 4.61 [en] (X11; I; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PCI hiccup installing Lucent/Orinoco carbus PCI adapter
In-Reply-To: <20010718065606.1125.qmail@toyland.ping.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [1.] One line summary of the problem:
> >
> >      PCI Drivers fail to allocate interrrupt for Lucent Cardbus bridge
> >
> > [2.] Full description of the problem/report:
> >
> > The 2.4.3 kernel recognizes the card but failts to allocate an
> > interrupt for it.  This is the Lucent Oinoco PCI Carbus bridge product
> > which is based on the TI1410 chip.  In talking with Dave Hinds about
> > the problem, he looked at the enclose outbut and suggested that it
> > looks like a kernel/PCI problem.
> 
> Is the card getting an interrupt from thew bios ? Check your bios screen
> after reboot. There should be a patch regarding this included in 2.4.6, would
> you try this and see if it works ?

Hello,

Just an idea:
Check the "exclude irq n" lines in your /etc/pcmcia/config.opts
Maybe it conflicts with some "PnP" interrupt like serial or paralell
port's...

Ferenc
