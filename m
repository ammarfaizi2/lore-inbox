Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUHUN1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUHUN1o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 09:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUHUN1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 09:27:43 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:8207 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S265410AbUHUN1V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 09:27:21 -0400
Date: Sat, 21 Aug 2004 15:27:14 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Julien Oster <lkml-7994@mc.frodoid.org>
cc: Julien Oster <usenet-20040502@usenet.frodoid.org>,
       Miles Lane <miles.lane@comcast.net>, linux-kernel@vger.kernel.org,
       Bryan Cantrill <bmc@kiowa.eng.sun.com>
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <87d61k4rmr.fsf@killer.ninja.frodoid.org>
Message-ID: <Pine.LNX.4.60L.0408211424100.3003@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
 <87hdqyogp4.fsf@killer.ninja.frodoid.org> <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
 <87d61k4rmr.fsf@killer.ninja.frodoid.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-475505734-1093094834=:3003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-475505734-1093094834=:3003
Content-Type: TEXT/PLAIN; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 21 Aug 2004, Julien Oster wrote:
[..]
>> PS. Very interesting commens about this thread is on Bryan Cantrill
>> (DTrace developer) blog:
>> http://blogs.sun.com/roller/page/bmc/20040820#dtrace_on_lkml
>> Bryan blog is also yet another Dtrace knowledge source ..
>
> Oh, yeah, great. A whole blog entry dedicated to me. Now I am a moron,
> absolutely clueless and I am "looking to confirm preconceived notions
> rather than understand new technology".
>
> Sorry, but that goes a little too far. No, I didn't try out dtrace
> and, right after reading the article (and that's the important thing!)
> I didn't seek for further information about it, I'm not a Solaris
> System Administrator right now (I was, some years ago). And all I was
> saying is that this *article* was just ridiculous.

s/DTrace/<something_other>/ .. and yes in any other cases also if you are
not never using this <something_other> and try say publicaly what is it 
maybe you can't be moron but your camment ~100% will be _like_ moron
comment :_)
Why in this case you are comment like moron ? Because DTrace is 
consequense spending may hundrets hours by many many people (probablty not 
only from Sun and not only developers) .. it is probaly bigest innovation 
on operating system word in last few years.

It is very hard to describe in short article what DTrace is and what is not ..
and I can undestand why peple like you after reading some short text will 
see in this *only* tracing tool or *only* profiling tool (*olny* tools 
which they know) .. simple because tool like DTrace partialy creates
new class of tools.
You can know debuger, profiler, any other (statical) tracing tool and 
maybe some tools for measuring some interesting parameters but DTrace 
isn't simple combination above because it have programing abilities. For 
example you can add expression when and what from some bigger set 
parameters/points must be traced or not .. all depending on current 
program/kernel state.

DTrace power isn't in hooking atomic probes abilities but in combine this 
with very small but smart/powerfull programable VM and on collecting some 
data in few usefull forms (tables [1], hashes ..) and reporting all this 
in readable form. This why current Linux KProbe/DProbe isn't so usefull as 
current Solaris DTrace.

[1] in simple tables or tables indexed using probe results or eveven
current stack path or other vector some variables set.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-475505734-1093094834=:3003--
