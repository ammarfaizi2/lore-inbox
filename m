Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWGBIgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWGBIgp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 04:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWGBIgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 04:36:45 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:8405 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750796AbWGBIgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 04:36:44 -0400
Message-ID: <44A78599.9060405@free.fr>
Date: Sun, 02 Jul 2006 10:36:41 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: albertl@mail.com
CC: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr> <44A4CE21.30009@tw.ibm.com> <1151654134.44a4d8f6dc320@imp5-g19.free.fr> <44A4E01D.8020604@tw.ibm.com>
In-Reply-To: <44A4E01D.8020604@tw.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert,

Albert Lee wrote:
> castet.matthieu@free.fr wrote:
> 
>>
>>>Could you please test the current libata-upstream tree and
>>>turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h.
>>>
>>
>>Is there a easy way to get libata-upstream tree ?
>>Do I need to install git for that or there are some snapshots somewhere ?
>>
>>
> 
> 
> Hi Matthieu,
> 
> Tejun has a patch against 2.6.17:
> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2
> 
I don't know if I did someting wrong, but it didn't apply cleanly.
So I enable the trace on lastest -mm kernel and I disable the via quirk.

But the printk in the interrupt handler takes some times and hides the 
altstatus delay.

I will try to send you a trace, where I move the printk at the end of 
the interrupt handler.


Matthieu


