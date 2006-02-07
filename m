Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWBGDgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWBGDgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWBGDgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:36:12 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:47043 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964955AbWBGDgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:36:11 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 13:32:46 +1000
User-Agent: KMail/1.9.1
Cc: Jim Crilly <jim@why.dont.jablowme.net>, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060207030129.GA23860@mail> <1139282224.2041.48.camel@mindpipe>
In-Reply-To: <1139282224.2041.48.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1524544.mA8QjnQgrX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602071332.51676.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1524544.mA8QjnQgrX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 07 February 2006 13:17, Lee Revell wrote:
> On Mon, 2006-02-06 at 22:01 -0500, Jim Crilly wrote:
> > With uswsusp it'll be more flexible in that you'll be able to use any
> > userland process or library to transform the image before storing it,
> > but the suspend and resume processes are going to be a lot more
> > complicated. For instance, how are you going to tell the kernel that
> > you need the uswsusp UI binary, /bin/gzip and /usr/bin/gpg to run
> > after the rest of userland has been frozen?
>
> Unless someone at least gives a rough estimate of 1) what % of users
> can't suspend their laptops now and 2) of these, what % are helped by
> suspend2, this thread is just handwaving...

Percentages would be pure guesswork, but I do have _some_ numbers.

=46or (1), I have no idea. Furthermore, I would think that if a user can=20
suspend with Suspend2, they should be able to suspend with swsusp. There=20
were 2 driver related patches I had that swsusp doesn't, with I sent to=20
Andrew and to John Stultz this morning for consideration. The one sent to=20
Andrew might make some people be able to suspend with Suspend2 who=20
couldn't with swsusp, but I couldn't see how the timer related one I sent=20
to John could make a difference (so I asked for his evaluation). Given=20
that the right thing happens with them, I guess merging Suspend2 should=20
make virtually zero difference to whatever the answer might be to #1.

Now to #2.I haven't seen download statistics for Suspend2 since last May.=20
At that time, we had a release that was current for about 3 months. During=
=20
that time, there were 12,000 downloads of the version (2.1.8 IIRC). Let's=20
say that half of them actually applied the software and used it. Does 6000=
=20
people make it worth it? Of course, having said that, I don't know how=20
many people would be more likely to use it if it was in mainline and they=20
didn't have to patch their kernels, but I'd suspect it would be at least=20
that number again.

Hope that helps.

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1524544.mA8QjnQgrX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6BTjN0y+n1M3mo0RArZ4AJwPzc/XV2nOfqlYohqvUFKqxUfWNQCcCRGb
qIsSzc0y83TS0QDozPwaNgQ=
=Slfb
-----END PGP SIGNATURE-----

--nextPart1524544.mA8QjnQgrX--
