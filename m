Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVERSSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVERSSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVERSSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:18:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:684 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262267AbVERSST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:18:19 -0400
Message-ID: <428B86E5.4090104@pobox.com>
Date: Wed, 18 May 2005 14:18:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Slagter <erik@slagter.name>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: ICH6M not recognised as being AHCI capable (libata)
References: <1116408671.3505.31.camel@localhost.localdomain>
In-Reply-To: <1116408671.3505.31.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter wrote:
> 1. ICH6M not recognised as being AHCI capable (libata)
> 
> 2. During startup, libata refuses to talk to the ICH6 using AHCI, I get
> these messages: 
> 
> libata version 1.10 loaded.
> ahci version 1.00
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 201
> ahci: probe of 0000:00:1f.2 failed with error -12
> ata_piix version 1.03
> 
> [-12 == ENOMEM???]

You need to either load ata_piix driver, or tell your BIOS to initialize 
AHCI mode.

	Jeff



