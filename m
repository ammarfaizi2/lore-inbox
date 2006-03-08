Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752047AbWCHENu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbWCHENu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 23:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWCHENt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 23:13:49 -0500
Received: from mail.dvmed.net ([216.237.124.58]:18149 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751313AbWCHENt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 23:13:49 -0500
Message-ID: <440E59F3.6090200@garzik.org>
Date: Tue, 07 Mar 2006 23:13:39 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SATA ATAPI AHCI error messages?
References: <26CEE2C804D7BE47BC4686CDE863D0F50660ABA5@orsmsx410>
In-Reply-To: <26CEE2C804D7BE47BC4686CDE863D0F50660ABA5@orsmsx410>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaston, Jason D wrote:
> Hello,
> 
> We are seeing the following error messages in dmesg with the 2.6.16-rc5
> kernel.  I have also tried to apply the git10 patch and still see the
> same errors.  This is seen using a Plextor PX-716SA or PX-712SA SATA
> DVDRW drive when in AHCI mode.  I do not see this message when the SATA
> controller is set to IDE mode, in the BIOS.  I have reproduced this
> using Intel ICH6R, ICH7R and ICH8 SATA controllers.  I have
> atapi_enabled=1 set in the libata-core.c file.  These error messages
> continue to be repeatedly logged about every 2 seconds.  Can someone
> tell me what is going on and if this will be addressed in the next RC
> release of the 2.6.16 kernel?
>  
> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
> sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
> sr: Current [descriptor]: sense key: Aborted Command
>     Additional sense: No additional sense information

Probably its just too chatty, since ATAPI throws a lot of errors...

	Jeff



