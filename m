Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTKFXRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbTKFXRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:17:47 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:38150 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263891AbTKFXPu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:15:50 -0500
Date: Thu, 6 Nov 2003 21:15:46 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test9 and bluetooth
Message-ID: <20031106231545.GN3345@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Fabio Coatti <cova@ferrara.linux.it>,
	Marcel Holtmann <marcel@holtmann.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200311021853.47300.cova@ferrara.linux.it> <1068031899.10388.180.camel@pegasus> <200311062240.38099.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200311062240.38099.cova@ferrara.linux.it>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 06, 2003 at 10:40:38PM +0100, Fabio Coatti escreveu:
> Alle 12:31, mercoledì 05 novembre 2003, Marcel Holtmann ha scritto:
> 
> >
> > please try this with a non SMP kernel and/or a non preempt kernel. Do
> > you have enabled the Bluetooth SCO support for the HCI USB driver?
> 
> As said I've tried 2.6.0-test9 [UP, SMP] preemp and SMP non preempt, all with 
> the same behaviour, that means immediate machine freeze whenever the usb 
> bluetooth dongle is removed from USB port. 
> I've also got crashes whenever I've turned off the machine, with bluetooth and 
> hci_usb modules loaded.
> I've wrote down the message (by hand, so errors are possible) , hoping that 
> this can help. If it's possible to get the full message, please let me know, 
> a part of it has scrolled out of the screen (i can use a serial port 
> terminal, if needed).

That would be good indeed.
 
> here is the trace:

What about the last routine that caused the oops? I.e. the one that appears
above the registers?
 
> uhci_irq+0x67/0x16c [uhci_hcd]
> do_IRQ+0xC1/0x141
> usb_hcd_irq+0x36/0x5f
> handle_IRQ_event+0x3a/0x64

- Arnaldo
