Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVGLTd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVGLTd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVGLTbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:31:36 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:42546 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S262320AbVGLT3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:29:17 -0400
Date: Tue, 12 Jul 2005 21:29:12 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Tom Zanussi <zanussi@us.ibm.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com,
       varap@us.ibm.com, richardj_moore@uk.ibm.com, prasadav@us.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <17108.5721.202275.377020@tut.ibm.com>
Message-ID: <Pine.BSO.4.62.0507122127300.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
 <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com>
 <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com>
 <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl> <17107.64629.717907.706682@tut.ibm.com>
 <Pine.BSO.4.62.0507121935500.6919@rudy.mif.pg.gda.pl> <17108.1906.628755.613285@tut.ibm.com>
 <Pine.BSO.4.62.0507122026520.6919@rudy.mif.pg.gda.pl> <17108.5721.202275.377020@tut.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-264080367-1121196552=:6919"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-264080367-1121196552=:6919
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 12 Jul 2005, Tom Zanussi wrote:
[..]
> > This is much more simpler and much better for control (also from point of
> > view caching bugs in agregator code -> also from point of view kernel
> > stability).
> >
> > Also .. probably some code for handle i.e. counters cen be the same as
> > existing code in current kernel.
> > Probably some "atomic" (and/or simpler) agregators can be usefull in other
> > places in kernel for collecting some data during all time when system
> > works .. so code for handle this can be reused in non-ocasinal
> > tracing/measuring.
> > And again: all without things like relayfs.
>
> Well, you should check out the sytemtap project.  It's basically a
> DTrace clone which is already doing these kinds of things with
> kprobes, and it's using relayfs...

Probaly by this it will be harder to say "KProbes it is Solaris DTrace
clone".

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-264080367-1121196552=:6919--
