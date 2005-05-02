Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVEBM4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVEBM4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 08:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEBM4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 08:56:51 -0400
Received: from [147.145.40.20] ([147.145.40.20]:1187 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261212AbVEBM4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 08:56:45 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662836@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: "'kallol@nucleodyne.com'" <kallol@nucleodyne.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Ju, Seokmann" <sju@lsil.com>
Subject: RE: LSI Logic's Ultra320 320-4X RAID adapter
Date: Mon, 2 May 2005 08:56:10 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 30, 2005 9:02 PM, Kallol wrote:
> The memory space PCI register access can not be used.
I'm not sure what this means. Can you please add more details on it?

> Question #1: Does 320-4X support IO Space device register access?
No, the controller does not support IO mapped I/O.

> Question #2: Do we have a linux driver for it that supports 
> IO ports also?
Yes, to support LSI MegaRAID controllers (typically old controllers), driver
on the 2.4 kernel supports I/O mapped I/O.

Thank you.

Seokmann
LSI Logic Corporation.

> -----Original Message-----
> From: kallol@nucleodyne.com [mailto:kallol@nucleodyne.com] 
> Sent: Saturday, April 30, 2005 9:02 PM
> To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: LSI Logic's Ultra320 320-4X RAID adapter
> 
> 
> 
> Hello,
>       We have been evaluting different IO adapters for a 
> storage system vendor.
> 
> LSI logic's 320-4X RAID controller seems to be a good choice.
> 
> There is an issue with the system on which we are measuring 
> performance.
> The memory space PCI register access can not be used.
> 
> Question #1: Does 320-4X support IO Space device register access?
> Question #2: Do we have a linux driver for it that supports 
> IO ports also?
> 
> The megaraid linux driver seems to check the BAR0, if it is 
> memory bar then mem
> space is used otherwise IO space.
> 
> May be the adapter supporting memory space also support IO 
> space access.
> 
> 
> Thanks,
> Kallol
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
