Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRCAS1q>; Thu, 1 Mar 2001 13:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129762AbRCAS1g>; Thu, 1 Mar 2001 13:27:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44046 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129759AbRCAS13>; Thu, 1 Mar 2001 13:27:29 -0500
Subject: Re: The IO problem on multiple PCI busses
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 1 Mar 2001 18:30:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19350124090521.18330@mailhost.mipsys.com> from "Benjamin Herrenschmidt" at Mar 01, 2001 04:33:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YXq3-0008Hy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm, of course open to any comments about this (in fact, I'd really like
> some feedback). One thing is that we also need to find a way to pass
> those infos to userland. Currently, we implement an arch-specific syscall
> that allow to retreive the IO physical base of a given PCI bus. That may
> be enough, but we may also want something that match more closely what we

This is also a problem for mmio and to an extent other things on pa-risc.
You might want to talk to Grant and the other HPPA hackers

