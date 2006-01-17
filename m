Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWAQNhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWAQNhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWAQNhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:37:04 -0500
Received: from mail.dvmed.net ([216.237.124.58]:19627 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932216AbWAQNhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:37:02 -0500
Message-ID: <43CCF2F7.4070205@pobox.com>
Date: Tue, 17 Jan 2006 08:36:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prakash Punnoor <prakash@punnoor.de>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <200601171416.13119.prakash@punnoor.de>
In-Reply-To: <200601171416.13119.prakash@punnoor.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Prakash Punnoor wrote: > Compiling libata SIL breaks
	with Linux 2.6.16-rc1: > > > CC drivers/scsi/sata_sil.o >
	drivers/scsi/sata_sil.c: In function 'sil_port_irq': >
	drivers/scsi/sata_sil.c:393: error: too many arguments to function >
	'ata_qc_complete' > drivers/scsi/sata_sil.c:400: error: too many
	arguments to function > 'ata_qc_complete' [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> Compiling libata SIL breaks with Linux 2.6.16-rc1:
> 
> 
>   CC      drivers/scsi/sata_sil.o
> drivers/scsi/sata_sil.c: In function 'sil_port_irq':
> drivers/scsi/sata_sil.c:393: error: too many arguments to function 
> 'ata_qc_complete'
> drivers/scsi/sata_sil.c:400: error: too many arguments to function 
> 'ata_qc_complete'

I don't know what source code you're compiling, but it's certainly not 
2.6.16-rc1:

[jgarzik@pretzel linux-2.6]$ grep -w ata_qc_complete 
drivers/scsi/sata_sil.c
[jgarzik@pretzel linux-2.6]$

