Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293164AbSBWRIM>; Sat, 23 Feb 2002 12:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293163AbSBWRH5>; Sat, 23 Feb 2002 12:07:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17678 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293159AbSBWRHk>; Sat, 23 Feb 2002 12:07:40 -0500
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sat, 23 Feb 2002 17:22:01 +0000 (GMT)
Cc: adam@os.inf.tu-dresden.de (Adam Lackorzynski), fernando@quatro.com.br,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20020223173857.3db89749.skraw@ithnet.com> from "Stephan von Krawczynski" at Feb 23, 2002 05:38:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16efs1-0005cE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <4>CPU1<T0:1339376,T1:446448,D:8,S:446460,C:1339380>
> <4>checking TSC synchronization across CPUs: passed.
> <4>Waiting on wait_init_idle (map = 0x2)
> <4>All processors have done init_idle
> 
> I would say this means the TSC skew fix is broken and shooting down your box. What do you think, Alan?

Seems a reasonable guess. However that TSC skew itself may point to other
problems. It means one processor started running successfully a little after
the other. That might be normal behaviour for that board or might point to 
something else 
