Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLUPma>; Thu, 21 Dec 2000 10:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbQLUPmU>; Thu, 21 Dec 2000 10:42:20 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:65291 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129289AbQLUPmG>; Thu, 21 Dec 2000 10:42:06 -0500
Message-Id: <200012211511.eBLFBFc02590@pincoya.inf.utfsm.cl>
To: David Weinehall <tao@acc.umu.se>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: fs corruption in 2.4.0-test11? 
In-Reply-To: Message from David Weinehall <tao@acc.umu.se> 
   of "Thu, 21 Dec 2000 15:06:11 BST." <20001221150611.B15178@khan.acc.umu.se> 
Date: Thu, 21 Dec 2000 12:11:15 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <tao@acc.umu.se> said:
> On Thu, Dec 21, 2000 at 10:31:56AM -0300, Horst von Brand wrote:
> > David Weinehall <tao@acc.umu.se> said:
> > > On Wed, Dec 20, 2000 at 04:47:42PM -0800, Larry McVoy wrote:
> > > > I just need a sanity check - do other pages/blocks sometimes show
> > > > up in recently created files in 2.4.0-test11?

> > > Mmmm. Yes. I think the final fixes for this went into
> > > v2.4.0-test12pre5, but since there's a test13-pre3 out that needs
> > > testing, go for that one directly... :^)

> > 2.4.0-test13-pre ate /usr/src at home (i686, RH7 + updates): Again,
> > files turn into directories, massive ammounts of duplicate blocks, ...
> > Not as bad as 2.4.0-test11 used to be (/ survived this time ;-)

> ext2, ext3 or reiserfs (or xfs or jfs or ...)

ext2.

> Still, this sounds bad to me. Have you reported this to Linus+Alexander
> Viro? Oh, never mind, I'm CC:ing them now.

Nope, didn't. Thanks!
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
