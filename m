Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbUK0Vlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbUK0Vlj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUK0Vli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:41:38 -0500
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:8652
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S261341AbUK0Vlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:41:31 -0500
Message-ID: <41A8F4C3.9070000@freemail.hu>
Date: Sat, 27 Nov 2004 22:42:27 +0100
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; hu; rv:1.7.3) Gecko/20041020
X-Accept-Language: hu, en-us
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM problem on x86-64
References: <41A84875.2030505@freemail.hu> <41A848C4.1030504@freemail.hu> <Pine.LNX.4.61.0411271035340.3173@montezuma.fsmlabs.com> <41A8C3BF.20904@freemail.hu> <Pine.LNX.4.61.0411271123350.3173@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0411271123350.3173@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo írta:
> On Sat, 27 Nov 2004, Zoltan Boszormenyi wrote:
> 
> 
>>Zwane Mwaikambo �rta:
>>
>>>On Sat, 27 Nov 2004, Zoltan Boszormenyi wrote:
>>>
>>>
>>>
>>>>Sorry, this last statement is not true, just compare the two error
>>>>reports above. Both hda and hdc show this error.
>>>
>>>
>>>Please provide full dmesg, lspci and if possible state around which kernel
>>>version the problems began occuring
>>>
>>
>>They are attached. I am running the linuxconsole.sf.net multiconsole
>>extension, I patched the Fedora Core 3 original and the second errata
>>kernel with it and made a custom RPM.
> 
> 
> Heavens =) Would it be possible for you to test latest -bk snapshot?

:-)

I will soon. Although I have to apply this patch also, more than one
person use my machine at once. My 2 and a half year old son would be
angry without his cartoons. ;-)

In the meantime it turned out that downing eth1 did not solve this
problem. The r8169 stopped spitting its messages but I still had one

hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt

in dmesg.

Best regards,
Zoltán Böszörményi
