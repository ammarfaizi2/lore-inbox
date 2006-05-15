Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWEOSRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWEOSRU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWEOSRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:17:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:31940 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965038AbWEOSRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:17:19 -0400
Message-ID: <4468C5AC.5020103@garzik.org>
Date: Mon, 15 May 2006 14:17:16 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Sven-Haegar Koch <haegar@sdinet.de>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA status report updated
References: <44689C39.70902@garzik.org> <Pine.LNX.4.64.0605151901060.25784@mercury.sdinet.de>
In-Reply-To: <Pine.LNX.4.64.0605151901060.25784@mercury.sdinet.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven-Haegar Koch wrote:
> On Mon, 15 May 2006, Jeff Garzik wrote:
> 
>> I've updated the http://linux-ata.org/ status pages with the recent 
>> work by Tejun Heo and others.
> 
> Thanks for your list, but I'm missing the SATA chipset that our 
> Asus-Boxes got:
> 
> 0000:00:14.1 IDE interface: ATI Technologies Inc ATI Dual Channel Bus 
> Master PCI IDE Controller
> (PCI-ID 1002:4349)
> 
> Or is this something different like an IDE chipset with included SATA 
> bridges or so?
> 
> It is supported through the atiixp ide driver, but only really slow 
> (10mb/s) - the same disks attached to an Intel SATA port give 30-40mb/s.

Should be ahci or sata_sil driver?

	Jeff



