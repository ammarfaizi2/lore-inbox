Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVCCRNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVCCRNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVCCRND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:13:03 -0500
Received: from ylpvm25-ext.prodigy.net ([207.115.57.56]:12510 "EHLO
	ylpvm25.prodigy.net") by vger.kernel.org with ESMTP id S262355AbVCCRJ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:09:26 -0500
Message-ID: <422743AB.9020403@ecs.fullerton.edu>
Date: Thu, 03 Mar 2005 09:04:43 -0800
From: Eric Gaumer <gaumerel@ecs.fullerton.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050117)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <20050303164353.GE10761@kroah.com>
In-Reply-To: <20050303164353.GE10761@kroah.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig516FE023CF86D0D01607BE35"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig516FE023CF86D0D01607BE35
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Thu, Mar 03, 2005 at 08:23:39AM -0800, Linus Torvalds wrote:
>
>>So what's the problem with this approach? It would seem to make everybody
>>happy: it would reduce my load, it would give people the alternate "2.6.x
>>base kernel plus fixes only" parallell track, and it would _not_ have the
>>testability issue (because I think a lot of people would be happy to test
>>that tree, and if it was always based on the last 2.6.x release, there
>>would be no issues.
>>
>>Anybody?
>
>
> Well, I'm one person who has said that this would be a very tough
> problem to solve.  And hey, I like tough problems, so I'll volunteer to
> start this.  If I burn out, I'll take the responsibility of finding
> someone else to take it over.
>
> I really like the rules you've outlined, that makes it almost possible
> to achieve sanity.
>

How does what Linus outlined differ from splitting to 2.7? Isn't it the same thing with just
a different versioning scheme? In the end we have a stable 2.6 tree. What's the difference
between the 2.6 development tree and 2.7.

All that aside... why not make the "sucker tree" a breeding ground for new kernel hackers.
I've been trying to get more involved with kernel development (as are others) but it's tough
because things change so rapidly that once you finally figure it out, it has changed. As the
kernel matures into new versions it's getting much harder for guys coming out of school to
figure out. Sure you have that exceptional individual but maybe you're committing genocide
in the end.

If someone like Greg could lead this band of gypsies then that would be great. Most of the
more experienced hackers don't want to slow pace and do all this boring work but people like
myself would be honored to "pay our dues". We would feel free to ask some questions and see
a slower pace so we can learn. If patches are small and truly only fix bugs then wouldn't
you say this would be possible? In fact one criteria could be that if we can't understand
just what exactly the patch fixes then it probably doesn't belong in this tree? It's a win -
win situation. End users are happy and we start a semi-structured training camp.


--
"Education is what remains after one has forgotten everything he learned in school."
	- Albert Einstein

--------------enig516FE023CF86D0D01607BE35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCJ0OyZWL8hfFdQekRAsOlAJ9z1SnzYnQCJXx+vWjzzw9FZmQIaQCgpLiv
CmsuCCxr71vCHWD91K6saRc=
=aH7u
-----END PGP SIGNATURE-----

--------------enig516FE023CF86D0D01607BE35--
