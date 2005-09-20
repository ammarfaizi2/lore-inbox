Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVITPnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVITPnt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVITPns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:43:48 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:18398 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965050AbVITPns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:43:48 -0400
Message-Id: <200509201542.j8KFgh2q011730@laptop11.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Mon, 19 Sep 2005 23:28:10 MST." <432FABFA.9010406@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 20 Sep 2005 11:42:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 20 Sep 2005 11:42:43 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
> Nick Piggin wrote:
> > Hans Reiser wrote:
> >> So why is the code in the kernel so hard to read then?
> >>
> >> Linux kernel code is getting better, and Andrew Morton's code is
> >> especially good, but for the most part it's unnecessarily hard to
> >> read. Look at the elevator code for instance.  Ugh.

> > What's wrong with the elevator code?

> The name for one.  There is no elevator algorithm anywhere in it.

IO schedulers are commonly called "elevators", even though most of them
aren't. Standard operating system terminology.

>                                                                    There
> is a least block number first algorithm that was called an elevator, but
> it does not have the properties described by Ousterhout and sundry CS
> textbooks describing elevator algorithms.  The textbook algorithms are
> better than least block number first,

Funny that the "texbook algorithms" aren't used in real life. Wonder why...

>                                       and it is interesting how nobody
> fixed the mislabeling of the algorithm once Linux had gotten to the
> point that it was striving for more than making gcc be able to run on it. 

Could you /please/ stop your snide remarks on the code and its authors? If
for nothing else, the very people you are insulting in public are the exact
ones that will decide if they take on the work of auditing and integrating
your code.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
