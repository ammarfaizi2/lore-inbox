Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268966AbRHBOwU>; Thu, 2 Aug 2001 10:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268970AbRHBOwB>; Thu, 2 Aug 2001 10:52:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8466 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268966AbRHBOv5>; Thu, 2 Aug 2001 10:51:57 -0400
Subject: Re: Memory Problems - CTCS/memtst
To: cdhs@commerce.uk.net (Corin Hartland-Swann)
Date: Thu, 2 Aug 2001 15:53:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, jcollins@valinux.com (Jason Collins)
In-Reply-To: <Pine.LNX.4.21.0108021442570.23264-100000@willow.commerce.uk.net> from "Corin Hartland-Swann" at Aug 02, 2001 02:43:36 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SJqa-0000lu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The BIOS has an ECC logging feature, and if I understand it correctly,
> then there /cannot/ have been any main memory errors or they would have
> shown up in the logs. At least not any single or double-bit errors (ECC
> corrects single-bit and detects double-bit, doesn't it?)

ALmost certainly it should have been logged. That indicates you may have
problems elsewhere (pci bus, drivers, motherboard, processors...) or you
might even be triggering a kernel bug.

Try a  2.2.19 kernel just out of curiousity
