Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVAPCdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVAPCdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVAPCdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:33:54 -0500
Received: from zasran.com ([198.144.206.234]:35715 "EHLO jojda.zasran.com")
	by vger.kernel.org with ESMTP id S262395AbVAPCdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:33:52 -0500
Message-ID: <41E9D28F.8010109@bigfoot.com>
Date: Sat, 15 Jan 2005 18:33:51 -0800
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SATA disk dead? ATA: abnormal status 0x59 on port 0xE407
References: <41E97C3D.3020104@bigfoot.com> <1105830698.15835.16.camel@localhost.localdomain>
In-Reply-To: <1105830698.15835.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sad, 2005-01-15 at 20:25, Erik Steffl wrote:
> 
>>   I got these errors when accessing SATA disk (via scsi):
>>
>>Jan 15 11:56:50 jojda kernel: ata2: command 0x25 timeout, stat 0x59 
>>host_stat 0x21
>>Jan 15 11:56:50 jojda kernel: ata2: status=0x59 { DriveReady 
>>SeekComplete DataRequest Error }
>>Jan 15 11:56:50 jojda kernel: ata2: error=0x40 { UncorrectableError }
> 
> 
> Bad sector - the disk has lost the data on some blocks. Thats a physical
> disk failure.

   what's somewhat weird is that the disk _seemed_ OK (i.e. no errors 
that I would notice, nothing in the syslog) and then suddenly the disk 
does not respond at all, I tried dd_rescue and it ran for hours (more 
than a day) and it rescued absolutely nothing. Is it possible that the 
disk surface is OK but the electronics went bad? Is there anything that 
can be done if that's the case? (I have another disk, same model).

	erik
