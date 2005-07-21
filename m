Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVGUO21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVGUO21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 10:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVGUO21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 10:28:27 -0400
Received: from aun.it.uu.se ([130.238.12.36]:40860 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261783AbVGUO20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 10:28:26 -0400
Date: Thu, 21 Jul 2005 16:20:51 +0200 (MEST)
Message-Id: <200507211420.j6LEKp6l023181@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@stusta.de
Subject: Re: -mm: strange places for the PERFCTR option
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On i386, the PERFCTR option is currently available under:
> 
>   Power management options (ACPI, APM)
>     APM (Advanced Power Management) BIOS Support
> 
> 
> On x86_64, the PERFCTR option is currently available under:
> 
>   Executable file formats / Emulation
> 
> 
> On ppc, the PERFCTR option is currently available under:
> 
>   Processor
> 
> 
> On ppc64, the PERFCTR option is currently available under:
> 
>   Platform support
> 
> 
> The ppc and ppc64 places seem to be logical, but the places where it's 
> available on i386 and x86_64 are strange.

The strange placement on i386 and x86_64 is probably due to patch
making mistakes. Once I saw patch misapply a Kconfig hunk for
x86_64 by about 900 lines...

Feel free to propose a cleanup patch.

/Mikael
