Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272697AbRHaOD3>; Fri, 31 Aug 2001 10:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272698AbRHaODV>; Fri, 31 Aug 2001 10:03:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25609 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272697AbRHaODJ>; Fri, 31 Aug 2001 10:03:09 -0400
Subject: Re: Athlon doesn't like Athlon optimisation?
To: pgallen@randomlogic.com (Paul G. Allen)
Date: Fri, 31 Aug 2001 15:06:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3B8F287A.D3717C07@randomlogic.com> from "Paul G. Allen" at Aug 30, 2001 11:02:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cowg-0003GG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My Dual Athlon (1.4GHz) works just fine (with the exception of the ATA 100 -
> I have to disable DMA).

There is a known errata with the dual athlon chipset where prefetching and
IDE DMA together hang the box. You might want to scan the chip docs/errata
and try turning that bit off and see if it helps. If so its one for pci
quirks
