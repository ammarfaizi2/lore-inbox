Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWGVU4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWGVU4B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 16:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWGVU4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 16:56:01 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:50780 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1751052AbWGVU4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 16:56:00 -0400
Date: Sat, 22 Jul 2006 22:55:55 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Panagiotis Issaris <takis@gna.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
In-Reply-To: <44C28472.2080509@pobox.com>
Message-ID: <Pine.BSO.4.63.0607222242100.10018@rudy.mif.pg.gda.pl>
References: <20060720190529.GC7643@lumumba.uhasselt.be> 
 <200607210850.17878.eike-kernel@sf-tec.de> 
 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> 
 <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de> 
 <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
 <1153478157.9489.30.camel@hemera> <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI>
 <44C0B29F.2080604@s5r6.in-berlin.de> <Pine.BSO.4.63.0607221949490.10018@rudy.mif.pg.gda.pl>
 <44C26D90.4030307@s5r6.in-berlin.de> <Pine.BSO.4.63.0607222030370.10018@rudy.mif.pg.gda.pl>
 <44C28472.2080509@pobox.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-85404816-1153601755=:10018"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-85404816-1153601755=:10018
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 22 Jul 2006, Jeff Garzik wrote:

> Tomasz K³oczko wrote:
>> Moment .. are you want to say something like "keep commont coding style 
>> can't be maintained by tool" ?
>> Even if indent watches on to small coding style emenets still I don't see 
>> why using this tool isn't one of the current ement of release procedure 
>> (?).
>
> indent isn't perfect, _especially_ where C99 comes into the picture.

Again: is in this case "isn't perfect" mean "it does not make all what we 
want" ? If yes still I don't see why not use indent + some other tool or 
if you will show real example where it does something badady (like now 
for checking code syntax is used compiler and some other tools like 
sparse).

> And running indent across the tree pre-release would (a) create a ton of 
> noise before each release, and (b) undo perfectly valid, readable formatting.

Committing all this "noise" will plug all this thing and allow reve most 
of content Documentation/CodingStyle document.
Is it not wort stop all questions/discuss/flames on this subject ?
Again: using indent mainly will mean only one time massive changes. After 
this ident can be runed for example by Linus just before make release and/or 
partial release.

> scripts/Lindent exists and gets used, but it is not perfect.

Again: anywhere are listed/was posted list of "not perfect" examples ? 
And/or: what does it mean in this case "not perfect" ? Show this  for 
allow start work on fix indent by other people (if all cases will be resul 
of some bugs in this tool).

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-85404816-1153601755=:10018--
