Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUA1PRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUA1PRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:17:34 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:35497 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265974AbUA1PRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:17:32 -0500
Date: Wed, 28 Jan 2004 16:17:27 +0100
From: David Weinehall <david@southpole.se>
To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Coywolf Qi Hunt <coywolf@lovecn.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [2.0.40-rc8] Works well
Message-ID: <20040128151727.GD16675@khan.acc.umu.se>
Mail-Followup-To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>,
	Coywolf Qi Hunt <coywolf@lovecn.org>,
	Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20040128033755.GC16675@khan.acc.umu.se> <Pine.LNX.4.44.0401280809470.20944-100000@midi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0401280809470.20944-100000@midi>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 08:13:36AM +0200, Markus Hästbacka wrote:
> On Wed, 28 Jan 2004, David Weinehall wrote:
> 
> > On Wed, Jan 28, 2004 at 03:28:30AM +0000, Coywolf Qi Hunt wrote:
> > ...
> > > Recently I just have such an idea that is to port the 2.0.39 to let it
> > > be compiled with my gcc 2.95.4 or any
> > > other latest gcc. At the same time,  also make it remain compliant to
> > > gcc 2.7.2.1. ( I can't find 2.7.2.1, only 2.7.2.3
> > > on the ftp)  Is this work worth while?
> >
> > Well, for sure it's quite a demanding task, since, if I remember
> > correctly, the module-code uses some nasty internal gcc-knowledge to
> > generate code, that simply doesn't work with later versions of gcc.
> > It might be that I remember this incorrectly though.
> >
> only the module-code? :)

Well, I do remember that I did spend a few weeks getting the 2.0-tree to
compile with gcc-3.2, and most problems arose when dealing with the
module-code.  I think I gave up there.

> > It would be interesting, yes, but only if it can be proved to some
> > degree that no new bugs are introduced.
> >
> That would probably be impossible to do without introducing any bugs..

Mmmm.

> > My aim for 2.0.41 is to make it a cleanup-release; remove warnings, tidy
> > up a little source-code mess, kill dead code, fix typos etc.
> >
> Sounds great, a bit amazing that 2.0 is alive again :)

Oh, it's not been dead, as much as laying dormant.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
