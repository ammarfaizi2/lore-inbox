Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVGFTsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVGFTsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVGFTpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:45:07 -0400
Received: from odin2.bull.net ([192.90.70.84]:50077 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S262318AbVGFO0M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:26:12 -0400
Subject: Re: PREEMPT_RT and mptfusion
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1120653209.6225.96.camel@ibiza.btsn.frna.bull.fr>
References: <1120633558.6225.64.camel@ibiza.btsn.frna.bull.fr>
	 <20050706120848.GB16843@elte.hu>
	 <1120653209.6225.96.camel@ibiza.btsn.frna.bull.fr>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1120659178.6225.99.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Wed, 06 Jul 2005 16:12:58 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 06/07/2005 à 14:33, Serge Noiraud a écrit :
> Le mer 06/07/2005 à 14:08, Ingo Molnar a écrit :
> > * Serge Noiraud <serge.noiraud@bull.net> wrote:
> > 
> > > The problem I have didn't exist in 48-36 : The last version I can run.
> > > >From the 50-47, ( I didn't test 40-38 through 50-46 ) I get the
> > > following problem : I cannot boot :
> > 
> > > with a 2.6.12 with RT patch and PREEMPT_RT
> > > ...
> > > Fusion MPT base driver 3.01.20
> > > Copyright (c) 1999-2004 LSI Logic Corporation
> > > ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 32 (level, low) -> IRQ 177
> > > mptbase: Initiating ioc0 bringup
> > > ioc0: 53C1030: Capabilities={Initiator}
> > > <== wait ~ 13 secondes
> > > ioc0: 53C1030: Initiating ioc0 recovery    <== New with the RT patch
> > 
> > which -RT kernel was the last you tried, 50-47? Could you send me your 
> > .config? It seems you have CONFIG_X86_UP_IOAPIC and CONFIG_PCI_MSI 
> > enabled - could you try -51-02 and both of these options disabled?
> > 
> > 	Ingo
> Yes it was 50-47.
> CONFIG_X86_UP_IOAPIC is not present in my .config
> CONFIG_PCI_MSI is set to yes.
> 
> I'll try with CONFIG_PCI_MSI=n
It's OK for me. good job.

