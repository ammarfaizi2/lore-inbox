Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKOUet>; Wed, 15 Nov 2000 15:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKOUeh>; Wed, 15 Nov 2000 15:34:37 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:33970 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129091AbQKOUeV>; Wed, 15 Nov 2000 15:34:21 -0500
Date: Wed, 15 Nov 2000 15:05:41 -0500 (EST)
From: Scott Murray <scott@spiteful.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: test11-pre5 breaks vmware
In-Reply-To: <CF021B54DF0@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.21.0011151454590.10690-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000, Petr Vandrovec wrote:

> On 15 Nov 00 at 1:59, Tigran Aivazian wrote:
> 
> > You probably noticed this already but I just wanted to bring it to your
> > attention that /usr/bin/vmware-config.pl script needs updating since the
> > flags in /proc/cpuinfo is now called "features" so it otherwise fails
> > complaining that my 2xP6 has no tsc. Trivial change but still worthy of
> > propagating into your latest .tar.gz file for 2.4.x
> 
> Oh. I did not compiled 11-test5, as G450 finally arrived ;-) OK,
> I'll release patch for vmware, as I cannot stop kernel developers
> from changing field names :-)

Actually, I know of at least one other shipping commercial product
(Sitraka's JProbe Java Profiler) that will require patching because of
this change.  It seems unwise to be changing field names in commonly
used /proc files like cpuinfo at this point in time.

Scott


-- 
=============================================================================
Scott Murray                                        email: scott@spiteful.org
http://www.interlog.com/~scottm                       ICQ: 10602428
-----------------------------------------------------------------------------
     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
