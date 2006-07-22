Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWGVR6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWGVR6V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 13:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWGVR6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 13:58:21 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:22150 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1750776AbWGVR6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 13:58:20 -0400
Date: Sat, 22 Jul 2006 19:58:16 +0200 (CEST)
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
In-Reply-To: <44C0B29F.2080604@s5r6.in-berlin.de>
Message-ID: <Pine.BSO.4.63.0607221949490.10018@rudy.mif.pg.gda.pl>
References: <20060720190529.GC7643@lumumba.uhasselt.be> 
 <200607210850.17878.eike-kernel@sf-tec.de> 
 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> 
 <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de> 
 <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
 <1153478157.9489.30.camel@hemera> <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI>
 <44C0B29F.2080604@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-2106383190-1153591096=:10018"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2106383190-1153591096=:10018
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 21 Jul 2006, Stefan Richter wrote:

> Pekka J Enberg wrote:
>> Yeah, that's what Andrew prefers but there are maintainers that disagree
>> with that.
>
> Then they should change CodingStyle.

Better will be start use indent.
Coding style seems is Linux case kind of never ending story.
Keep one/common coding style in this case is someting not for small tool 
but more for .. Superman/Hecules (?)

Why not add .indent.pro file in aeach source tree directory and add to 
Makefile "indent" target ?
Why not after add this just before make next release run "make indent" and 
commit all this to git tree ?

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-2106383190-1153591096=:10018--
