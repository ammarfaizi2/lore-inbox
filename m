Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVJSPwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVJSPwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVJSPwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:52:11 -0400
Received: from bno-84-242-95-19.nat.karneval.cz ([84.242.95.19]:23213 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751137AbVJSPwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:52:10 -0400
Message-ID: <43566BB7.8050100@gmail.com>
Date: Wed, 19 Oct 2005 17:52:23 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1
References: <20051016154108.25735ee3.akpm@osdl.org> <43565257.6020505@ens-lyon.fr>
In-Reply-To: <43565257.6020505@ens-lyon.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Buisse napsal(a):

>I've been having problems with ipw2200 oopsing at modprobe since
>2.6.14-rc2-mm1 (sorry for not reporting before). I use the ipw2200
>  
>
2.6.14-rc2 is OK (or what was the last OK)? There are no significant
changes in rc2-mm1.

>included in the kernel.
>
>.config is attached.
>
>Regards,
>Alexandre
>
>[   96.855956] ieee80211_crypt: registered algorithm 'NULL'
>[   96.866572] ieee80211: 802.11 data/management/control stack, git-1.1.5
>[   96.866689] ieee80211: Copyright (C) 2004-2005 Intel Corporation
><jketreno@linux.intel.com>
>[   96.885063] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver,
>1.0.0
>[   96.885182] ipw2200: Copyright(c) 2003-2004 Intel Corporation
>[   96.885697] ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI
>11 (level, low) -> IRQ 11
>[   96.885796] ipw2200: Detected Intel PRO/Wireless 2200BG Network
>Connection
>[   97.932261] eth1 (WE) : Driver using old /proc/net/wireless support,
>please fix driver !
>[   97.978805] eth1 (WE) : Driver using old /proc/net/wireless support,
>please fix driver !
>[   98.324671] divide error: 0000 [#1]
>[   98.324675] PREEMPT
>[   98.324677] last sysfs file:
>/devices/pci0000:00/0000:00:1e.0/0000:02:02.0/rf_kill
>[   98.324680] Modules linked in: ipw2200 ieee80211 ieee80211_crypt ac
>thermal battery acpi_cpufreq processor radeon snd_intel8x0
>snd_ac97_codec snd_ac97_bus
>[   98.324690] CPU:    0
>[   98.324691] EIP:    0060:[<e0d605c0>]    Not tainted VLI
>[   98.324693] EFLAGS: 00010093   (2.6.14-rc4-mm1-ubik)
>[   98.324703] EIP is at ieee80211_wx_get_scan+0x740/0x970 [ieee80211]
>[   98.324706] eax: fffad1c8   ebx: 00000000   ecx: 00052e38   edx: ffffffff
>[   98.324710] esi: 00000000   edi: fffad1c8   ebp: d9b9fe74   esp: d9b9fc88
>[   98.324712] ds: 007b   es: 007b   ss: 0068
>[   98.324715] Process iwlist (pid: 6872, threadinfo=d9b9e000 task=d8242530)
>  
>
...oopsing at modprobe since... are you sure? This seems like an iwlist.

thanks for more info,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E

