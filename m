Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278449AbRJOVdl>; Mon, 15 Oct 2001 17:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278448AbRJOVdV>; Mon, 15 Oct 2001 17:33:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30214 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278446AbRJOVdK>; Mon, 15 Oct 2001 17:33:10 -0400
Subject: Re: SMP processor rework help needed
To: manfred@colorfullife.com (Manfred Spraul)
Date: Mon, 15 Oct 2001 22:39:34 +0100 (BST)
Cc: ebiederm@xmission.com (Eric W. Biederman), linux-kernel@vger.kernel.org
In-Reply-To: <3BCB19E0.64322276@colorfullife.com> from "Manfred Spraul" at Oct 15, 2001 07:16:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15tFSQ-0003SY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Huh?
> 
> 24547202.pdf: (i.e. volume 3 of the ia32 SDM)
> <<<<<<<<
> The APIC ID register is loaded at power up by sampling configuration
> data that is driven onto pins of the processor. For the Pentium 4 and P6
> family processors, pins A11# and A12# and pins BR0# through BR3# are
> sampled; for the Pentium processor, pins BE0# through BE3# are sampled.
> <<<<<<

Dual Pentium at least has a mode where the boot processor is decided by a
boot time resolution - its valuable for HA uses.  I'm not sure if it affects
the APIC ident
