Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUJ0VRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUJ0VRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbUJ0VNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:13:41 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:26854 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262728AbUJ0VIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:08:52 -0400
Message-ID: <41800E5A.9060502@comcast.net>
Date: Wed, 27 Oct 2004 17:08:42 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
CC: "Theodore Ts'o" <tytso@mit.edu>,
       William Lee Irwin III <wli@holomorphy.com>,
       Willy Tarreau <willy@w.ods.org>, Rik van Riel <riel@redhat.com>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
References: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt> <Pine.LNX.4.44.0410270027110.21548-100000@chimarrao.boston.redhat.com> <20041027051342.GK19761@alpha.home.local> <20041027052321.GT15367@holomorphy.com> <417FA711.90700@comcast.net> <20041027145743.GA16666@thunk.org> <417FC02C.3090001@comcast.net> <Pine.LNX.4.61.0410272043080.11962@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.61.0410272043080.11962@student.dei.uc.pt>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Marcos D. Marado Torres wrote:
| On Wed, 27 Oct 2004, John Richard Moser wrote:
|
|>> What I *am* aiming for is getting a few security enhancements included
|>> in mainline for several Linux distributions, starting with Debian and
|>> Ubuntu.  This will predictibly create a blockage at 2.6.7 (where
|>> PaX/GRSec are, since those are a major part of the scheme); they won't
|>> be able to upgrade past there without losing a major protection, and the
|>> authors will likely continue to simply sit around and wait for 2.6 to
|>> stop changing so damn much.
|
|
| Well, if your target is Debian and Ubunto for starts, then you're
| discussing
| this in the wrong mailing list.
| BTW, on Debian/unstable:

[...]

| If you think the blockage is going to happen in 2.6.7, think twice.
|

That's where the stuff I want put in is.

http://lwn.net/Articles/106214/
http://d-sbd.alioth.debian.org/
http://pax.grsecurity.net/
http://grsecurity.net/
http://en.wikipedia.org/wiki/PaX

PaX sits currently at 2.6.7 (and grsec is tied to PaX quite deeply, so
it sits there as well), so there's no using that for now past 2.6.7.
I've heard rumors of it getting some up-porting after a new component is
properly done (recall my assertions about having to chose between
chasing mainline and doing real work), but it's up to the PaX Team if
they want to do that or if they're just going to wait for a fork 2.6/2.7.


| Mind Booster Noori
|
| -- /* *************************************************************** */
|    Marcos Daniel Marado Torres         AKA    Mind Booster Noori
|    http://student.dei.uc.pt/~marado   -      marado@student.dei.uc.pt
|    () Join the ASCII ribbon campaign against html email, Microsoft
|    /\ attachments and Software patents.   They endanger the World.
|    Sign a petition against patents:  http://petition.eurolinux.org
| /* *************************************************************** */

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBgA5YhDd4aOud5P8RAlDjAJ9yGRcCPbIaTDhGcWX8eZEBncph1wCfTHAD
ZPHADIODR3WP4DrRWV2YwlQ=
=V8OU
-----END PGP SIGNATURE-----
