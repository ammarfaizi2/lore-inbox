Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVAERcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVAERcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVAERcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:32:46 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:1685 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S262287AbVAERac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:30:32 -0500
Date: Wed, 5 Jan 2005 18:30:31 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APIC/LAPIC hanging problems on nForce2 system.
In-Reply-To: <41DC2353.7010206@gmx.de>
Message-ID: <Pine.LNX.4.60.0501051829350.25946@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
 <41DC1AD7.7000705@gmx.de> <Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>
 <41DC2113.8080604@gmx.de> <Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>
 <41DC2353.7010206@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jan 2005, Prakash K. Cheemplavam wrote:

> Martin Drab schrieb:
> > Is there some other way to get to know whether BIOS contains the fix
> > allready?
> 
> lspci -xxx
> 
> then check
> 
> 0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
> version?) (rev c1)
> 00: de 10 e0 01 06 00 b0 00 c1 00 00 06 00 00 80 00
> 10: 08 00 00 a0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 7b 14 00 1c
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
> 40: 02 60 30 00 1b 42 00 1f 02 03 00 00 ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: 08 00 01 20 20 00 88 80 10 00 00 00 01 ff 01 9f <----
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: 00 01 00 00 ff ff ff 3f 01 00 00 00 01 80 00 00
> 90: 14 80 40 a7 14 80 40 a5 00 30 00 00 00 00 00 00
> a0: 40 00 00 00 32 fb 10 00 01 00 00 00 00 00 00 00
> b0: cc ff 07 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 33 33 03 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: d6 01 47 00 16 30 00 10 00 00 00 00 00 00 00 00
> f0: 0f 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 
> From fixup.c:
>          * Chip  Old value   New value
>          * C17   0x1F0FFF01  0x1F01FF01
>          * C18D  0x9F0FFF01  0x9F01FF01
> 
> If there is old value, it needs to be fixed.

OK, I'll check it out.

Thanks,
Martin

