Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUHWRiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUHWRiC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUHWRh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:37:29 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:15625 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S266289AbUHWRe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:34:28 -0400
Date: Mon, 23 Aug 2004 19:34:28 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Julien Oster <usenet-20040502@usenet.frodoid.org>,
       Miles Lane <miles.lane@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <1093200364.24866.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60L.0408231925210.3003@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net> 
 <87hdqyogp4.fsf@killer.ninja.frodoid.org>  <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
  <1093174557.24319.55.camel@localhost.localdomain> 
 <Pine.LNX.4.60L.0408221845450.3003@rudy.mif.pg.gda.pl>
 <1093200364.24866.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1069250240-1093282468=:3003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1069250240-1093282468=:3003
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 22 Aug 2004, Alan Cox wrote:

> On Sul, 2004-08-22 at 19:27, Tomasz K?oczko wrote:
>> Using yor thing path: KProbe/Dtrace is for development and yes it must
>> depend on DEBUG_KERNEL.
>> ptrace() is also for tracing and ver offen used by developers but it is
>> enabled by default and it is not only for developers. So .. ptrace() must
>> also depend on DEBUG_KERNEL.
>
> ptrace is for debugging user space, as for example is oprofile. kprobes
> is for debugging including kernel internal goings on

Yes. It *is* for debuging/tracing in kernel space but like DTrace is 
*also* in user space.

>> compilation stage). In Solaris kernel exist few thousands avalaible probes
>> and IIRC only very small subset is "near zero effect" (uses nop
>> instructions).
>
> Sounds like a kprobes clone 8).

Look on some time stamps both projects.
Seems KProbes is clone DTrace ..

>>> OProfile doesn't require this.
>>
>> As same as KProbe/DTrace. Can you use OProfile for something other tnan
>> profiling ? Probably yes and this answer opens: probably it will be good
>> prepare some common code for KProbe and Oprofile.
>
> Oprofile lets you work on stuff like cache affinity, tuning array walks
> and prefetches. Short of running the app under cachegrind its one of the
> most detailed ways of getting all the profile register data from the x86
> processors.

The same is KProbes but you can combined with small programs associated 
with called probes. Again: DTrace/KProbes is much more than traditional
profiling/tracing/measuring tools.

>> So it will be good stop disscuss about "yes or no ?" and start about
>> "how and when in Linux ?" ..
>
> When you send patches ?

KProbes patches was annouced on lkml few times.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-1069250240-1093282468=:3003--
