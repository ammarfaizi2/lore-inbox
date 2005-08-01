Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVHASNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVHASNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVHASLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:11:30 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:64819 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261835AbVHASKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:10:50 -0400
Date: Mon, 01 Aug 2005 12:10:47 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: amd74xx (nforce) driver problem ?
In-reply-to: <4wEt8-4Qk-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42EE65A7.50201@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4wEt8-4Qk-1@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote:
> NFORCE2: IDE controller at PCI slot 0000:00:09.0
> NFORCE2: chipset revision 162
> NFORCE2: not 100% native mode: will probe irqs later
> NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
> NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> 
> 
> Shouldn't the driver set the channel to UDMA100 after it detects the BIOS
> set up the chip improperly, or am I mistaken about this behavior?  Isn't
> that the "workaround" or does that mean something else?

I think the workaround is something else. I get that message as well on 
nForce4 (Asus A8N-SLI Deluxe). The drives are definitely set to auto in 
the BIOS (only optical drives are on the PATA controller).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

