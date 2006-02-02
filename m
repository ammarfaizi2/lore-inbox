Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWBBVbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWBBVbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWBBVbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:31:33 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:39082 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932275AbWBBVbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:31:18 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Fri, 3 Feb 2006 07:27:54 +1000
User-Agent: KMail/1.9.1
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602021922.11100.nigel@suspend2.net> <200602021434.33660.rjw@sisk.pl>
In-Reply-To: <200602021434.33660.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2181188.r1zrcULpOU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602030727.58153.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2181188.r1zrcULpOU
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 23:34, Rafael J. Wysocki wrote:
> > > First, your code introduces many changes in many parts of the kernel,
> > > so to merge it you'll have to ask many people for acceptance.
> >
> > I really must work harder to get rid of that perception. It used to be
> > the case, but isn't nowadays. Just about all of suspend2's changes are
> > new files in kernel/power and include/<arch>/suspend2.h. The remainder
> > are misc fixes, and enhancements like Christoph's todo list.
>
> Well, in your previous series of patches there are examples to the
> contrary, like the changes to kthread_create() or workqueues.  They would
> require an ack from the maintainers of that code, at least.

That's not Suspend2 itself, but rather improvements to the freezer that are=
=20
logically distinct and would be useful to swsusp too. That said, if the wor=
k=20
you guys have done in the last couple of days gets merged, perhaps I'll dro=
p=20
most of it and just do the bdev freezing instead of sys_syncing, at least t=
o=20
check reliability.

> Also, you probably need some changes in the arch code.  If that is so, the
> maintainers of relevant architectures should be asked.
>
> That already is "many".

No. I have a little cleaning up still to do there, but the current arch=20
specific patches are all: 1) adding suspend2.h; 2) old modifications that c=
an=20
be cleaned up 3) the odd new routine (eg a page_is_ram function for amd64).

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2181188.r1zrcULpOU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4nleN0y+n1M3mo0RAmQfAKDbyR7GhKazG8b6jOGVBAruXml4YACfX6Qg
0NnnxfrCeP/o19hdn9Wrpg4=
=mRZU
-----END PGP SIGNATURE-----

--nextPart2181188.r1zrcULpOU--
