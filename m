Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287872AbSA0ISW>; Sun, 27 Jan 2002 03:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287874AbSA0ISJ>; Sun, 27 Jan 2002 03:18:09 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:30154 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S287872AbSA0ISD>;
	Sun, 27 Jan 2002 03:18:03 -0500
Date: Sun, 27 Jan 2002 09:17:58 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201270817.JAA27327@harpo.it.uu.se>
To: byzantinehk@yahoo.com.hk
Subject: Re: Is Local APIC work with Athlon?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2002 11:48:00 +0800 (CST), Ka Fai Lau wrote:
>I am using ECS K7VZA (KT133a chipset) and Athlon. I
>complied my 2.4.17 kernel with Local APIC support. How
>do I know is it working or not? I have to use the
>performance counter and local timer interrupt feature.

All K7s except the very first model (K7 model 1) work, unless
your BIOS is broken. Since you have a VIA chipset, you may see
spurious IRQ7/ERR interrupts. We don't quite know why, but it's
not fatal. Disabling LPT support in the BIOS _may_ help.

/Mikael
