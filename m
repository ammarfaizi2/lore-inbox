Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWHMKy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWHMKy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 06:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWHMKy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 06:54:29 -0400
Received: from poesci.dolphinics.no ([193.71.152.8]:38350 "EHLO
	poesci.dolphinics.no") by vger.kernel.org with ESMTP
	id S1750956AbWHMKy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 06:54:28 -0400
Message-ID: <44DF04E4.1090809@dolphinics.no>
Date: Sun, 13 Aug 2006 12:54:28 +0200
From: Simen Thoresen <simentt@dolphinics.no>
Organization: Dolphin ICS
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: gmu 2k6 <gmu2006@gmail.com>
Cc: Joel Jaeggli <joelja@uoregon.edu>, linux-kernel@vger.kernel.org
Subject: Re: Only 3.2G ram out of 4G seen in an i386 box
References: <20060808101504.GJ2152@stingr.net>	 <MDEHLPKNGKAHNMBLJOLKKEDCNKAB.davids@webmaster.com>	 <f96157c40608082351j301efa57n412284f8d28124ef@mail.gmail.com>	 <20060809074815.bec7f32c.joelja@uoregon.edu>	 <f96157c40608090754m1f10e0f2h5fbf3b256d2e55e1@mail.gmail.com>	 <44DBA06E.40104@dolphinics.no> <f96157c40608110408u65a4cedege5477c60100d2a3f@mail.gmail.com>
In-Reply-To: <f96157c40608110408u65a4cedege5477c60100d2a3f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gmu 2k6 wrote:
> On 8/10/06, Simen Thoresen <simentt@dolphinics.no> wrote:
>> gmu 2k6 wrote:
>> ...
>> > so what does it mean that one of Xeons here shows me the full 4GiB as
>> > total physical memory via `free`?
>> >
>> Just out of interest - what chipset does your Xeon system use?
> 
> lspci of the P4 32bit desktop with 3GiB
> 00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller
> Hub (rev 02)
> 00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP
> Controller (rev 02)
> 00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
> UHCI Controller #1 (rev 02)
> 
> lspci of the Xeon 32bit HP Proliant Server with 4GiB:
> 00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 0c)
> 00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express
> Port A (rev 0c)
> 00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 0c)
> 00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
> UHCI Controller #1 (rev 02)

We know the E7520 is able to do the remapping, provided the BIOS does not 
mess it up. I have no idea about the E7210 (or the 875P - I was not aware 
that they were this closely related), but without checking any docs I'm 
assuming a 4G memory ceiling and no remapping capability.

Thank you.

> lspci of the new box with 975X and Core 2 Duo not available yet for
> obvious reasons (I don't have the the box yet).

I'd appreciate if you could send me both lspci and /proc/iomem output when 
you get one of these with 4G or more ram installed. Off list, please.

Yours,
-S
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Simen Thoresen, Dolphin ICS
