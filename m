Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUA1DiD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 22:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbUA1DiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 22:38:02 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:47794 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265825AbUA1Dh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 22:37:59 -0500
Date: Wed, 28 Jan 2004 04:37:55 +0100
From: David Weinehall <david@southpole.se>
To: Coywolf Qi Hunt <coywolf@lovecn.org>
Cc: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [2.0.40-rc8] Works well
Message-ID: <20040128033755.GC16675@khan.acc.umu.se>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@lovecn.org>,
	Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>,
	Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <401417A3.7000206@lovecn.org> <20040125222914.GB20879@khan.acc.umu.se> <1075223456.5219.1.camel@midux> <40172C5E.3090201@lovecn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40172C5E.3090201@lovecn.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 03:28:30AM +0000, Coywolf Qi Hunt wrote:
> Markus Hästbacka wrote:
> 
> >Hey David,
> >I just mail to tell you that 2.0.40-rc8 seems to work really well, no
> >problems compiling (except a few warnings :) and absolutely no problem
> >running. Great work!
> >
> >	Markus
> > 
> >
> Hello all 2.0 hackers,

There aren't a lot, I suspect you can count us using one hand
nowadays...

> Recently I just have such an idea that is to port the 2.0.39 to let it 
> be compiled with my gcc 2.95.4 or any
> other latest gcc. At the same time,  also make it remain compliant to 
> gcc 2.7.2.1. ( I can't find 2.7.2.1, only 2.7.2.3
> on the ftp)  Is this work worth while?

Well, for sure it's quite a demanding task, since, if I remember
correctly, the module-code uses some nasty internal gcc-knowledge to
generate code, that simply doesn't work with later versions of gcc.
It might be that I remember this incorrectly though.

It would be interesting, yes, but only if it can be proved to some
degree that no new bugs are introduced.

My aim for 2.0.41 is to make it a cleanup-release; remove warnings, tidy
up a little source-code mess, kill dead code, fix typos etc.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
