Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbSLMNhL>; Fri, 13 Dec 2002 08:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSLMNhL>; Fri, 13 Dec 2002 08:37:11 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:40591 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S262913AbSLMNhK>; Fri, 13 Dec 2002 08:37:10 -0500
Date: Fri, 13 Dec 2002 05:45:28 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: =?iso-8859-1?q?Jo=E3o=20Seabra?= <seabra@aac.uc.pt>
cc: linux-kernel@vger.kernel.org
Subject: Re: Local APIC(?)+PIII mobile 
In-Reply-To: <200212131156.11262.seabra@aac.uc.pt>
Message-ID: <Pine.LNX.4.44.0212130537080.13166-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the intel 440mx chipset that the asus is based on doesn't include an apic. 
an apic is for doing multiprocessor interupt managemnet. across multiple 
I/O subsystem each can have it own set of interupts...

On Fri, 13 Dec 2002, João Seabra wrote:

> Hi all
> 
>  I have an Asus S8600. 
>  Mobile PIII 800Mhz + 192M RAM.
>  If i select "Local APIC support on uniprocessors" the kernel while booting 
> says there's no APIC present.Why?
>  I know the same problem with some other laptops.
>  Others detect it.
>  
> 
>  At home my Athlon Tunderbird + Asus A7V133-C with local APIC enabled detects 
> it but doesn seem to use it ... 
> 
>  cat /proc/interrupts
>            CPU0
>   0:     375529          XT-PIC  timer
>   1:       7452          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   5:     113246          XT-PIC  bttv, eth0
>   8:          2          XT-PIC  rtc
>  10:     144373          XT-PIC  EMU10K1
>  11:     382444          XT-PIC  nvidia
>  12:     153864          XT-PIC  PS/2 Mouse
>  14:      12346          XT-PIC  ide0
>  15:         12          XT-PIC  ide1
> NMI:          0
> ERR:          0
> 
> Anyway why do I need local APIC :) ?What are the advantages?Links?
> 
> Thank you very much for your kindness
> 
>  Best Regards,
> 
>  João Seabra
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


