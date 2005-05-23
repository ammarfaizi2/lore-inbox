Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVEWVEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVEWVEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 17:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVEWVEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 17:04:51 -0400
Received: from mail.dvmed.net ([216.237.124.58]:34506 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261968AbVEWVEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 17:04:39 -0400
Message-ID: <42924560.9070307@pobox.com>
Date: Mon, 23 May 2005 17:04:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Pomorin <dotkomm@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA not works in Linux 2.6.12, but in Windows works fine.
References: <web-135595327@mail5.rambler.ru>	 <20050523193010.5bf72481.vsu@altlinux.ru> <3fc35c7e05052313523ab43067@mail.gmail.com>
In-Reply-To: <3fc35c7e05052313523ab43067@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Pomorin wrote:
> 2005/5/23, Sergey Vlasov <vsu@altlinux.ru>:
> 
>>This is a known problem - if the Intel ICH5/6 controller is used in
>>combined mode (SATA mapped to legacy IDE ports), DMA for PATA devices
>>does not work.  If you reconfigure the controller in BIOS to not use the
>>combined mode (so that the SATA part becomes a separate PCI device), DMA
>>for PATA devices will work fine.
>>
>>To IDE developers: Is something planned to work around this problem?
>>AFAIK, there are some machines where BIOS does not provide an option to
>>turn off the combined mode.
>>
> 
> Hi there,
> Got similar looking problem here,

It's completely different.


> i cant change sata modes or something alike...

That doesn't matter under SATA.


> I get *disabling irq* message with Intel ICH 4 / SIL 3112 A rev 01
> SATA Controller on Asus P4G8X Deluxe board (P4 Northwood, Intel
> *granite bay* E702 Chipsets) at distros which using newer kernel than

This is a totally different problem.

	Jeff



