Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbSKCChi>; Sat, 2 Nov 2002 21:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261566AbSKCChi>; Sat, 2 Nov 2002 21:37:38 -0500
Received: from almesberger.net ([63.105.73.239]:57096 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261565AbSKCChh>; Sat, 2 Nov 2002 21:37:37 -0500
Date: Sat, 2 Nov 2002 23:43:44 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021102234344.I2599@almesberger.net>
References: <Pine.LNX.4.44.0211021619580.2221-100000@home.transmeta.com> <1036286840.18289.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036286840.18289.2.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Nov 03, 2002 at 01:27:20AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> anywhere near it. One thing Unix actually got right from the beginning
> is that rights belong to objects not to names. Name based labelling has
> never worked in or out of computing.

I think the most important aspects are always that the concept is
understandable, doesn't make the users to jump through hoops, and
doesn't violate the principle of least surprise too often.

> What you are suggesting is the equivalent of marking documents 'secret'
> by putting them in a specific drawer and hoping nobody ever misfiles it.
> Everyone instead writes "secret" on the document - guess why

This happens if you have a design that is based on taking away
privileges/rights/capabilities/power/whatever. If the "naked"
object has no special powers, misfiling it does no damage at all.

Of course, you want to make sure nothing else can be slipped into
that magic drawer. Just imagine somebody takes the GPL from The
Drawer of World Domination, and puts the Windows EULA there :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
