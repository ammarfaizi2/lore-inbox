Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWCBMjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWCBMjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWCBMjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:39:05 -0500
Received: from mail.dvmed.net ([216.237.124.58]:54967 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932253AbWCBMjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:39:04 -0500
Message-ID: <4406E759.2010601@pobox.com>
Date: Thu, 02 Mar 2006 07:38:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Arjan van de Ven <arjan@infradead.org>, Jens Axboe <axboe@suse.de>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia: add another ide-cs CF card id
References: <200603012259.k21MxBXC013582@hera.kernel.org> <44062FF1.4010108@pobox.com> <20060302075004.GA17789@isilmar.linta.de> <4406D44A.4020101@pobox.com> <1141299117.3206.37.camel@laptopd505.fenrus.org> <20060302114220.GH4329@suse.de> <1141301225.3206.50.camel@laptopd505.fenrus.org> <4406E1C7.7020908@pobox.com> <20060302122409.GD14017@flint.arm.linux.org.uk>
In-Reply-To: <20060302122409.GD14017@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> I think it's fairly safe and obvious to say that Dominik is the peer
> review for these tables - he _is_ the PCMCIA maintainer, he _is_
> arguably the maintainer for the ide-cs driver, he _is_ the person
> who invented these tables, he _is_ the one taking patches from people
> to add IDs, he _is_ the one reviewing such patches.
> 
> If you want to know what's going on in PCMCIA land, subscribe to
> linux-pcmcia.  In the same way that if you want to know what's going
> in in IDE land, you subscribe to linux-ide, or PCI land linux-pci,
> SCSI land linux-scsi, network land netdev.
> 
> Using your argument (which seems to be demanding that any patch to
> any IDE driver no matter how trivial must be on linux-ide) that a patch
> to a PCI network device driver must be copied to linux-pci and netdev
> even though it may not touch the PCI specific code.

IDE driver -> IDE reviewers

network driver -> network reviewers

The bus associated with the driver is only a tiny detail.  Many drivers 
(IDE!) are multi-bus, even.

Linus occasionally complains about stuff hiding on non-LKML lists... 
Even a CC to LKML would have been sufficient here.  That was not done.

	Jeff


