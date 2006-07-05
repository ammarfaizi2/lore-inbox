Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWGERdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWGERdW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWGERdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:33:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:39569 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964843AbWGERdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:33:21 -0400
Message-ID: <44ABF7DF.5050607@garzik.org>
Date: Wed, 05 Jul 2006 13:33:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Narendra Hadke <nhadke@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: sata_mv driver on 88sx6041 ( 2.6.14): PCI IRQ error
References: <20060705171223.65590.qmail@web33504.mail.mud.yahoo.com>
In-Reply-To: <20060705171223.65590.qmail@web33504.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Narendra Hadke wrote:
> Hi,
>     The sata_mv I am using is with
>   "three fixes" ie 0.6 on kernel version 2.6.14
> (Marvell 6041 part) without the IEN related change. 
> libata & scsi are modified(imported change from later
> version of kernel) to make this change 
> compile.(With IEN change  driver gets truck after 
> identifying the disk)
>    I  got rid of the disk errors but the next the
>  error I am getting is related to PCI IRQ.
> -----------------------------------------
> SCSI device sda: drive cache: write back
>  sda:<3>sata_mv: PCI ERROR; PCI IRQ cause=0x00000400

"PCI ERROR" is the hardware signalling that a major PCI-bus-related 
error has occurred.

Try moving the controller to a new PCI slot, or other hardware-level fixes.

	Jeff



