Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289746AbSAJXRl>; Thu, 10 Jan 2002 18:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289772AbSAJXRW>; Thu, 10 Jan 2002 18:17:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61710 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289746AbSAJXRO>; Thu, 10 Jan 2002 18:17:14 -0500
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
To: Ronald.Wahl@informatik.tu-chemnitz.de (Ronald Wahl)
Date: Thu, 10 Jan 2002 23:28:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m26669olcu.fsf@goliath.csn.tu-chemnitz.de> from "Ronald Wahl" at Jan 11, 2002 12:08:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Oocq-0005tX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is it possible to include an emulation for the CMOV* (and possible other
> i686 instructions) for processors that dont have these (k6, pentium
> etc.)? I think this should work like the fpu emulation. Even if its slow

The kernel isnt there to fix up the fact authors can't read. Its also very
hard to get emulations right. I grant that this wasn't helped by the fact
the gcc x86 folks also couldnt read the pentium pro manual correctly.

If you have a static linked program install the right version. RPMv4
even knows about cmov and i686 rpms.
