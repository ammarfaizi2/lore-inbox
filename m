Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbTIDMmg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbTIDMmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:42:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4043 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264943AbTIDMm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:42:27 -0400
Message-ID: <3F573323.10604@pobox.com>
Date: Thu, 04 Sep 2003 08:42:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, Paul Mackerras <paulus@samba.org>,
       rmk@arm.linux.org.uk, hch@lst.de,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
References: <20030903203231.GA8772@lst.de>	 <16214.34933.827653.37614@nanango.paulus.ozlabs.org>	 <20030904071334.GA14426@lst.de>	 <20030904083007.B2473@flint.arm.linux.org.uk>	 <16215.1054.262782.866063@nanango.paulus.ozlabs.org>	 <20030904023624.592f1601.davem@redhat.com> <1062671669.21777.9.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062671669.21777.9.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2003-09-04 at 10:36, David S. Miller wrote:
> 
>>You only need a resource in order to do this.  Then you can
>>stick the upper bits, controller number, whatever in the unused
>>resource flag bits.
> 
> 
> If it becomes the default approach over time then we also need a 
> version that allows offset/len to be included for mapping parts
> of very large objects (like 256Mb frame buffers)


ioremap() has long wanted a struct pci_dev argument too.
(or make that struct device, now)

	Jeff



