Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUI0E76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUI0E76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 00:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUI0E7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 00:59:53 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:55230 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265970AbUI0E7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 00:59:45 -0400
Date: Mon, 27 Sep 2004 14:01:28 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [ACPI] [PATCH] PCI IRQ resource deallocation support [2/3]
In-reply-to: <Pine.LNX.4.60.0409242236330.7426@poirot.grange>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, bjorn.helgaas@hp.com,
       acpi-devel@lists.sourceforge.net, kaneshige.kenji@soft.fujitsu.com,
       akpm@osdl.org, greg@kroah.com, len.brown@intel.com, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Message-id: <41579EA8.8000700@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <414FEBDB.2050201@soft.fujitsu.com>
 <200409210857.59457.bjorn.helgaas@hp.com> <4150D458.3050400@jp.fujitsu.com>
 <20040924.145229.108814142.t-kochi@bq.jp.nec.com>
 <4153BEBA.5030202@jp.fujitsu.com>
 <Pine.LNX.4.60.0409242236330.7426@poirot.grange>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guennadi Liakhovetski,

Thank you for the information.
I refer to arm, arm26 and ppc64 codes.

Thanks,
Kenji Kaneshige


Guennadi Liakhovetski wrote:

> On Fri, 24 Sep 2004, Kenji Kaneshige wrote:
> 
>> Takayoshi Kochi wrote:
>> I'll change my patch to leave dev->irq as it is. And then I'll
>> investigate about defining PCI_UNDEFINED_IRQ.
> 
> 
> Some platforms (arm, arm26, ppc64) define a macro NO_IRQ:
> 
> include/asm-arm/irq.h:#define NO_IRQ        ((unsigned int)(-1))
> include/asm-arm26/irq.h:#define NO_IRQ      ((unsigned int)(-1))
> include/asm-ppc64/irq.h:#define NO_IRQ      (-1)
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 

