Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbUKOApb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUKOApb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 19:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUKOApb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 19:45:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55731 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261388AbUKOApZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 19:45:25 -0500
Message-ID: <4197FC19.8070609@pobox.com>
Date: Sun, 14 Nov 2004 19:45:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] OSS via82cxxx_audio.c: enable procfs code
References: <20041114022446.GK2249@stusta.de> <1100468548.25615.2.camel@localhost.localdomain> <4197F2D9.8050409@pobox.com> <20041115001203.GX2249@stusta.de>
In-Reply-To: <20041115001203.GX2249@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Nov 14, 2004 at 07:05:45PM -0500, Jeff Garzik wrote:
> 
>>Alan Cox wrote:
>>
>>>On Sul, 2004-11-14 at 02:24, Adrian Bunk wrote:
>>>
>>>
>>>>The patch below enables the procfs code in sound/oss/via82cxxx_audio.c 
>>>>if CONFIG_PROC_FS=y.
>>>
>>>
>>>I don't see what needs fixing here. Generally the /proc file shouldnt
>>>exist
>>
>>Existing procfs code in via82cxxx_audio is never enabled, due to removal 
>>of CONFIG_SOUND_VIA82CXXX_PROCFS:
>>
>>#if defined(CONFIG_PROC_FS) && \
>>    defined(CONFIG_SOUND_VIA82CXXX_PROCFS)
>>#define VIA_PROC_FS 1
>>#endif
>>
>>However, I don't mind if someone removes the procfs code completely.
> 
> 
> How else is this information available?

lspci.  it's just a verbose dump of PCI config registers.


