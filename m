Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264869AbSJ3VqD>; Wed, 30 Oct 2002 16:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSJ3VqD>; Wed, 30 Oct 2002 16:46:03 -0500
Received: from marc1.theaimsgroup.com ([63.238.77.171]:1553 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S264869AbSJ3VqC>; Wed, 30 Oct 2002 16:46:02 -0500
Date: Wed, 30 Oct 2002 16:54:14 -0500 (EST)
From: hlein@progressive-comp.com
X-X-Sender: hlein@progressive-comp.com
To: linux-kernel@vger.kernel.org
Subject: [OT] Re: ARGH!  (Is there an HTML archive for linux-kernel that
 patches work from?)
In-Reply-To: <200210280434.g9S4Ygh13812@marc2.theaimsgroup.com>
Message-ID: <010210301643290.19866-100000@timmy.spinoli.org>
X-Marks-The: Spot
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 27 Oct 2002, Hank Leininger wrote:

> high on my priority list :-P  Please do let us know (me directly, or
> webguy@theaimsgroup.com) if you find other mails that have been truncated
> at shorter than this, I'll look into it.

Thanks to Nicholas Wourms and a few others, it has been confirmed that
I am, in fact, an idiot (for some, there was never any doubt...).

Somewhere along the way the message bodies stored in MARC got assigned a
64kb max size.  So messages were indeed truncated at 65,535 bytes.
That's fixed.  Out of 3.1 million mails MARC got in 2002, 7,184 had been
silently truncated.  I've identified and fixed from backups the majority
of those (and 2001 as well); there are still some 1,387 mails from 2002
which appear truncated.  So we're down from 0.23% bad data to 0.04%.  I
believe the majority of those are from bulk inserts I've done of new
lists added this year, so lists like linux-kernel which we've carried
forever should be at or near 100%.  And of course, all new incoming mail
should be fine, up to about 1MB.

So.  *Now* please let me know if you find any mails to linux-kernel or
others that appear to have been truncated or otherwise damaged. ;)

Thanks,

Hank Leininger <hlein@progressive-comp.com>
E407 AEF4 761E D39C D401  D4F4 22F8 EF11 861A A6F1
"This house... is clean."

-----BEGIN PGP SIGNATURE-----

iD8DBQE9wFUOIvjvEYYapvERAuCsAJ4+qG8cnG/WCkeB2kHzNAw68X1u3gCeNHQf
26+2zoHkJ1i1sy1wWunZVW0=
=SMQe
-----END PGP SIGNATURE-----


