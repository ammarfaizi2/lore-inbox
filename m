Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265815AbUHCMSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUHCMSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 08:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUHCMSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 08:18:12 -0400
Received: from s124.mittwaldmedien.de ([62.216.178.24]:25259 "EHLO
	s124.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S265815AbUHCMSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 08:18:08 -0400
Message-ID: <410F828E.3090808@vcd-berlin.de>
Date: Tue, 03 Aug 2004 14:18:22 +0200
From: Elmar Hinz <elmar.hinz@vcd-berlin.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Add support for IT8212 IDE controllers
References: <2obsK-5Ni-13@gated-at.bofh.it> <410F7407.8070903@vcd-berlin.de> <1091530208.3573.5.camel@localhost.localdomain>
In-Reply-To: <1091530208.3573.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> Not your fault - I missed out an include file update when I posted it -
> PCI_DEVICE_ID_ITE_8212 is 0x8212..
> 
> 

Oops. I only understand "trainstation". I guess you will put the fixed 
patch on the list. Do you? :-)

In drivers/ide/pci/ some other drivers have a *.h file. Maybe you mean that?

Then I discover on http://lkml.org/lkml/2004/8/1/121 a double linebreak, 
wich causes an error. It is not there in the newsgroup. Strange.



#define DECLARE_ITE_DEV(name_str)			\

	{						\
		.name		= name_str,		\
		.init_chipset	= init_chipset_it8212,	\
		.init_hwif	= init_hwif_it8212,	\
		.channels	= 2,			\
		.autodma	= AUTODMA,		\
		.bootable	= ON_BOARD,		\
	}


Regards

Elmar




