Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVERSgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVERSgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVERS3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:29:34 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:20423 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S262267AbVERSZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:25:07 -0400
Subject: Re: PROBLEM: ICH6M not recognised as being AHCI capable (libata)
From: Erik Slagter <erik@slagter.name>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <428B86E5.4090104@pobox.com>
References: <1116408671.3505.31.camel@localhost.localdomain>
	 <428B86E5.4090104@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 May 2005 20:24:41 +0200
Message-Id: <1116440681.3462.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 14:18 -0400, Jeff Garzik wrote:
> Erik Slagter wrote:
> > 1. ICH6M not recognised as being AHCI capable (libata)
> > 
> > 2. During startup, libata refuses to talk to the ICH6 using AHCI, I get
> > these messages: 
> > 
> > libata version 1.10 loaded.
> > ahci version 1.00
> > ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 201
> > ahci: probe of 0000:00:1f.2 failed with error -12
> > ata_piix version 1.03
> > 
> > [-12 == ENOMEM???]
> 
> You need to either load ata_piix driver, or tell your BIOS to initialize 
> AHCI mode.

I do have ata_piix loaded (as you can see in the log). I don't have a
BIOS option to enable AHCI mode, I was hoping linux could force it
somehow.

BTW It works using the ata_piix driver (in legacy mode), but of course
I'd rather have the AHCI mode.
