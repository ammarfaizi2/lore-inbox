Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWGWSJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWGWSJv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 14:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWGWSJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 14:09:51 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:9059 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1750888AbWGWSJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 14:09:50 -0400
Date: Sun, 23 Jul 2006 20:09:45 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Jeff Garzik <jgarzik@pobox.com>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
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
In-Reply-To: <44C392EA.1080101@s5r6.in-berlin.de>
Message-ID: <Pine.BSO.4.63.0607231955310.10018@rudy.mif.pg.gda.pl>
References: <20060720190529.GC7643@lumumba.uhasselt.be> 
 <200607210850.17878.eike-kernel@sf-tec.de> 
 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> 
 <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de> 
 <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
 <1153478157.9489.30.camel@hemera> <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI>
 <44C0B29F.2080604@s5r6.in-berlin.de> <Pine.BSO.4.63.0607221949490.10018@rudy.mif.pg.gda.pl>
 <44C26D90.4030307@s5r6.in-berlin.de> <Pine.BSO.4.63.0607222030370.10018@rudy.mif.pg.gda.pl>
 <44C28472.2080509@pobox.com> <44C392EA.1080101@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-534511264-1153678185=:10018"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-534511264-1153678185=:10018
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 23 Jul 2006, Stefan Richter wrote:
[..]
> Tomasz,
>
> yes, we have scripts/Lindent, but it cannot and is not supposed to solve all 
> style issues. Coding style is about _much_ more than whitespace. It includes 
> sensible names, usage of language features...

Yes .. I know about this but it can allow plug some subset of current 
coding style problems. Prodicing Perfect-Word in sigle step is probably 
impossible but start this step by step will be probably rationale :)

Look below is it not will be good now start:

1) review current tree for fix/change code allow pass throw indent without
    errors and commit all neccessary for this changes,

2) produce diff for whole source tree and start disscuss on "are
    current Lindent script indentation rules are correct or not ?",

3) after prepare acceptable by Linus indent rules set setup kind of
    moratory for all (co)developers for submitting indentation changes
    during normal changes submission (month or even half year but IMo
    shorter will be better),

4) aftter passing moratory date Linus can commit all pending changes in
    single commit.

??

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-534511264-1153678185=:10018--
