Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263908AbTDHDT2 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 23:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTDHDT2 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 23:19:28 -0400
Received: from [210.22.78.238] ([210.22.78.238]:18624 "HELO trust-mart.com")
	by vger.kernel.org with SMTP id S263908AbTDHDT1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 23:19:27 -0400
From: hv <hv@trust-mart.com.cn>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile error with 2.5.66-ac2
Message-Id: <20030408113005.26348e82.hv@trust-mart.com.cn>
In-Reply-To: <1049715050.2965.38.camel@dhcp22.swansea.linux.org.uk>
References: <20030407122310.22b2023a.hv@trust-mart.com.cn>
	<1049715050.2965.38.camel@dhcp22.swansea.linux.org.uk>
Organization: it-TM
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 7 Apr 2003 23:19:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have resolve this problem,but I dont know why......
When I use "CFLAGS= -Os -march=pentium3" on my HP LH6000(CPU is PIII 700),THe error appears. I change -Os to -O3 ,the error disappear.
but CFLAGS="-Os -march=pentium4" on my PC(P4 1.5G CPU),the error not appear any more.

On 07 Apr 2003 12:30:51 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Llu, 2003-04-07 at 05:12, hv wrote:
> > Hi,
> >   When I compile 2.5.66-ac2 on HP LH6000,I get the follow error:
> > arch/i386/kernel/apic.c: In function `setup_local_APIC':
> > arch/i386/kernel/apic.c:454: unrecognizable insn:
> > (insn 541 1623 1624 (set (strict_low_part (reg:QI 2 cl [58]))
> >         (const_int 0 [0x0])) -1 (insn_list:REG_DEP_OUTPUT 530 (nil))
> >     (nil))
> > arch/i386/kernel/apic.c:454: Internal compiler error in insn_default_length, at
> > insn-attrtab.c:356
> 
> Is this repeatable ?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
