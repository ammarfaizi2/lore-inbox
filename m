Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272635AbTG1Buk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272141AbTG1ABj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:39 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272930AbTG0XBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:37 -0400
Subject: Re: 2.6.0-test1: irq18 nobody cared! on Intel D865PERL motherboard
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Mika Liljeberg <mika.liljeberg@welho.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200307262313.08819.adq_dvb@lidskialf.net>
References: <20030714131240.21759.qmail@linuxmail.org>
	 <1059256372.8484.9.camel@hades>  <200307262313.08819.adq_dvb@lidskialf.net>
Content-Type: text/plain
Message-Id: <1059332957.531.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sun, 27 Jul 2003 21:09:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-27 at 00:13, Andrew de Quincey wrote:

> > I have the same problem with Abit IS7-E, which also has the i865PE
> > chipset.
> >
> > Add "noirqdebug" to the kernel command line and you should be able to
> > boot, although the irq will be firing continously until the device
> > driver gets initialized and catches it.
> 
> Out of interest, do these boxes have an IO-APIC and are you using ACPI? If so, 
> can you tell me if the attached patch helps?
> 
> These are exactly the symptoms I got without the attached patch (it fixes an 
> IO-APIC setup bug with ACPI).

I won't have access to those machines until August, 3th. I will give
your patch a try then :-)
Thanks!

