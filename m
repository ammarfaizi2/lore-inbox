Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWCHNLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWCHNLj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWCHNLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:11:39 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5567 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751667AbWCHNLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:11:38 -0500
Subject: Re: SATA ATAPI AHCI error messages?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <26CEE2C804D7BE47BC4686CDE863D0F50660ABA5@orsmsx410>
References: <26CEE2C804D7BE47BC4686CDE863D0F50660ABA5@orsmsx410>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 13:17:14 +0000
Message-Id: <1141823834.7605.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-07 at 17:30 -0800, Gaston, Jason D wrote:
> atapi_enabled=1 set in the libata-core.c file.  These error messages
> continue to be repeatedly logged about every 2 seconds.  Can someone
> tell me what is going on and if this will be addressed in the next RC
> release of the 2.6.16 kernel?

Does ths still occur if you boot to a command line and don't have all
the gnome/kde crap running and polling your drive ?

> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
> sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
> sr: Current [descriptor]: sense key: Aborted Command
>     Additional sense: No additional sense information

TUR should not be getting aborted command replies off a CD. Most odd

