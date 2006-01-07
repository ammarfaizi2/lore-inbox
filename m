Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbWAGXin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWAGXin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWAGXin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:38:43 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:30620 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1161066AbWAGXil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:38:41 -0500
Message-ID: <43C050FA.9040400@ens-lyon.org>
Date: Sat, 07 Jan 2006 18:38:34 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>	<43C0172E.7040607@ens-lyon.org> <20060107145800.113d7de5.akpm@osdl.org>
In-Reply-To: <20060107145800.113d7de5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>  
>
>>2) acpi-cpufreq does not load either, returns ENODEV too. It's probably
>> git-acpi. I tried to revert it but there are lots of other patches
>> depending on it, so I finally gave up.
>>    
>>
>
>OK, let me try to reproduce this.  acpi and cpufreq are fully merged up, so
>this bug may well be in mainline now.
>
>  
>
>> 3) wpa_supplicant does not find my WPA network anymore (while iwlist
>> scanning sees). I didn't see anything relevant in dmesg. My driver is
>> ipw2200.
>>    
>>
>
>It's things like this which make me consider a career in carpentry.
>
>I assume 2.6.15 works OK?
>  
>

2.6.15 and 2.6.15-git3 both don't show any of these issues. Did acpi and
cpufreq get merged after -git3 ?

thanks,
Brice

