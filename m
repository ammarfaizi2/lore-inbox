Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTDDOGj (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbTDDOBg (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:01:36 -0500
Received: from holomorphy.com ([66.224.33.161]:55952 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263672AbTDDN71 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 08:59:27 -0500
Date: Fri, 4 Apr 2003 06:10:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5-vanilla scribbles on memory on 8quad during boot
Message-ID: <20030404141037.GD993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0304040221510.30262-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0304040221510.30262-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 02:26:18AM -0500, Zwane Mwaikambo wrote:
> This is all averted by my 'purge panic in as assign_irq_vector' 
> patch, as well as my not so invasive pernode idt/vector patch.
> Total of 32 processors activated (31453.18 BogoMIPS).
> ENABLING IO-APIC IRQs
>  printing eip:
> c010c954
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0060:[<c010c954>]    Not tainted
> EFLAGS: 00010202
> EIP is at set_intr_gate+0x14/0x30
> eax: 00606f20   ebx: 07070707   ecx: 07070707   edx: c0138e00
> esi: c0136f20   edi: 0000000c   ebp: 00000127   esp: c3c9ff40
> ds: 007b   es: 007b   ss: 0068

Hmm, this is ugly. As it would otherwise panic(), what workaround was
this done with?


-- wli
