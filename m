Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280472AbRJaULU>; Wed, 31 Oct 2001 15:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280470AbRJaULM>; Wed, 31 Oct 2001 15:11:12 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:58544 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S280469AbRJaULC>;
	Wed, 31 Oct 2001 15:11:02 -0500
Date: Wed, 31 Oct 2001 21:11:38 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110312011.VAA28277@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: Local APIC option (CONFIG_X86_UP_APIC) locks up Inspiron 8100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> > Not all BIOS firmware can cope when we switch to UP-APIC. Some laptops 
> > really don't like it one bit.
>
>Correct, and the I8x00 is the prime example of that.
>
>I have a fix, but it involves fairly major surgery:
>- Implement bt_ioremap()/bt_iounmap() which work at early boot-time (the
>  normal ioremap doesn't work yet).
>...
>The patch is still _very_ rough, but it seems to work. Let me know if you want it.

The patch is now available at
http://www.csd.uu.se/~mikpe/linux/patch-2.4.13ac5-init-order-5

/Mikael
