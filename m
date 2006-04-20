Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWDTKhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWDTKhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWDTKhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:37:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:62427 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750788AbWDTKhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:37:40 -0400
Message-ID: <4447646E.2080008@schweigstill.de>
Date: Thu, 20 Apr 2006 12:37:34 +0200
From: Andreas Schweigstill <andreas@schweigstill.de>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFC: rename arch/arm/mach-s3c2410 to arch/arm/mach-s3c24xx
References: <20060418165204.GG2516@trinity.fluff.org>	<4446187C.2090603@andric.com> <20060419150527.GA4102@flint.arm.linux.org.uk>
In-Reply-To: <20060419150527.GA4102@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:5debdc4a9e8758a8924affe92d8d9587
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell!

Russell King schrieb:
> Folk convinced me that the only thing which we should call "architecture"
> is the CPU - so things like "PPC", "ARM", "i386" are architectures, and
> not implementations of these (AT91RM9200, S3C2410).

And if we use ARM nomenclature there is also a difference between the
architecture (e.g. v4, v4t, v5, ...) and the implementation (ARM7,
ARM7T, ARM9T, Amulet, StrongARM, Xscale, ...) of the CPU core.
So we have to distinguish between the core and the SoC/ASSP
architecture. The register model is defined by the core architecture
but the co-processors (MMU, CP15) by the implementation. And should we
handle OMAP as a standard ARM9/10/11 implementation or another core?
And should StrongARM be inherited from v4 or ARM8?

Does it make sense to reflect this also in the directory naming
conventions? Hmmm, I am not sure. We could end with the complete ARM
company's history.

With best regards
Andreas Schweigstill

-- 
Dipl.-Phys. Andreas Schweigstill
Schweigstill IT | Embedded Systems
Schauenburgerstraﬂe 116, D-24118 Kiel, Germany
Phone: (+49) 431 5606-435, Fax: (+49) 431 5606-436
Mobile: (+49) 171 6921973, Web: http://www.schweigstill.de/



