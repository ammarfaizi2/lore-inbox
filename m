Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbWJRPwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWJRPwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbWJRPwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:52:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:36804 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161188AbWJRPwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:52:10 -0400
Message-ID: <45364D9D.2060003@biallas.net>
Date: Wed, 18 Oct 2006 17:51:57 +0200
From: Sebastian Biallas <sb@biallas.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.7) Gecko/20061011 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Prakash Punnoor <prakash@punnoor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: Disabling IOMMU
References: <45364248.2020901@biallas.net> <200610181741.03428.prakash@punnoor.de>
In-Reply-To: <200610181741.03428.prakash@punnoor.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:a5328446fa42c458b1f4bc094ef9555a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> Am Mittwoch 18 Oktober 2006 17:03 schrieben Sie:
>> Linux ouputs some strange "PCI-DMA: Disabling IOMMU" on booting. It's a
>> ALiveNF4G motherboard with an Athlon64 X2 running vanilla Linux 2.6.18.1
>> (which supports all hardware out of the box, pretty cool).
>>
>> Should I worry about this IOMMU-disabling? All other Linux/IOMMU stuff I
>> found had AGP or BIOS messages nearby, but I only get this single
>> "PCI-DMA: Disabling IOMMU" line, without any hint.
> 
> Unless you have >=4GB of RAM using IOMMU makes no sense, thus it gets 
> disabled.

Thanks for the answer (I thought that IOMMU is also used by VMMs like
XEN, for direct hardware access of the guest. But I might have
misunderstood this).

So maybe this message should read:
PCI-DMA: Not more than 4GiB RAM: Disabling IOMMU
so that people like me don't have to worry.

Regards,
Sebastian

