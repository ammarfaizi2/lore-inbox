Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310591AbSCPUeb>; Sat, 16 Mar 2002 15:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310598AbSCPUeV>; Sat, 16 Mar 2002 15:34:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25098 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310591AbSCPUeL>; Sat, 16 Mar 2002 15:34:11 -0500
Subject: Re: 2.4.19-pre2 Cyrix III SEGFAULT (Cyrix II redux?)
To: egberts@yahoo.com (S W)
Date: Sat, 16 Mar 2002 20:50:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020316180705.34916.qmail@web10506.mail.yahoo.com> from "S W" at Mar 16, 2002 10:07:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mL7x-00077q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But I recalled Linux 2.2 having a bug fix for broken
> L2 cache in Cyrix II.  So, it got me thinking again...
> (did Cyrix fix this L2 cache in certain subsequential
> core?)

Certain obscure early 6x86 cpus

> cache bug fix in the kernelso that I can experiement
> them toward the Cyrix III?

The Cyrix III is not even derived from the Cyrix processor line. VIA bought
both Cyrix and IDT's Winchip folks. The Cyrix III is the winchip sequel
(newer versions branded as VIA C3 as VIA dumped the cyrix name completely)

> Assuming no else sees VM bugs, I'll assume that this
> is Cyrix-specific.  I've seen various VM BUGs for each
> patch releases since 2.4.17 particularly when
> compiling.

I suspect hardware problems. A considerable number of people run Cyrix III
C3 and now also Eden systems on Linux. It works very well.

Alan

