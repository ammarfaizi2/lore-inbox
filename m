Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbULCOyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbULCOyn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 09:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbULCOyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 09:54:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28070 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262242AbULCOya
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 09:54:30 -0500
Message-ID: <41B07E11.6030704@pobox.com>
Date: Fri, 03 Dec 2004 09:54:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: EC <wingman@waika9.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata ICH5 2.4.28 kernel oops
References: <20041203125340.563FC1734B4@postfix3-1.free.fr>
In-Reply-To: <20041203125340.563FC1734B4@postfix3-1.free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EC wrote:
> Hi,
> 
> I'm getting trouble to upgrade from 2.4.27 to 2.4.28 since kernel oopses on
> start. That seems to be related to libata and my SATA configuration. I'm
> using a plain vanilla kernel (no patches).
> 
> I have a Supermicro P4SCI with a PIV (SATA chipset ICH5), latest bios (1.1),
> one disk (SATA), BIOS configured to SATA Only (but enhanced mode does the
> same. Same kernel configuration used to work with 2.4.27 with the libata
> patch. I'm not sure I'm supposed to apply the new 2.4.28 libata patch but
> anyway with or without it kernel crashes about here :
> 
> ...
> SCSI subsystem driver Revision : 1.0...
> ata1 : SATA max UDMA/133 : cmd 0x1F0 ctl 0x3F6 bmdam 0xF000 irq 14
> ata1 : dev 0 ATA, max UDMA/133...
> ata1 : dev 0 configured for UDMA/133
> Unable to handle Kernel NULL pointer dereference....
> ...

Give us the oops.

See REPORTING-BUGS in the kernel tree for more info.

	Jeff



