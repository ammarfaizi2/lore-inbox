Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUCSQij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 11:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbUCSQij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 11:38:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263017AbUCSQif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 11:38:35 -0500
Message-ID: <405B21FE.4010609@pobox.com>
Date: Fri, 19 Mar 2004 11:38:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?=22Tvrtko_A=2E_Ur=B9ulin=22?= <tvrtko@croadria.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFT] VIA SATA driver update
References: <405828DB.7060005@pobox.com> <200403171236.21145.tvrtko@croadria.com>
In-Reply-To: <200403171236.21145.tvrtko@croadria.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tvrtko A. Ur¹ulin wrote:
> libata version 1.01 loaded.
> sata_via version 0.20
> sata_via(0000:00:0f.0): routed to hard irq line 11
> ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB802 bmdma 0xC400 irq 11
> ata2: SATA max UDMA/133 cmd 0xBC00 ctl 0xC002 bmdma 0xC408 irq 11
> ata1 is slow to respond, please be patient
> ata1 failed to respond (30 secs)
> ata1: thread exiting
> scsi0 : sata_via
> ata2: no device found (phy stat 00000000)
> ata2: thread exiting
> scsi1 : sata_via
> 
> This is the same behavior I get ever since 2.6.1 when I started testing 2.6 
> seried. It also doesn't work under 2.6 with IDE generic support for 
> VIA8237SATA (irq timeout, dma timeout)

Ok...

Does enabling SMP (CONFIG_SMP) fix things for you?
(Note, this should work fine even on a uniprocessor machine)

	Jeff



