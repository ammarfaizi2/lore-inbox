Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132933AbRDRA1P>; Tue, 17 Apr 2001 20:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132934AbRDRA1F>; Tue, 17 Apr 2001 20:27:05 -0400
Received: from upsn13.u-psud.fr ([193.55.10.113]:64461 "EHLO upsn13.u-psud.fr")
	by vger.kernel.org with ESMTP id <S132933AbRDRA0z>;
	Tue, 17 Apr 2001 20:26:55 -0400
Message-ID: <3ADCDF38.5DD2CBB1@fleming.u-psud.fr>
Date: Wed, 18 Apr 2001 02:26:32 +0200
From: Jaquemet Loic <jal@fleming.u-psud.fr>
X-Mailer: Mozilla 4.75 [fr] (X11; U; Linux 2.4.3-ac7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Vibol Hou <vhou@khmer.cc>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 
In-Reply-To: <NDBBKKONDOBLNCIOPCGHIEHBGDAA.vhou@khmer.cc>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vibol Hou a écrit :

> Hi,
>
> I'm using 2.4.4-pre3 and get this message occasionally when the system is
> loaded:
>
> Apr 17 16:10:12 omega kernel: eth0: Too much work in interrupt, status e401.
> Apr 17 16:10:12 omega kernel: eth0: Too much work in interrupt, status e401.
>
> The nic is a 3Com 3c905B. Is this a bad thing?
>
> /proc/interrupts:
>            CPU0       CPU1
>   0:   13167527   12036422    IO-APIC-edge  timer
>   1:          0          2    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   4:      22773      19820    IO-APIC-edge
>   8:          1          0    IO-APIC-edge  rtc
>  15:          1          4    IO-APIC-edge  ide1
>  17:   50001929   49606064   IO-APIC-level  eth0
>  18:    2459038    2364252   IO-APIC-level  aic7xxx
> NMI:          0          0
> LOC:   25202946   25202942
> ERR:          0
>
> --
> Vibol Hou
> KhmerConnection
> http://khmer.cc
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I've got a similar problem with a  RTL-8139 (rev 10) ( 8139too.c )
Apr 17 22:53:12 skippy kernel: eth1: Too much work at interrupt,
IntrStatus=0x0040.

The maintenair of this module writes that's a RxFIIFO Overflow that have
probably no other issue than buying a new processor :)
But .. I didn't have this messages on pre - 2.4.3 kernels .. ( neither on
2.4.3ac7 )



