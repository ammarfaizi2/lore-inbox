Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWGJGUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWGJGUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 02:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbWGJGUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 02:20:38 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:57047 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161101AbWGJGUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 02:20:38 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Mon, 10 Jul 2006 16:20:30 +1000
User-Agent: KMail/1.9.1
Cc: Jason Lunz <lunz@falooley.org>, linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607100706.45789.ncunningham@linuxmail.org> <e8sj71$nad$1@sea.gmane.org>
In-Reply-To: <e8sj71$nad$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6704119.3iUQIIaDna";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607101620.34408.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6704119.3iUQIIaDna
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 10 July 2006 13:57, Jason Lunz wrote:
> ncunningham@linuxmail.org said:
> > If Suspend2 added code in a way that broke swsusp, I would agree. But
> > it=3D20 doesn't.
>
> That isn't true. I stopped using the suspend2 patches after they broke
> the in-kernel suspend twice in the last year, since 2.6.14 or so. (The
> first time I reported one of these bugs is here:
> http://article.gmane.org/gmane.linux.swsusp.general/3243)

The switch to using the swsusp lowlevel code was a bit bumpy, and I do admi=
t=20
that I broke swsusp from time to time, but these are the exceptions (as you=
=20
say), and the general design is such that they should be coexist. I'll free=
ly=20
admit that I don't regularly test swsusp, but I'm also not reguarly changin=
g=20
things that should break it.

> Before I stopped using suspend2, there was a 6-8 month period where I
> could easily use both in-kernel swsusp and suspend2 on my laptop. I kept
> using suspend2 because it was faster, but I eventually stopped because
> it locked up the machine during suspend or crashed it during resume on
> one out of every 20-30 tries (and the crashes weren't in some driver
> - the backtrace always pointed down into the guts of suspend code).

Did you report them to the list? I try to be responsive (although, again, I=
=20
don't always succeed to the extent that I'd like.

> In-kernel swsusp, on the other hand, aside from being slower, has never
> crashed or frozen the machine. The same is true of the new uswsusp code,
> which i'd say subjectively feels nearly as fast as suspend2 was, with
> both using lzf compression.

Yeah, being much simpler does have its advantages, and Rafael has done a go=
od=20
job with the uswsusp code. Hopefully I'll get to test it properly soon.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart6704119.3iUQIIaDna
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsfGyN0y+n1M3mo0RArXNAJ9kym2EOEXsMtwS9i3ZDvKW5HIIZQCgsaii
8hwN9tPOk3VPLakbhdnPgo4=
=IxjM
-----END PGP SIGNATURE-----

--nextPart6704119.3iUQIIaDna--
