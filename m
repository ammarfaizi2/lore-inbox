Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311940AbSC1Gxy>; Thu, 28 Mar 2002 01:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311948AbSC1Gxq>; Thu, 28 Mar 2002 01:53:46 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:18661 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311940AbSC1Gxe>; Thu, 28 Mar 2002 01:53:34 -0500
Date: Thu, 28 Mar 2002 08:42:21 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support (take 2)
In-Reply-To: <3CA293A3.7040408@didntduck.org>
Message-ID: <Pine.LNX.4.44.0203280818480.20437-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Brian Gerst wrote:

> You are missing the asm stub for the interrupt handler.  You can't just 
> call C code directly from the interrupt vector.  Look in i8259.c where 
> the stubs are for the other APIC interrupts.

hmm, i thought the traps.c stuff was sufficient. Thanks i'll check that 
out.

	Zwane

-- 
http://function.linuxpower.ca
		


