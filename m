Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284911AbRLKGz5>; Tue, 11 Dec 2001 01:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284914AbRLKGzq>; Tue, 11 Dec 2001 01:55:46 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:11939 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S284913AbRLKGzg>;
	Tue, 11 Dec 2001 01:55:36 -0500
Date: Tue, 11 Dec 2001 07:55:30 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Justin Hibbits <jrh29@po.cwru.edu>"@opus.INS.cwru.edu
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Exporting GPLONLY symbols (Please CC to my email address)
Message-ID: <20011211075530.O360@khan.acc.umu.se>
In-Reply-To: <20011210224156.E14022@po.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011210224156.E14022@po.cwru.edu>; from "Justin Hibbits <jrh29@po.cwru.edu>"@opus.INS.cwru.edu on Mon, Dec 10, 2001 at 10:41:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 10:41:56PM -0500, "Justin Hibbits <jrh29@po.cwru.edu>"@opus.INS.cwru.edu wrote:
> Umm....I'm a new poster here to the list, but, nonetheless, I have a
> small complaint about the track the kernel is taking with respect to
> kernel modules, specifically the exporting of symbols as GPLONLY.  I
> understand that several hackers are pushing to export many symbols as
> GPLONLY, which I feel is a very bad idea.  The NVidia drivers will no
> longer work, and any other module which depends on symbols which will

The only thing that makes NVidia's drivers troublesome is that they
are stupid enough not to open-source it. It's their problem though; they
have to release fixed versions ever so often to keep up with the kernel.
They won't have any problems with GPLONLY symbols, however, as none of
the symbols they use are exported as GPLONLY.

> eventually be exported as GPLONLY will also no longer work.  Do you guys

Linus specifically stated that no old symbols were to be reexported as
GPLONLY; only new symbols would be eligible for this.

> really want to restrict everyone to using modules licensed under the
> GPL?  I've read and understand the GPL all too well, and came to the

Obviously you haven't.

> conclusion that it's a horrible license to begin with, given the simple
> fact that Stallman's communist views are in it, forcing everything

Huh? I find nothing communist about the GPL. Rather, it goes along
pretty well with my liberal views.

> licensed under it to be under every future license....with one change to
> the license, he can claim all source licensed under the GPL.

No, it doesn't, and he can't. The existance of newer versions of the GPL
does _NOT_ override the terms in code licensed with the older ones; you
simply get the _choice_ of which version to choose. In the Linux-kernel,
however, the default is that the v2 of the GPL is the only version
valid, unless specifically stated.

> I agree with Cox that something has to be done to warn the average user
> that inserting closed source modules might cause something bad, and you
> guys can't do anything about it, but FORCING all modules to become GPL

It doesn't.

> is the stupidest idea yet!  Linux is starting to take the road of M$,
> forcing a one-licensed approach.  Not cool guys.

Yeah, it's very not cool to release free software, for free use, to no
expense what-so-ever by you. Bitch all you like, but don't expect anyone
to take you seriously. If you're so bloody upset, fire up $EDITOR and
code your own kernel of choice.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
