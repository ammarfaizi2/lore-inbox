Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932964AbWF2Vys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbWF2Vys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbWF2VyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:54:07 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:13867 "EHLO
	damned.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S932955AbWF2Vxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:53:53 -0400
From: Hamish <hamish@travellingkiwi.com>
Organization: TravellingKiwi Systems
To: linux-kernel@vger.kernel.org
Subject: Re: SATA hangs...
Date: Thu, 29 Jun 2006 22:53:46 +0100
User-Agent: KMail/1.9.1
References: <200606232134.42231.hamish@travellingkiwi.com> <20060624100957.73fff572@localhost> <200606242330.48248.hamish@travellingkiwi.com>
In-Reply-To: <200606242330.48248.hamish@travellingkiwi.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3243964.Abg2gdrLgO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606292253.50409.hamish@travellingkiwi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3243964.Abg2gdrLgO
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 24 June 2006 23:30, you wrote:
> On Saturday 24 June 2006 09:09, you wrote:
> > On Sat, 24 Jun 2006 09:36:59 +0200
> >
> > Paolo Ornati <ornati@fastwebnet.it> wrote:
> > > > > I'm having problems with a SATA drive on an ASUS A8V deluxe
> > > > > motherboard under kernel 2.6.17... In fact it's happened under
> > > > > every (Vanilla) kernel I've ever run on this server (Back to
> > > > > 2.6.14). (It's just over a year old. It didn't used to experience
> > > > > the same load as it does now, so I'm currently assuming it's load
> > > > > related...
> > >
> > > I think I've hit something similar yesterday, with 2.6.17.1...
> >
> > I was thinking that I've recently enabled CONFIG_PREEMPT (usually I
> > was just using CONFIG_PREEMPT_VOLUNTARY).
> >
> > Maybe is totally unrelated but... for Hamish: what is/was your PREEMPT
> > config?
>
> Hmm...
>
> damned stats # gzip -dc /proc/config.gz |grep -i preempt
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=3Dy
> CONFIG_PREEMPT_BKL=3Dy
> CONFIG_DEBUG_PREEMPT=3Dy
> damned stats #
>
> I also tried 2.6.17-mm but that dies in reiserfs claiming a bug in bitmap=
=2Ec
>
> I'll try a re-compile of 2.7.17.1 vanilla with no pre-empt & see how it
> goes.
>

Well, I turned off pre-empt, and haven't struck a problem since in almost a=
=20
week.

H

--nextPart3243964.Abg2gdrLgO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEpEvuwRzSEdQQDooRAuvgAKCMm3/tHTopeaEq1DSl9PZIe2/XZACgnChv
XYsMkwItZ17eNCfUPU6ooWo=
=vpeK
-----END PGP SIGNATURE-----

--nextPart3243964.Abg2gdrLgO--
