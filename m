Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVIUVQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVIUVQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVIUVQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:16:55 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:14234 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964884AbVIUVQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:16:54 -0400
Message-ID: <4331CDC2.1080300@namesys.com>
Date: Wed, 21 Sep 2005 14:16:50 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509201542.j8KFgh2q011730@laptop11.inf.utfsm.cl>	<43304AF2.8080404@namesys.com> <17200.21620.684685.966054@gargle.gargle.HOWL>
In-Reply-To: <17200.21620.684685.966054@gargle.gargle.HOWL>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Hans Reiser writes:
> > Horst von Brand wrote:
> > 
> > >
> > >
> > >Funny that the "texbook algorithms" aren't used in real life. Wonder why...
> > >  
> > >
> > Try BSD.  If the BSD book can be believed, they use"texbook algorithms".
>
>The "textbook" one-way elevator (as indeed exemplified by FreeBSD's
>src/sys/kern/subr_disk.c:bioq_disksort()) has well-known weaknesses. For
>example,
>
>    dd if=/dev/zero of=FILE
>
>can easily monopolize device queue and starve accesses to the blocks
>with low block numbers.
>
> > 
> > ;-)
>
>Nikita.
>
>
>  
>
Yes, and one can compensate for them  fairly cleanly.  I can't say more
without the customer releasing the code first.
