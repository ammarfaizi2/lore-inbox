Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWBGD3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWBGD3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWBGD3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:29:33 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:21409 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964948AbWBGD3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:29:32 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 13:26:07 +1000
User-Agent: KMail/1.9.1
Cc: Jim Crilly <jim@why.dont.jablowme.net>, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060207030129.GA23860@mail> <1139282017.2041.44.camel@mindpipe>
In-Reply-To: <1139282017.2041.44.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart113937817.n2FJx7RDkt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602071326.11885.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart113937817.n2FJx7RDkt
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 07 February 2006 13:13, Lee Revell wrote:
> On Mon, 2006-02-06 at 22:01 -0500, Jim Crilly wrote:
> > On 02/06/06 08:19:02PM -0500, Lee Revell wrote:
> > > On Mon, 2006-02-06 at 19:59 -0500, Jim Crilly wrote:
> > > > I guess reasonable is a subjective term. For instance, I've seen
> > > > quite a few people vehemently against adding new ioctls to the
> > > > kernel and yet you'll be adding quite a few for /dev/snapshot. I'm
> > > > just of the same mind as Nigel in that it makes the most sense to
> > > > me that the majority of the suspend/hibernation process to be in
> > > > the kernel.
> > >
> > > No one is saying that ANY new ioctls are bad, just that the KISS
> > > principle of engineering dictates that it's bad design to use ioctls
> > > where a simple read/write to a sysfs file will do.
> >
> > I understand that, but shouldn't the KISS principle also be applied to
> > the user interface of a feature?
>
> Personally I agree with you on suspend2, I think this is something that
> needed to Just Work yesterday, and every day it doesn't work we are
> losing users... but who am I to talk, I'm not the one who will have to
> maintain it.

Well, I will have to maintain it, and I'm perfectly willing to. I only=20
started to work on it in the first place because I wanted to use it, so I=20
have a vested interest in keeping it working. So... even if we end up=20
pulling it out in place of a userspace solution, I really like the idea of=
=20
putting it in at least until uswsusp is up to speed (provided it didn't=20
given Andrew and/or Linus a hernia in the process).

To avoid the backwards compatability issues, we can plan ahead now,=20
defining something like I suggested in another email earlier in the day.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart113937817.n2FJx7RDkt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6BNTN0y+n1M3mo0RAsowAJ9tU37cvguUBV5lXuuwQRmgypYgnACfSF4N
mPWEN994khE1FlEMk1dRC7k=
=KsqL
-----END PGP SIGNATURE-----

--nextPart113937817.n2FJx7RDkt--
