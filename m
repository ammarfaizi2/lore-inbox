Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130871AbQLUOhI>; Thu, 21 Dec 2000 09:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131085AbQLUOg5>; Thu, 21 Dec 2000 09:36:57 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:25850 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S130871AbQLUOgy>; Thu, 21 Dec 2000 09:36:54 -0500
Date: Thu, 21 Dec 2000 15:06:11 +0100
From: David Weinehall <tao@acc.umu.se>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: fs corruption in 2.4.0-test11?
Message-ID: <20001221150611.B15178@khan.acc.umu.se>
In-Reply-To: <tao@acc.umu.se> <200012211331.eBLDVuc01895@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200012211331.eBLDVuc01895@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Thu, Dec 21, 2000 at 10:31:56AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 10:31:56AM -0300, Horst von Brand wrote:
> David Weinehall <tao@acc.umu.se> said:
> > On Wed, Dec 20, 2000 at 04:47:42PM -0800, Larry McVoy wrote:
> > > I just need a sanity check - do other pages/blocks sometimes show
> > > up in recently created files in 2.4.0-test11?
> 
> > Mmmm. Yes. I think the final fixes for this went into
> > v2.4.0-test12pre5, but since there's a test13-pre3 out that needs
> > testing, go for that one directly... :^)
> 
> 2.4.0-test13-pre ate /usr/src at home (i686, RH7 + updates): Again,
> files turn into directories, massive ammounts of duplicate blocks, ...
> Not as bad as 2.4.0-test11 used to be (/ survived this time ;-)

ext2, ext3 or reiserfs (or xfs or jfs or ...)

Still, this sounds bad to me. Have you reported this to Linus+Alexander
Viro? Oh, never mind, I'm CC:ing them now.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
