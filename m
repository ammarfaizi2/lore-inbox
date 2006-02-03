Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWBCGxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWBCGxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 01:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWBCGxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 01:53:36 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:60845 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750961AbWBCGxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 01:53:36 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Olivier Galibert <galibert@pobox.com>,
       Olivier Galibert <galibert@pobox.com>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Fri, 3 Feb 2006 16:49:54 +1000
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       pavel@ucw.cz, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1138919381.15691.162.camel@mindpipe> <20060203014846.GA61221@dspnet.fr.eu.org>
In-Reply-To: <20060203014846.GA61221@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1274630.PnFXnxI4mx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602031649.59619.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1274630.PnFXnxI4mx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Oliver.

On Friday 03 February 2006 11:48, Olivier Galibert wrote:
> On Thu, Feb 02, 2006 at 05:29:40PM -0500, Lee Revell wrote:
> > Follow up - do we have a rough idea how bad the suspend problem is, like
> > approximately what % of laptops don't DTRT and just suspend when you
> > close the lid?
>
> None of the Dells we use at work (various models) handle suspend (both
> ram and disk) reliably.  Got everything from not resuming when pushing
> the button (PWRF not giving an ACPI event while PWRC does), screen not
> coming back (as usual), system not coming back the second time (go
> figure) or resume eating up / from time to time.  At that point people
> there are buying Macs.

Not coming back the second time usually means it staggers through the first=
=20
dazed and confused, but not badly enough so that you notice. The second=20
attempt kills it. In this case, I'd go looking for something that plays up=
=20
after the first resume. You might also try some of the hints on the suspend=
2=20
web site, such as trying from init S with minimal modules loaded. (If that=
=20
works, you know it's something loaded later in the boot process that messes=
=20
things up).

> I'm going to get a sacrificial (but modern) dell laptop in a month or
> two.  I'll try to make things actually reliable on that one, including
> video.  I don't have great hopes though.

If you can't get it to go, try the suspend2 mailing list. I try to be as=20
helpful as I can, and there are tons of users on there with good suggestion=
s=20
and experience you can make use of as well.

> 'course the current state of the drm/fb interaction is yet another can
> of worms, one in a good way of being solved though.

Yes. You'll have much better success without DRI in the picture.

Regards,

Nigel

>   OG.
>
> [1] Reverse engineering is one of my hobbies
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1274630.PnFXnxI4mx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4v0XN0y+n1M3mo0RApZeAKDDWQMaihaZqh5eaRqXPkrwXkUc4gCg9Es+
KGgkgWavTOER2vIF5JzrdLs=
=Vs8P
-----END PGP SIGNATURE-----

--nextPart1274630.PnFXnxI4mx--
