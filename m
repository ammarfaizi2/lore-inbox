Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSLNRUa>; Sat, 14 Dec 2002 12:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSLNRUa>; Sat, 14 Dec 2002 12:20:30 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:44054
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262789AbSLNRU3>; Sat, 14 Dec 2002 12:20:29 -0500
Date: Sat, 14 Dec 2002 12:31:01 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Margit Schubert-While <margitsw@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 cpufeatures.h
In-Reply-To: <4.3.2.7.2.20021214124403.00ae5f00@pop.t-online.de>
Message-ID: <Pine.LNX.4.50.0212141226020.32566-100000@montezuma.mastecende.com>
References: <4.3.2.7.2.20021214124403.00ae5f00@pop.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2002, Margit Schubert-While wrote:

> Somewhat confused.
> In include/asm-i386/cpufeature.h we have:
> --snip--
> #define X86_FEATURE_XMM2        (0*32+26) /* Streaming SIMD Extensions-2 */
> #define X86_FEATURE_SELFSNOOP   (0*32+27) /* CPU self snoop */
> #define X86_FEATURE_HT          (0*32+28) /* Hyper-Threading */
> #define X86_FEATURE_ACC         (0*32+29) /* Automatic clock control
> */      <---- ******
> #define X86_FEATURE_IA64        (0*32+30) /* IA-64 processor */
> --end snip--
>
> According to Intel specs, bit 29 is :
> " TM  Thermal Monitor    The processor implements the thermal monitor automatic
>    thermal control circuitry (TMM)"
>
> The (wrong?) FEATURE ACC is used in
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
> arch/i386/kernel/cpu/mcheck/p4.c

They are synonymous.

-- 
function.linuxpower.ca
