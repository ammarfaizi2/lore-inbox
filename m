Return-Path: <linux-kernel-owner+w=401wt.eu-S1751064AbXANB12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbXANB12 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbXANB12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:27:28 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7749 "EHLO
	pd4mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbXANB11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:27:27 -0500
Date: Sat, 13 Jan 2007 19:27:20 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] libata: PIIX3 support
In-reply-to: <fa.wgyMaLVtkeBqyNAZjGg9fEi3shs@ifi.uio.no>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Message-id: <45A986F8.3000300@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.wgyMaLVtkeBqyNAZjGg9fEi3shs@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Wed, 10 Jan 2007 17:13:38 +0000, Alan <alan@lxorguk.ukuu.org.uk> wrote:
>> This I believe completes the PIIX range of support for libata
>>
>> This adds the table entries needed for the PIIX3, both a new PCI
>> identifier and a new mode list. It also fixes an erroneous access to PCI
>> configuration 0x48 on non UDMA capable chips.
> 
> Works fine here on a 430HX box (ASUS T2P4).
> I'm appending kernel messages for boots with the IDE driver and
> with the updated libata driver, in case you want to compare them.
> 
> I did notice that ata_piix identified the disk as
> "QUANTUM FIREBALL A5U." when IDE correctly identified it as
> "QUANTUM FIREBALL CR8.4A".

I believe libata truncates the ATA device ID string to fit the max 
allowable for SCSI. The A5U. part is presumably the drive's firmware 
revision.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

