Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWE0UKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWE0UKa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 16:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWE0UKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 16:10:30 -0400
Received: from rtr.ca ([64.26.128.89]:39830 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964935AbWE0UK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 16:10:29 -0400
Message-ID: <4478B236.7000007@rtr.ca>
Date: Sat, 27 May 2006 16:10:30 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata resume improvements
References: <20060527055533.GA5159@havoc.gtf.org>
In-Reply-To: <20060527055533.GA5159@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> This is an example of how one might make sure the ATA bus reaches
> bus-idle, before attempting to talk to it.
> 
> It compiles, but is completely untested...
> 
> Other resume improvements should work at the pci_driver::resume level as
> this does, _not_ the SCSI->ATA->resume device level.
> 
> 
> diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
...

Sorry to say, but no user-visible difference from previous attempts.
Still fails the same way, after a 30-ish second timeout on resume.

Cheers
