Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317440AbSHHKwV>; Thu, 8 Aug 2002 06:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317443AbSHHKwV>; Thu, 8 Aug 2002 06:52:21 -0400
Received: from mailgw3a.lmco.com ([192.35.35.7]:7174 "EHLO mailgw3a.lmco.com")
	by vger.kernel.org with ESMTP id <S317440AbSHHKwU>;
	Thu, 8 Aug 2002 06:52:20 -0400
Content-return: allowed
Date: Thu, 08 Aug 2002 06:55:26 -0400
From: "Reed, Timothy A" <timothy.a.reed@lmco.com>
Subject: RE: Hyperthreading Options in 2.4.19
To: "'J.A. Magallon'" <jamagallon@able.es>,
       "'Renato'" <webmaster@cienciapura.com.br>
Cc: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Message-id: <9EFD49E2FB59D411AABA0008C7E675C009D8DEE6@emss04m10.ems.lmco.com>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,
	Thanks for the answers!  In doing research on those options I too
found that they were not need for Hyperthreading, but I needed something
more to back up opinion.

Thanks Again.

Timothy Reed
Software Engineer\Systems Administrator
Lockheed Martin - NE & SS Syracuse
Email: timothy.a.reed@lmco.com


-----Original Message-----
From: J.A. Magallon [mailto:jamagallon@able.es]
Sent: Wednesday, August 07, 2002 6:37 PM
To: Reed, Timothy A
Cc: Linux Kernel ML (E-mail)
Subject: Re: Hyperthreading Options in 2.4.19



On 2002.08.07 "Reed, Timothy A" wrote:
>Hello All,
>	I am going rounds with a sub-contractor of ours about what options
>should and should not be compiled into the kernel in order for
>Hyperthreading to work.  Can anyone make any suggestions and comments to
the
>options (below)  that I am planning on enforcing:
>	MSR
>	MTRR
>	CPUID

I thikn none is needed for ht. Of course, mtrr raises performance.
The other are not needed, afaik.

>
>	Lilo.conf : acpismp=force?? 
>

True for old kernels, not needed anymore.

>	Are the following worth any thing of value to Hyperthreading:
>	Microcode
>	ACPI

No.

In summary, with 2.4.19 you do not have to do nothing to have
hyperthreading.
Other useful options are 'noht' to disable ht, and 'idle=poll', that I think
improves latency.

by

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like
sex:
werewolf.able.es                         \           It's better when it's
free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre1-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-0.2mdk))
