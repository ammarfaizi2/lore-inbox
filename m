Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131232AbRDCMVu>; Tue, 3 Apr 2001 08:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRDCMVk>; Tue, 3 Apr 2001 08:21:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14085 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131232AbRDCMVc>; Tue, 3 Apr 2001 08:21:32 -0400
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
To: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 3 Apr 2001 13:21:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jsimmons@linux-fbdev.org (James Simmons),
        lk@tantalophile.demon.co.uk (Jamie Lokier),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        linux-fbdev-devel@lists.sourceforge.net (Linux Fbdev development list)
In-Reply-To: <Pine.LNX.4.05.10104030822570.14623-100000@callisto.of.borg> from "Geert Uytterhoeven" at Apr 03, 2001 08:23:55 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kPoq-0007w5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The MMX memcpy for CyrixIII and Athlon boxes is something like twice the
> > speed of rep movs. On most pentium II/III boxes the fast paths for rep movs
> > and for MMX are the same speed
> 
> As long as you are copying in real memory. So the PCI bus or the host bridge
> implementation may be the actual limit.

The CyrixIII sits on the same host bridges as the intel processors
