Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270582AbRHNLwe>; Tue, 14 Aug 2001 07:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270577AbRHNLvw>; Tue, 14 Aug 2001 07:51:52 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:2564 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270581AbRHNLv1>; Tue, 14 Aug 2001 07:51:27 -0400
Date: Sat, 11 Aug 2001 01:16:18 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>, Bulent Abali <abali@us.ibm.com>,
        "Dirk W. Steinberg" <dws@dirksteinberg.de>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Swapping for diskless nodes
Message-ID: <20010811011617.D55@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33L.0108091756420.1439-100000@duckman.distro.conectiva> <E15UyZR-0008IH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15UyZR-0008IH-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 09, 2001 at 11:46:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ultimately its an insoluble problem, neither SunOS, Solaris or
> > > NetBSD are infallible, they just never fail for any normal
> > > situation, and thats good enough for me as a solution
> > 
> > Memory reservations, with reservations on a per-socket
> > basis, can fix the problem.
> 
> Only a probabalistic subset of the problem. But yes enough to make it "work"
> except where mathematicians and crazy people are concerned. Do not NFS swap
> on a BGP4 router with no fixed route to the server..

That's cleaar misconfiguration. Similar misconfiguration to

a# mount b:/xyzzy /bar
b# mount a:/xyzzy /foo

. Similar misconfiguration to a nbd-swap-on b, b nbd-swap-on c, and c rely
on a for its routing.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

