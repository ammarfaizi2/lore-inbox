Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWGVSfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWGVSfT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 14:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWGVSfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 14:35:19 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:40124 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1750989AbWGVSfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 14:35:16 -0400
Date: Sat, 22 Jul 2006 20:35:11 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Panagiotis Issaris <takis@gna.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
In-Reply-To: <44C26D90.4030307@s5r6.in-berlin.de>
Message-ID: <Pine.BSO.4.63.0607222030370.10018@rudy.mif.pg.gda.pl>
References: <20060720190529.GC7643@lumumba.uhasselt.be> 
 <200607210850.17878.eike-kernel@sf-tec.de> 
 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> 
 <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de> 
 <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
 <1153478157.9489.30.camel@hemera> <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI>
 <44C0B29F.2080604@s5r6.in-berlin.de> <Pine.BSO.4.63.0607221949490.10018@rudy.mif.pg.gda.pl>
 <44C26D90.4030307@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-77177336-1153593311=:10018"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-77177336-1153593311=:10018
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 22 Jul 2006, Stefan Richter wrote:
[..]
> Style issues like "sizeof(struct foo)" versus "sizeof(*bar)" in memory 
> allocation are beyond what indent can and should do.
>
>> Coding style seems is Linux case kind of never ending story.
>
> It's not a big deal in my limited experience, as far as there is a documented 
> consensus.
>
>> Keep one/common coding style in this case is someting not for small tool 
>> but more for .. Superman/Hecules (?)
> [...]
>
> Yes. Or subsystem maintainers who didn't already could adopt the documented 
> style. Or correct the document where it doesn't reflect consensus.

Moment .. are you want to say something like "keep commont coding style 
can't be maintained by tool" ?
Even if indent watches on to small coding style emenets still I don't see 
why using this tool isn't one of the current ement of release procedure 
(?).

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-77177336-1153593311=:10018--
