Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVIVJD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVIVJD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbVIVJD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:03:57 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:37615 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965246AbVIVJD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:03:56 -0400
Message-ID: <43327383.1060507@anagramm.de>
Date: Thu, 22 Sep 2005 11:04:03 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Sanchez <david.sanchez@lexbox.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to Force PIO mode on sata promise (Linux 2.6.10)
References: <17AB476A04B7C842887E0EB1F268111E026FB9@xpserver.intra.lexbox.org>
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E026FB9@xpserver.intra.lexbox.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David!

David Sanchez wrote:
> How did you disabled the DMA ?

Have you seen my .config file?
(Remember that it's all PATA I'm talking about, YMMV!)

I think it is
CONFIG_IDEDMA_PCI_AUTO=n
while
CONFIG_BLK_DEV_IDEDMA_PCI=y
And I am using the
BLK_DEV_PDC202XX_NEW=y

One of the options there made it working...
It's pretty lame (<10MByte/sec) but thats
fine for now (just a test system).

The HDD is a a Maxtor DiamondMax 10, 120GB
(6B120P0), usually pretty fast.

Best greets,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
