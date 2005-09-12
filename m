Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVILReA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVILReA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVILRd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:33:59 -0400
Received: from ciistr2.ist.utl.pt ([193.136.128.2]:2007 "EHLO
	ciistr2.ist.utl.pt") by vger.kernel.org with ESMTP id S1751081AbVILRd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:33:59 -0400
Message-ID: <4325BBFF.3010005@arrakis.dhis.org>
Date: Mon, 12 Sep 2005 18:33:51 +0100
From: Pedro Venda <pjvenda@arrakis.net.dhis.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bad I/O performance Highpoint Rocket 1520 SATA controller (kernel
 2.6.11.12)
References: <EXCHG2003xLDp7mvjkO000006bc@EXCHG2003.microtech-ks.com>
In-Reply-To: <EXCHG2003xLDp7mvjkO000006bc@EXCHG2003.microtech-ks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Heflin wrote:

>>hde: SAMSUNG SP0802N, ATA DISK drive
>>hde: max request size: 1024KiB
>>hde: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63,
>>UDMA(100) DISK drive
>>hdg: [same as hde]

>>HPT372A: IDE controller at PCI slot 0000:01:02.0
>>     ide4: BM-DMA at 0x8400-0x8407, BIOS settings: hdi:DMA, hdj:pio
>>     ide5: BM-DMA at 0x8408-0x840f, BIOS settings: hdk:DMA, hdl:pio

> 1520/1640's are low end, Highpoint 1810, and 1820 are real raid
> and quite fast, but need their extra driver to work.  The newer
> 2220 are quite good also, they are probably also quite a bit
> more money.

hi roger, thanks for the reply,

besides being 100% true, it's irrelevant. I'm not using the card's raid 
features. As a standalone drive controller, it should be no different 
from a non-raid version (it's HPT302 instead of HPT372) and therefore 
should do the job normally i.e. with proper I/O speeds.

> I won't use a 1520/1640.   I think they are also fakeraid.

yes, they are. I'd be interested in finding out decent and well 
supported (linux opensource drivers, preferably in kernel tree) low-end 
(cheap) non-raid SATA controllers for 2/4 drives.

best regards,
pedro venda.
--
Pedro João Lopes Venda
pjvenda < at > arrakis dhis org
http://arrakis.dhis.org
