Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVCRN6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVCRN6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 08:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVCRN6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 08:58:18 -0500
Received: from mailgw3.technion.ac.il ([132.68.238.35]:5026 "EHLO
	mailgw3.technion.ac.il") by vger.kernel.org with ESMTP
	id S261605AbVCRN6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 08:58:14 -0500
Date: Fri, 18 Mar 2005 15:58:11 +0200 (IST)
From: Jacques Goldberg <goldberg@phep2.technion.ac.il>
X-X-Sender: goldberg@localhost.localdomain
Reply-To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Need break driver<-->pci-device automatic association
In-Reply-To: <1111151648.9874.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58_heb2.09.0503181537400.9143@localhost.localdomain>
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain>
 <1111151648.9874.10.camel@localhost.localdomain>
X-MailKey: 829.36.63
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005, Alan Cox wrote:

> On Gwe, 2005-03-18 at 08:57, Jacques Goldberg wrote:
> >Question: is there a way, as of kernels 2.6.10 and above, to release the
> > device from the serial driver, without having to recompile the kernel?
>
> There is an ugly way (fake a hot unplug 8)) butif you want to do it
> properly you need to get the relevant pci check into the serial driver
> proper by submitting it to Russell King. That way the serial driver can
> skip the PCI devices that turn out to be modems
>
  Thank you very much.
  To be ugly or to never be up to date, that's the question.
  We did patch 8250_pci.c but there is no way to build a stable list of
the devices to be handled that way.
  We will thus spend some time on the hot unplug solution.
  This is my very last question: is there a script able to do that? Google
quotes their existence but no link found. Or a doc showing how to code
that in a program?

  Many many thanks - Jacques
