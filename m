Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVBPUuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVBPUuI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 15:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVBPUuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 15:50:07 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:41103 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261866AbVBPUuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 15:50:00 -0500
Message-ID: <4213B1FC.4020706@tiscali.de>
Date: Wed, 16 Feb 2005 21:50:04 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Antwerpen <olli@giesskaennchen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug in SLES8 kernel 2.4.x freezing HP DL740/760
References: <4213AB2B.2050604@giesskaennchen.de>
In-Reply-To: <4213AB2B.2050604@giesskaennchen.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Antwerpen wrote:

> Hi out there,
>
> If there is anybody out there using SLES8 on HP ProLiant DL740/760:
> BEWARE!
>
> SuSE has patched UNICON into the kernel which will cause these servers 
> to hang when booted with vga=normal. The system will run fine in 
> fb-mode, but not in plain text.
>
> I cannot see, where this UNICON-patch comes from, it seems that is has 
> been developed by some turbolinux-coders.
>
> HP and SuSE have not been able to either fix this problem or at least 
> warn someone about this bug, so I will do it now.
> The bug is known since Nov 13th 2004.
>
> If there should be anybody who can help, please contact me.
>
> I hope this information will help someone to not run into deep trouble.
>
> Oliver Antwerpen
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Well if you don't need unicon, then remove the patch from the .spec file 
and rebuild the kernel (from the source rpm). Or report it their bug 
tracking system.

Matthias-Christian Ott
