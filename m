Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbULNFWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbULNFWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 00:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbULNFWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 00:22:51 -0500
Received: from mail.netshadow.at ([217.116.182.106]:2783 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S261420AbULNFWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 00:22:43 -0500
Message-ID: <41BE789B.6090005@netshadow.at>
Date: Tue, 14 Dec 2004 06:22:35 +0100
From: Andreas Unterkircher <unki@netshadow.at>
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: krishna.c@globaledgesoft.com,
       Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: How to enable sysrq feature
References: <41BD24EB.8000502@globaledgesoft.com> <41BD2D35.5080101@netshadow.at> <41BD2F0C.9040602@globaledgesoft.com> <41BDF8B6.8050204@netshadow.at> <8A230BAC-4D4E-11D9-AC6C-000A9567DDDE@e18.physik.tu-muenchen.de>
In-Reply-To: <8A230BAC-4D4E-11D9-AC6C-000A9567DDDE@e18.physik.tu-muenchen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is - if u would take a look to the original post - that 
Krishna says, sysrq is not locateable in /proc ....

Roland Kuhn wrote:

> Hi!
>
> On Dec 13, 2004, at 9:16 PM, Andreas Unterkircher wrote:
>
>> Hi Krishna,
>>
>> If u compiled in sysrq into your kernel and booted the correct kernel 
>> - it must be there.
>>
> echo 1 > /proc/sys/kernel/sysrq
>
>> If u enabled the /proc/config (or /proc/config.gz) with these kernel 
>> options
>>
>>    CONFIG_IKCONFIG
>>    (maybe CONFIG_IKCONFIG_PROC too)
>>
>> you can check with
>>
>> cat /proc/config | grep -i sysrq
>>
>> (or zcat /proc/config.gz | grep -i sysrq)
>>
>> if this options are really in your running kernel.
>>
>> Andi
>
>
> [snip]
> Was it really necessary to quote the .config four times?
>
> Ciao,
>                     Roland
>
> -- 
> TU Muenchen, Physik-Department E18, James-Franck-Str. 85747 Garching
> Telefon 089/289-12592; Telefax 089/289-12570
> -- 
> A mouse is a device used to point at
> the xterm you want to type in.
> Kim Alm on a.s.r.

