Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVGMMkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVGMMkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 08:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVGMMkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 08:40:17 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:54810 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S262639AbVGMMkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 08:40:08 -0400
Date: Wed, 13 Jul 2005 14:40:06 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Vara Prasad <prasadav@us.ibm.com>
cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <42D42FE1.3080600@us.ibm.com>
Message-ID: <Pine.BSO.4.62.0507131437200.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
 <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com>
 <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com>
 <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl> <17107.64629.717907.706682@tut.ibm.com>
 <Pine.BSO.4.62.0507121935500.6919@rudy.mif.pg.gda.pl> <42D42FE1.3080600@us.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-852760313-1121258406=:6919"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-852760313-1121258406=:6919
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 12 Jul 2005, Vara Prasad wrote:

> Tomasz K³oczko wrote:
>
>> On Tue, 12 Jul 2005, Tom Zanussi wrote:
>> 
>>> =?ISO-8859-2?Q?Tomasz_K=B3oczko?= writes:
>>> > On Tue, 12 Jul 2005, Tom Zanussi wrote:
>>> [...]
>>> 
>>> >
>>> > OK .. "so you can say better is stop flushing buffers on measure which
>>> > wil take day or more" ? :_)
>>> > Some DTrace probes/technik are specialy prepared for long or evel very
>>> > long time experiment wich will only prodyce few lines results on end of
>>> > experiment.
>>> > Look at DTrace documentation for speculative tracing:
>>> > http://docs.sun.com/app/docs/doc/817-6223/6mlkidli7?a=view
>
> How do you propose to implement speculative tracing without a buffer to hold 
> the data, when data needs to stay in the kernel for a while before we decide 
> to commit or discard?

Buffering some data inside kernel space and buffering with 
infrastructure for transfer to user space this are two diffrent things.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-852760313-1121258406=:6919--
