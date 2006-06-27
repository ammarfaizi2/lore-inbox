Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWF0XsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWF0XsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbWF0XsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:48:08 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:28855 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1422734AbWF0XsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:48:07 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Wed, 28 Jun 2006 09:47:55 +1000
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271935.13261.nigel@suspend2.net> <200606280019.32045.rjw@sisk.pl>
In-Reply-To: <200606280019.32045.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2107915.YBcqhnRpc7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606280947.58916.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2107915.YBcqhnRpc7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 28 June 2006 08:19, Rafael J. Wysocki wrote:
> Hi,
>
> On Tuesday 27 June 2006 11:35, Nigel Cunningham wrote:
> > On Tuesday 27 June 2006 19:26, Rafael J. Wysocki wrote:
> > > > > Now I haven't followed the suspend2 vs swsusp debate very closely,
> > > > > but it seems to me that your biggest problem with getting this
> > > > > merged is getting consensus on where exactly this is going. Nobody
> > > > > wants two different suspend modules in the kernel. So there are t=
wo
> > > > > options - suspend2 is deemed the way to go, and it gets merged and
> > > > > replaces swsusp. Or the other way around - people like swsusp mor=
e,
> > > > > and you are doomed to maintain suspend2 outside the tree.
> > > >
> > > > Generally, I agree, although my understanding of Rafael and Pavel's
> > > > mindset is that swsusp is a dead dog and uswsusp is the way they wa=
nt
> > > > to see things go. swsusp is only staying for backwards compatabilit=
y.
> > > > If that's the case, perhaps we can just replace swsusp with Suspend2
> > > > and let them have their existing interface for uswsusp. Still not
> > > > ideal, I agree, but it would be progress.
> > >
> > > Well, ususpend needs some core functionality to be provided by the
> > > kernel, like freezing/thawing processes (this is also used by the STR=
),
> > > snapshotting the system memory.  These should be shared with the
> > > in-kernel suspend, be it swsusp or suspend2.
> >
> > If I modify suspend2 so that from now on it replaces swsusp, using
> > noresume, resume=3D and echo disk > /sys/power/state in a way that's
> > backward compatible with swsusp and doesn't interfere with uswsusp
> > support, would you be happy? IIRC, Pavel has said in the past he wishes
> > I'd just do that, but he's not you of course.
>
> That depends on how it's done.  For sure, I wouldn't like it to be done in
> the "everything at once" manner.

I'm not sure I get what you're saying. Do you mean you'd prefer them to=20
coexist for a time in mainline? If so, I'd point out that suspend2 uses=20
different parameters at the moment precisely so they can coexist, so that=20
wouldn't be any change.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2107915.YBcqhnRpc7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEocOuN0y+n1M3mo0RAipNAKDKBoMt/ja9DvbiNfY/PziNGpOokACgzisz
qn9OSACV5Pl2V5kfUBTceiQ=
=sMGs
-----END PGP SIGNATURE-----

--nextPart2107915.YBcqhnRpc7--
