Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265871AbUF2RDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUF2RDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 13:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUF2RDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 13:03:52 -0400
Received: from outmx008.isp.belgacom.be ([195.238.3.235]:35759 "EHLO
	outmx008.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265871AbUF2RDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 13:03:38 -0400
Subject: Re: Linux Kernel 2.6.7 Shows Two i8042's in /proc/interrupts?
From: FabF <fabian.frederick@skynet.be>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0406291231040.10973@p500>
References: <Pine.LNX.4.60.0406291231040.10973@p500>
Content-Type: text/plain
Message-Id: <1088528611.3526.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 29 Jun 2004 19:03:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2004-06-29 at 18:32, Justin Piszcz wrote:
> I have APIC+ACPI+/dev/rtc enabled.
> 
> Curious though, why two i8042's?
> 
> $ uname -a
> Linux 2.6.7 #2 SMP Tue Jun 22 18:19:08 EDT 2004 i686 unknown unknown GNU/Linux
> 
> $ gcc -v
> Reading specs from 
> /a/app/gcc-3.4.0/bin/../lib/gcc/i686-pc-linux-gnu/3.4.0/specs
> Configured with: ./configure --prefix=/app/gcc-3.4.0
> Thread model: posix
> gcc version 3.4.0
> 
> # cat /proc/interrupts
>             CPU0       CPU1
>    0:   30593638          0    IO-APIC-edge  timer
>    1:       7228          0    IO-APIC-edge  i8042
>    8:     130233          0    IO-APIC-edge  rtc
>    9:          0          0   IO-APIC-level  acpi
>   12:      87258          0    IO-APIC-edge  i8042
>   14:         38          0    IO-APIC-edge  ide0
>   15:         72          0    IO-APIC-edge  ide1
>   16:    3967335          0   IO-APIC-level  nvidia
>   18:    3431241          0   IO-APIC-level  eth0
>   20:     401933          0   IO-APIC-level  ide2
>   21:      23832          0   IO-APIC-level  EMU10K1
> NMI:          0          0
> LOC:   30594585   30594625
> ERR:          0
> MIS:          0

Same behaviour for a while Justin.I guess second one is used for mouse.

Regards,
FabF

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

