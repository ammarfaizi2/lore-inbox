Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVAKEfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVAKEfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 23:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVAKEes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 23:34:48 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:23824 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S262391AbVAKEd0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 23:33:26 -0500
Message-ID: <41E35706.3040700@snapgear.com>
Date: Tue, 11 Jan 2005 14:33:10 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       uClinux list <uclinux-dev@uclinux.org>
Subject: Re: [PATCH] m68knommu: cache init code for ColdFire CPU's
References: <200501101711.j0AHB8H5005532@hera.kernel.org> <Pine.GSO.4.61.0501102244070.1908@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.61.0501102244070.1908@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks :-)
I submit these corrections :-)

Regards
Greg




Geert Uytterhoeven wrote:
> On Mon, 10 Jan 2005, Linux Kernel Mailing List wrote:
>>diff -Nru a/include/asm-m68knommu/mcfcache.h b/include/asm-m68knommu/mcfcache.h
>>--- /dev/null	Wed Dec 31 16:00:00 196900
>>+++ b/include/asm-m68knommu/mcfcache.h	2005-01-10 09:11:23 -08:00
> 
> 
>>+ *	Everything from a small linstruction only cache, to configurable
> 
>                                 ^^^^^^^^^^^^
> 				instruction
> 
> 
>>+ *	Simple verion 2 core cache. These have instruction cache only,
> 
>                ^^^^^^
> 	       version
> 
> 
>>+ *	Version 4 cores have a true hardvard style separate instruction
> 
>                                     ^^^^^^^^
> 				    harvard
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
