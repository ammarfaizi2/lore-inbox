Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbTANScU>; Tue, 14 Jan 2003 13:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbTANScU>; Tue, 14 Jan 2003 13:32:20 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:23557 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S264943AbTANScT>;
	Tue, 14 Jan 2003 13:32:19 -0500
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: new CPUID bit
References: <3E23E04B.2050802@redhat.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <3E23E04B.2050802@redhat.com>
Date: 14 Jan 2003 13:41:01 -0500
Message-ID: <m38yxn377m.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich> Northwood P4's have one more bit in the CPUID processor info
Ulrich> set: bit 31.  Intel calls the feature PBE (Pending Break
Ulrich> Enable).

For the curious, from <http://www.aceshardware.com/forum?read=80030620>:

Adrian> Bit 31 is PBE (Pending Break Enable) which you can find in the
Adrian> latest P4 instruction manual (document 24547106, page
Adrian> 159-162). To quote:

24547106> Pending Break Enable. The processor supports the use of the
24547106> FERR#/PBE# pin when the processor is in the stop-clock state
24547106> (STPCLK# is asserted) to signal the processor that an
24547106> interrupt is pending and that the processor should return to
24547106> normal operation to handle the interrupt. Bit 10 (PBE
24547106> enable) in the IA32_MISC_ENABLE MSR enables this capability.

-JimC

