Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWBVAg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWBVAg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWBVAgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:36:25 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:2210 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1422641AbWBVAgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:36:24 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Andreas Happe <andreashappe@snikt.net>
Subject: Re: Which is simpler? (Was Re: Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 22 Feb 2006 10:33:25 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602211257.29161.ncunningham@cyclades.com> <slrndvm3kp.rev.andreashappe@localhost.localdomain>
In-Reply-To: <slrndvm3kp.rev.andreashappe@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3454216.OpH2ghY7IW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602221033.29340.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3454216.OpH2ghY7IW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 21 February 2006 22:59, Andreas Happe wrote:
> On 2006-02-21, Nigel Cunningham <ncunningham@cyclades.com> wrote:
> > On Tuesday 21 February 2006 10:52, Andreas Happe wrote:
> >> I tried to use suspend2, but setup wasn't that great (i.e. didn't
> >> work as well or easy as swsusp) so I dropped it.
> >
> > Could you provide more detail? If there's something I can do to make
> > it eas=3D ier=3D20 to use, I'm more than willing to consider that.
>
> it's way too long ago to remember specifics, the system didn't resume
> after suspending. Swsusp worked just out of the box (sans dri support
> after resuming) without the need to apply a patch (which wasn't supplied
> as normal patch (if i remember correctly) but was used by starting a
> script)). I'm sorry that I didn't submit a proper bug report, but the
> alternative worked for me.

Ok. That was when I provided multiple patches - they're all combined now. T=
he=20
script is still there, but just to make applying easier for newbies.

> You can't make it simpler except you get in included into mainline (even
> by making compromises).

Agreed.

> > 12 bytes per page is 3MB/1GB. If swsusp was to add support for
> > multiple swap partitions or writing to files, those requirement 20
> > might be closer to 5MB/GB. Bitmaps, in comparison, use ~32K/GB (approx
> > because it depends whether the gigabyte is all in one zone).
> > Proportionally ,20 bitmaps are eating a lot less space out of your
> > gigabyte, but I don't think anyone is going to notice that they have 3
> > or 4MB more cache per gigabyte with Suspend2 than they have with
> > swsusp).
>
> This would take suspend2 a step closer to mainline.. you'll have a very
> honest 'Thank You' if that could happen..

Well, we'll see what Rafael and I can work out.

Regards,

Nigel

> andy
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--nextPart3454216.OpH2ghY7IW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+7FZN0y+n1M3mo0RAuQTAJ4qXOf740g1c1Ig6XtsHFGrFCfueACeK9lU
XxldGVEnMjKiRHOxXyV0rnI=
=BrwJ
-----END PGP SIGNATURE-----

--nextPart3454216.OpH2ghY7IW--
