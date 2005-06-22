Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVFVQVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVFVQVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVFVQSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:18:14 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:9641 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261561AbVFVQRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:17:24 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ACPI] [PATCH] VIA IRQ quirk for 2.6.12-rc5
Date: Wed, 22 Jun 2005 10:17:04 -0600
User-Agent: KMail/1.8
Cc: Len Brown <lenb@toshiba.hsd1.ma.comcast.net>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net> <1117188546.5730.175.camel@localhost.localdomain>
In-Reply-To: <1117188546.5730.175.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506221017.04981.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 4:09 am, Alan Cox wrote:
> On Gwe, 2005-05-27 at 09:21, Len Brown wrote:
> > Delete quirk_via_bridge(), restore quirk_via_irqpic() --
> > but now improved to be invoked upon device ENABLE, and
> > now only for VIA devices -- not all devices behind VIA bridges.
> 
> Properly you should apply the fixup to all VBUS devices. I've not seen a
> clean way to identify which devices fall into that category but there
> are public 
> data sheets for many of the chips.

Do you have any specific references?  I've browsed through the VIA specs
here: http://gkernel.sourceforge.net/specs/via/, but I haven't seen any
mention of VBUS or any notes about programming PCI_INTERRUPT_LINE.

Or do you have any contacts at VIA?  This is going to take a long time
to untangle by trial and error.
