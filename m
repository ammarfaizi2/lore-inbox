Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270446AbRHSNws>; Sun, 19 Aug 2001 09:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270450AbRHSNwi>; Sun, 19 Aug 2001 09:52:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8462 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270446AbRHSNw3>; Sun, 19 Aug 2001 09:52:29 -0400
Subject: Re: 2.4.x & Celeron = very slow system
To: administrator@svitonline.com
Date: Sun, 19 Aug 2001 14:55:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Serguei I. Ivantsov" at Aug 19, 2001 04:06:18 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YT2f-0004AJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With 2.4.x kernel my system (Celeron (Coppermine) 850Mhz (100x8.5)
> 256Mb i810) behaves like slow i386sx.
> For example, when I extract 25MB gzip file on 2.2.19 kernel - it
> takes about 12 seconds, but with 2.4.8(9) - 6(!) MINUTES on the SAME
> system...
> The only idea is that 2.4.x kernel turns off cache (L1 & L2) on
> processor (on my cpu). How can I check it? Any ideas?

We don't touch the caches like that. First guess is to disable the ACPI
support, because we've seen that do a million bogus things
