Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWGXAuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWGXAuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 20:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWGXAuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 20:50:05 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:55 "EHLO rudy.mif.pg.gda.pl")
	by vger.kernel.org with ESMTP id S1751380AbWGXAuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 20:50:04 -0400
Date: Mon, 24 Jul 2006 02:49:57 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Michael Buesch <mb@bu3sch.de>
cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
In-Reply-To: <Pine.BSO.4.63.0607240116020.10018@rudy.mif.pg.gda.pl>
Message-ID: <Pine.BSO.4.63.0607240237030.10018@rudy.mif.pg.gda.pl>
References: <44C099D2.5030300@s5r6.in-berlin.de> <20060723112005.GA6815@martell.zuzino.mipt.ru>
 <Pine.BSO.4.63.0607231929350.10018@rudy.mif.pg.gda.pl> <200607232024.43237.mb@bu3sch.de>
 <Pine.BSO.4.63.0607240116020.10018@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-970320601-1153702197=:10018"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-970320601-1153702197=:10018
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 24 Jul 2006, Tomasz K³oczko wrote:
[..]
> In all other/most of cases (probably ~99%) Lindetd can be used .. but for NOW 
> GENERALY IT IS NOT NOT USED.

I'm just look on number changed fles by Lindent. diffstat shows 14593 
changed files. Number of all *.[ch] files is 16028. So it shows now 
~9% all files passes cleanly indentation using Lindent (my above 
"GENERALY IT IS NOT NOT USED" isn't true :).

IMO it is sill possible add general rule "allways use Lindent" because 
indent can be dissabled/enabled aroud code inccorectly formated by add 
control comments like:

/* *INDENT-OFF* */
/* *INDENT-ON* */

If it will be widely used probably it will allow better identify some 
indent problems.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-970320601-1153702197=:10018--
