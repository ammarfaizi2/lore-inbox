Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbTCRUIv>; Tue, 18 Mar 2003 15:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262540AbTCRUIv>; Tue, 18 Mar 2003 15:08:51 -0500
Received: from mail2.ewetel.de ([212.6.122.18]:26548 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id <S262536AbTCRUIu>;
	Tue, 18 Mar 2003 15:08:50 -0500
To: linux-kernel@vger.kernel.org
Cc: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4  due to wrmsr (performance)
In-Reply-To: <20030318184010$6448@gated-at.bofh.it>
References: <20030318165013$55f4@gated-at.bofh.it> <20030318184010$6448@gated-at.bofh.it>
Date: Tue, 18 Mar 2003 21:19:38 +0100
Message-Id: <E18vNYg-0000Qx-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003 19:40:10 +0100, you wrote in linux.kernel:

> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 6
> model name      : AMD Athlon(tm) Processor
> stepping        : 2
> cpu MHz         : 1409.946
> empty overhead=11 cycles
> load overhead=5 cycles
> I$ load overhead=5 cycles
> I$ load overhead=5 cycles
> I$ store overhead=826 cycles
> 
> The Athlon XP shows really bad behavior when you store to the text area.

There seems to be a (surprising?) difference between AthlonXP model 6 and 
model 8:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 1700+
stepping        : 0

empty overhead=16 cycles
load overhead=1 cycles
I$ load overhead=2 cycles
I$ load overhead=1 cycles
I$ store overhead=81 cycles

-- 
Ciao,
Pascal
