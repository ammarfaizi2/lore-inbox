Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317599AbSG2ToF>; Mon, 29 Jul 2002 15:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSG2ToF>; Mon, 29 Jul 2002 15:44:05 -0400
Received: from virtmail.zianet.com ([216.234.192.37]:48102 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S317599AbSG2ToE>;
	Mon, 29 Jul 2002 15:44:04 -0400
Message-ID: <3D459E09.9030200@zianet.com>
Date: Mon, 29 Jul 2002 13:56:57 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: scorpionlab@ieg.com.br
CC: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC in SMP dual Athlon XP1800
References: <200207291612.38473.scorpionlab@ieg.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I'll probably tell you what just about everyone else here will.
If you use XP procs on a MP system you are on your own.  If you
lucky they will work, if you aren't they won't.  It appears that you
are not lucky.  

Steve

Scorpion wrote:

>Hi follows,
>I'm getting in troubles with a A7M266-D motherboard with two
>Athlon XP 1800 cpus (yes, XP not MP!).
>Following the screen shot of my problem:
>^-------cut here---------^
>EIP:    0010:[<c0111686>]    Not tainted
>EFLAGS: 00011046
><4>CPU:    1
><4>CPU:    1
>EIP:    0010:[<c0111686>]    Not tainted
>EFLAGS:  00011046
> `u!wisuu`m aeesess 7eg111eg
> printing eip:
> printing eip:
>*pde = 11111010
>Stuck ??
>CPU #1 not responding - cannot use it.
>Error: only one processor found.
>ENABLING IO-APIC IRQs
>Setting 2 in the phys_id_present_map
>...changing IO-APIC physical APIC ID to 2 ... ok.
>init IO_APIC IRQs
> IO-APIC (apicid-pin) 2-10, 2-11, 2-12, 2-13, 2-16, 2-17, 2-20, 2-21, 2-22, 
>2-23 not connected.
>..TIMER: vector=0x31 pin1=2 pin2=0
>^-----cut here-----^
>
>After spend some times put printk's in kernel source like "Reach this point!"
>I was trying disable IO_APIC in .config file but some link erros ocurred. 
>Has any way to turn IO_APIC disable? Or its extreme necessary?
>
>Thanks,
>Ricardo.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



