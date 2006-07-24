Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWGXIwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWGXIwL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 04:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWGXIwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 04:52:11 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:63935 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1750800AbWGXIwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 04:52:10 -0400
Date: Mon, 24 Jul 2006 10:52:04 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Michael Buesch <mb@bu3sch.de>, linux-kernel@vger.kernel.org,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Lindent cleanup (was Re: [PATCH] drivers: Conversions from
 kmalloc+memset to k(z|c)alloc.)
In-Reply-To: <44C47ECF.5090500@s5r6.in-berlin.de>
Message-ID: <Pine.BSO.4.63.0607241012140.10018@rudy.mif.pg.gda.pl>
References: <44C099D2.5030300@s5r6.in-berlin.de> <20060723112005.GA6815@martell.zuzino.mipt.ru>
 <Pine.BSO.4.63.0607231929350.10018@rudy.mif.pg.gda.pl> <200607232024.43237.mb@bu3sch.de>
 <Pine.BSO.4.63.0607240116020.10018@rudy.mif.pg.gda.pl>
 <Pine.BSO.4.63.0607240237030.10018@rudy.mif.pg.gda.pl> <44C47ECF.5090500@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1752661355-1153731124=:10018"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1752661355-1153731124=:10018
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 24 Jul 2006, Stefan Richter wrote:
[..]
>> IMO it is sill possible add general rule "allways use Lindent" because
>> indent can be dissabled/enabled aroud code inccorectly formated by add
>> control comments like:
>>
>> /* *INDENT-OFF* */
>> /* *INDENT-ON* */
>>
>> If it will be widely used probably it will allow better identify some
>> indent problems.
>
> IMHO: Write code for cpp, cc, as --- but not for any other
> processor-de-jour. All those processors (formatters, checkers etc.) are
> fine to *inspect* code for formal or semantic problems. But this should
> not lead to thousands more or less obscure processor keywords sprinkled
> all over the sources --- bloating them and making them confusing.

*If* it will be allowed by some kind of coding style rules IMO use indent 
control comments will be good use *only* for files (not for piece of 
files) for mark by subsystem maintainer "don't touch this using formaters 
without inform me". IMO allow formating only below main level Linux kernel 
developers (read: below Linus & close co. :) will only make this process 
longer (read: less effective). Time neccessary for make progress from 
current ~10% to ~90% is in this case very importand (will allow cut amount
of flames ;).

Finally probably best will be good add point in release procedure 
something like: "use on whole tree Lindent and commit changes before bump 
to final release". Only first this kind patch will be very huge. All other
will be small or very small.

IMO for good start for above will be send to all Linux maintainers kind 
plain message for try review changes produced by Lindent (by add to 
announce message small comment about this). Only after this IMO it will be 
possible good disscuss on current indend rules.

Anyway .. disscuss on subject without this people will be pointless.

I'll try to monitor diffstat for each next release and generate
kind of "status: using Lindent on curent Linux tree". Probably 
this can help on using indent on Linux tree.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1752661355-1153731124=:10018--
