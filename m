Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSHGWes>; Wed, 7 Aug 2002 18:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSHGWer>; Wed, 7 Aug 2002 18:34:47 -0400
Received: from jalon.able.es ([212.97.163.2]:44177 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316541AbSHGWeq>;
	Wed, 7 Aug 2002 18:34:46 -0400
Date: Thu, 8 Aug 2002 00:36:36 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Reed, Timothy A" <timothy.a.reed@lmco.com>
Cc: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Hyperthreading Options in 2.4.19
Message-ID: <20020807223636.GC1537@werewolf.able.es>
References: <9EFD49E2FB59D411AABA0008C7E675C009D8DEE3@emss04m10.ems.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <9EFD49E2FB59D411AABA0008C7E675C009D8DEE3@emss04m10.ems.lmco.com>; from timothy.a.reed@lmco.com on Wed, Aug 07, 2002 at 20:22:05 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.08.07 "Reed, Timothy A" wrote:
>Hello All,
>	I am going rounds with a sub-contractor of ours about what options
>should and should not be compiled into the kernel in order for
>Hyperthreading to work.  Can anyone make any suggestions and comments to the
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

In summary, with 2.4.19 you do not have to do nothing to have hyperthreading.
Other useful options are 'noht' to disable ht, and 'idle=poll', that I think
improves latency.

by

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre1-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-0.2mdk))
