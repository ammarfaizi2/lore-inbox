Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVFEJwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVFEJwz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 05:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVFEJwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 05:52:54 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:42951 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S261542AbVFEJwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 05:52:47 -0400
Message-ID: <42A2CF27.8000806@freemail.hu>
Date: Sun, 05 Jun 2005 12:08:39 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mice do not work on 2.6.12-rc5-git9, -rc5-mm1, -rc5-mm2
References: <42A2A0B2.7020003@freemail.hu>	<42A2A657.9060803@freemail.hu> <20050605001001.3e441076.akpm@osdl.org> <42A2BC4B.5060605@freemail.hu>
In-Reply-To: <42A2BC4B.5060605@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi írta:
> Andrew Morton írta:
> 
>> Zoltan Boszormenyi <zboszor@freemail.hu> wrote:
>>
>>> Zoltan Boszormenyi írta:
>>>
>>>> Hi,
>>>>
>>>> $SUBJECT says almost all, system is MSI K8TNeo FIS2R,
>>>> Athlon64 3200+, running FC3/x86-64. I use the multiconsole
>>>> extension from linuxconsole.sf.net, the patch does not touch
>>>> anything relevant under drivers/input or drivers/usb.
>>>>
>>>> The mice are detected just fine but the mouse pointers
>>>> do not move on either of my two screens. The same patch
>>>> (not counting the trivial reject fixes) do work on the
>>>> 2.6.11-1.14_FC3 errata kernel. Both PS2 keyboard on the
>>>> keyboard and aux ports work correctly.
>>>
>>>
>>> The same patch also works on 2.6.12-rc4-mm2, with working mice.
>>> It seems the bug is mainstream.
>>>
>>
>>
>> Please test an unpatched kernel.
> 
> 
> Unmodified rc5-git9, only one X server started on the PCI Radeon
> so the agpgart isn't initialized in the attached dmesg.
> 
> Same bug, USB interrupt count does not change if mice are moved.
> I told you, it's upstream.

pci=routeirq - still same bug.
acpi=off     - rc5-git9 stops booting after PCI -> ACPI IRQ remapping.
???

I will try some older kernels, too.
2.6.12-rc4-mm2 definitely works.

Mainboard BIOS' version is 1.9,
I had ACPI problems with previous versions.

Best regards,
Zoltán Böszörményi
