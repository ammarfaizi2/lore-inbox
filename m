Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbUDPQe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUDPQe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:34:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33938 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263372AbUDPQex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:34:53 -0400
Message-ID: <40800B1E.9050500@pobox.com>
Date: Fri, 16 Apr 2004 12:34:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gilles May <gilles@canalmusic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PDC20376 PATA?
References: <407FED4A.8040307@canalmusic.com>
In-Reply-To: <407FED4A.8040307@canalmusic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gilles May wrote:
> Hello everybody::
> 
> I have got a problem getting my onboard FastTrak 376 Controller to work. 
> The motherboard is an Asus A7V8X.
> 
> Kernels 2.6.1 to 2.6.5 do detect the controller, but not the harddisk 
> connected to it.
> During bootup of 2.6.5 stock kernel I get the following:
> 
> 
> libata version 1.02 loaded.
> sata_promise version 0.91
> ata1: SATA max UDMA/133 cmd 0xE0A5F200 ctl 0xE0A5F238 bmdma 0x0 irq 10
> ata2: SATA max UDMA/133 cmd 0xE0A5F280 ctl 0xE0A5F2B8 bmdma 0x0 irq 10
> ata1: no device found (phy stat 00000000)
> ata1: thread exiting
> scsi0 : sata_promise
> ata2: no device found (phy stat 00000000)
> ata2: thread exiting
> scsi1 : sata_promise
> 
> I assume it is only trying to detect SATA devices while my HDD is 
> connected as PATA.. With Windows it works like a charm.
> 
> Do I have to pass some parameters to sata_promise or are there any 
> patches to try for the PATA HDD to work?


sata_promise (as perhaps the name implies) does not yet support PATA.

	Jeff



