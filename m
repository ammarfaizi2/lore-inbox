Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRGGVlS>; Sat, 7 Jul 2001 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265431AbRGGVlI>; Sat, 7 Jul 2001 17:41:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43276 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262288AbRGGVk4>; Sat, 7 Jul 2001 17:40:56 -0400
Subject: Re: Machine check exception? (2.4.6+SMP+VIA)
To: vhou@khmer.cc (Vibol Hou)
Date: Sat, 7 Jul 2001 22:41:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKEEAIEMAA.vhou@khmer.cc> from "Vibol Hou" at Jul 07, 2001 01:32:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IzpL-0006Hq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was running 2.4.6-stable in SMP mode on a dual P3-1GHz machine (VIA 694D
> Chipset / MSI-6321 M/B + ) and the following message popped up after which
> the system hardlocked (no SysRQ input).  What does this message mean?
> 
> CPU 1: Machine Check Exception: 0000000000000004
> Bank 1: b200000000000115
> Kernel panic: CPU context corrupt

It means your processor flagged a fault. The b2....115 number decodes to info
about the fault cause if you grab the PIII manual.

Stupid things like overheating. wrong voltages can also trigger it

