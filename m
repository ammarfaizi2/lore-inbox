Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVHaLlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVHaLlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVHaLlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:41:49 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:53722 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S932413AbVHaLls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:41:48 -0400
Message-ID: <43159685.5010405@emc.com>
Date: Wed, 31 Aug 2005 07:37:41 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13] Marvell SATA support (PIO mode)
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <43158800.6010303@gmail.com>
In-Reply-To: <43158800.6010303@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.8.31.6
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ -0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
>> +static struct pci_device_id mv_pci_tbl[] = {
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5040), 0, 0, chip_504x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5041), 0, 0, chip_504x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5080), 0, 0, chip_508x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5081), 0, 0, chip_508x},
>> +
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6040), 0, 0, chip_604x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6041), 0, 0, chip_604x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6080), 0, 0, chip_608x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6081), 0, 0, chip_608x},
>> +    {}            /* terminate list */
>> +};
>> <http://localhost/lxr/ident?i=MODULE_DEVICE_TABLE>
>>
> MODULE_DEVICE_TABLE(pci, 
> <http://localhost/lxr/ident?i=MODULE_DEVICE_TABLE>mv_pci_tbl);  here for 
> hotplug

Thanks Jiri,

All the MODULE_ stuff is at the bottom of the file, including 
MODULE_DEVICE_TABLE.  What inserted those URLs?

BR
