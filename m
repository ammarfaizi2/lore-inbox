Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVHCKD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVHCKD2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVHCKD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:03:28 -0400
Received: from mail.mev.co.uk ([62.49.15.74]:17117 "EHLO mail.mev.co.uk")
	by vger.kernel.org with ESMTP id S262183AbVHCKD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:03:26 -0400
Message-ID: <42F09664.1030700@mev.co.uk>
Date: Wed, 03 Aug 2005 11:03:16 +0100
From: Ian Abbott <abbotti@mev.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050728)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: NZG <ngustavson@emacinc.com>
Cc: comedi@comedi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6VMM, uClinux, & Comedi
References: <200508010817.59676.ngustavson@emacinc.com> <42EF74C1.6020909@mev.co.uk> <200508021612.15183.ngustavson@emacinc.com>
In-Reply-To: <200508021612.15183.ngustavson@emacinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Aug 2005 10:03:25.0734 (UTC) FILETIME=[96D59460:01C59812]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/05 22:12, NZG wrote:
> On Tuesday 02 August 2005 08:27, Ian Abbott wrote:
> 
>>On 01/08/05 14:17, NZG wrote:
>>
>>>I managed to successfully cross-compile Comedi for the Coldfire uClinux
>>>2.6, however it has several unresolved symbols when I try to load it.
>>>
>>>comedi: Unknown symbol pgd_offset_k
>>>comedi: Unknown symbol pmd_none
>>>comedi: Unknown symbol remap_page_range
>>>comedi: Unknown symbol pte_present
>>>comedi: Unknown symbol pte_offset_kernel
>>>comedi: Unknown symbol VMALLOC_VMADDR
>>>comedi: Unknown symbol pte_page
>>
>>It's probably coming to grief in Comedi's Linux compatibility headers
>>somewhere, but as this stuff has changed a few times, which version of
>>Comedi and which kernel version are you using exactly?

> I'm running comedi-0.7.70, but the issue is seems be be coming from the fact 
> that I'm using a nommu arch.

You didn't say what kernel version you were using, but it appears to be 
2.6.9 or less.  Maybe some of the portability issues have been resolved 
in 2.6.12-uc (though probably not all of them).

> The implementation of these functions is probably trivial, but It's taking me 
> a bit since I didn't really understand the VM code before (now I have a small 
> inkling)

The uClinux folks could probably help you there.

> I'll get there, I'm just surprised this hasn't been attempted before.

So you're a pioneer!  Good luck!

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
