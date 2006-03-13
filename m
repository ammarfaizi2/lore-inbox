Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWCMUqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWCMUqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWCMUqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:46:11 -0500
Received: from main.gmane.org ([80.91.229.2]:13462 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750947AbWCMUqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:46:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: New libata PATA patch for 2.6.16-rc1
Date: Mon, 13 Mar 2006 21:41:14 +0100
Message-ID: <pan.2006.03.13.20.41.12.776592@free.fr>
References: <1142262431.25773.25.camel@localhost.localdomain> <pan.2006.03.13.20.28.29.796048@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, 13 Mar 2006 21:28:35 +0100, Matthieu CASTET a écrit :

> Hi Alan,
> 
> Le Mon, 13 Mar 2006 15:07:10 +0000, Alan Cox a écrit :
> 
>> Available from 
>> 
>> http://zeniv.linux.org.uk/~alan/IDE/
>> 
>> 	VIA ATAPI now works for me
> 
> It still doesn't work for me [1].
> May be it has something to do with the lost interrupt I described in my
> previous mail.
> 
> I will try ata_piix in order to see if all PATA device are seen.
> 
> Matthieu
> 
> 
> ata3: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14

> ata3: dev 0 ATA-7, max UDMA/100, 156368016 sectors: LBA48

> ata3: dev 1 ATA-5, max UDMA/100, 80418240 sectors: LBA

> ata3: dev 0 configured for UDMA/33

> ata3: dev 1 configured for UDMA/33

This seems be wrong : why UDMA/100 isn't choosed ?
It was in previous release.

Thanks for your work

Matthieu

PS : Yes I have a 80 pins an ata3 but a 40 pins on ata4

