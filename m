Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268993AbUI2UZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268993AbUI2UZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268985AbUI2UZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:25:39 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:40606 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S268993AbUI2UZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:25:33 -0400
Message-ID: <415B1A3B.5040201@blueyonder.co.uk>
Date: Wed, 29 Sep 2004 21:25:31 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml@lpbproductions.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4 and nvidia 1.0-6111
References: <415A6EE6.1090404@blueyonder.co.uk> <200409290741.45825.lkml@lpbproductions.com>
In-Reply-To: <200409290741.45825.lkml@lpbproductions.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2004 20:25:57.0530 (UTC) FILETIME=[870257A0:01C4A662]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Heler wrote:
> This is a known issue and it's releated to some changes in Andrew's tree. Not 
> to sound pesimistic but in the future expect the nvidia drivers to be broken 
> for the -mm tree, it is after an the expiremental kernel tree. 
> 
> matt 
> 
> On Wednesday 29 September 2004 1:14 am, Sid Boyce wrote:
> 
>>The usual patches applied that made it work with -mm3.
>>Changed all instances of NV_REMAP_PAGE_RANGE to NV_REMAP_PFN_RANGE and
>>nv_remap_page_range to nv_remap_pfn_range in nv.c, nv-linux.h,
>>os-agp.c and os-interface.c as redifined in
>>/usr/src/linux-2.6.9-rc2-mm4/include/linux/mm.h.
>>The module builds and installs without problems, but on init 5, I get
>>thrown back to vt1, /var/log/XFree86.0.log gives the error:-
>>(--) NVIDIA(0): Linear framebuffer at 0xD8000000
>>(--) NVIDIA(0): MMIO registers at 0xE1000000
>>(II) NVIDIA(0): NVIDIA GPU detected as: GeForce FX 5200
>>(--) NVIDIA(0): VideoBIOS: 04.34.20.42.01
>>(--) NVIDIA(0): Interlaced video modes are supported on this GPU
>>(II) NVIDIA(0): Detected AGP rate: 8X
>>(EE) NVIDIA(0): Failed to allocate config DMA context
>>(II) UnloadModule: "nvidia"
>>(II) UnloadModule: "vgahw"
>>(II) Unloading /usr/X11R6/lib/modules/libvgahw.a
>>(EE) Screen(s) found, but none have a usable configuration.
>>
>>Fatal server error:
>>no screens found
>>-------------------------------
>>Any help appreciated, also posted to nvidia forum.
>>
>>Regards
>>Sid.
> 
> 
> 
> 
Thanks, it did seem an easy thing to fix, when it built and inmod, I had 
high hopes.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
