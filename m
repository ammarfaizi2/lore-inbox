Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316916AbSE3XPZ>; Thu, 30 May 2002 19:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316919AbSE3XPY>; Thu, 30 May 2002 19:15:24 -0400
Received: from jalon.able.es ([212.97.163.2]:37573 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316916AbSE3XPY>;
	Thu, 30 May 2002 19:15:24 -0400
Date: Fri, 31 May 2002 01:15:19 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 cpu selection (first hack)
Message-ID: <20020530231519.GA5519@werewolf.able.es>
In-Reply-To: <20020530225015.GA1829@werewolf.able.es> <1022803536.12888.405.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.31 Alan Cox wrote:
>On Thu, 2002-05-30 at 23:50, J.A. Magallon wrote:
>> - Make all and every cpu a checkbox, so you just say 'I want my kernel to
>>   support this and that CPU'. This kills the problem of the ordering, and
>>   adds one other advantage: you do not need to support intermediate CPUs,
>>   like 'i want my kernel to run ok on pentium-mmx (my firewall) and on
>>   p4 (my desktop). I will never run it on a PII, so do not include the
>>   hacks for PII'. And of course, 'If I run my p-mmx capable on a friend's
>>   PII and it eats his drive and burns his TV set, it is only _my_ fault'.
>
>How about
>
>	'Omit support for processors without an FPU'
>	'Omit support for processors without working WP (386, Nexgen)'
>	'Require the processor has a TSC'
>
>type questions ?
>

But that requires people to know many hardware details... How the h**l
do I know if my Transmeta or Cyrix or AMD has a TSC ?? Is that an intel
specific thing or x86 ?? I just want a kernel that
runs on my XXX brand 586. What is a TSC ??

I think it has to be done based on brand/model.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP jue may 30 00:48:49 CEST 2002 i686
