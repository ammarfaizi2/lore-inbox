Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSCTXtb>; Wed, 20 Mar 2002 18:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312297AbSCTXtW>; Wed, 20 Mar 2002 18:49:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44561 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312296AbSCTXtM>; Wed, 20 Mar 2002 18:49:12 -0500
Subject: Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell box
To: kurt@garloff.de (Kurt Garloff)
Date: Thu, 21 Mar 2002 00:04:51 +0000 (GMT)
Cc: tepperly@llnl.gov (Tom Epperly),
        linux-kernel@vger.kernel.org (Linux kernel list)
In-Reply-To: <20020321002610.F5052@gum01m.etpnet.phys.tue.nl> from "Kurt Garloff" at Mar 21, 2002 12:26:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nq4Z-0003lY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> disassembly?
> AFAICS, its a push %ebp instruction, which should not be illegal. So either
> your stack is overflowing or my suspicion with the defect CPU is applicable.

Or somehow the I/D TLB's got messed up and the ITLB for that entry is now
wrong.
