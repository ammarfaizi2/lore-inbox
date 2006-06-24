Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWFXWbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWFXWbG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 18:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWFXWbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 18:31:06 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:5043 "EHLO
	damned.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S1751111AbWFXWbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 18:31:03 -0400
From: Hamish <hamish@travellingkiwi.com>
Organization: TravellingKiwi Systems
To: Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org
Subject: Re: SATA hangs...
Date: Sat, 24 Jun 2006 23:30:43 +0100
User-Agent: KMail/1.9.1
References: <200606232134.42231.hamish@travellingkiwi.com> <20060624093659.7bc2a4a0@localhost> <20060624100957.73fff572@localhost>
In-Reply-To: <20060624100957.73fff572@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1163088.7CRPIQfnfP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606242330.48248.hamish@travellingkiwi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1163088.7CRPIQfnfP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 24 June 2006 09:09, you wrote:
> On Sat, 24 Jun 2006 09:36:59 +0200
>
> Paolo Ornati <ornati@fastwebnet.it> wrote:
> > > > I'm having problems with a SATA drive on an ASUS A8V deluxe
> > > > motherboard under kernel 2.6.17... In fact it's happened under
> > > > every (Vanilla) kernel I've ever run on this server (Back to 2.6.14=
).
> > > > (It's just over a year old. It didn't used to experience the same
> > > > load as it does now, so I'm currently assuming it's load related...
> >
> > I think I've hit something similar yesterday, with 2.6.17.1...
>
> I was thinking that I've recently enabled CONFIG_PREEMPT (usually I
> was just using CONFIG_PREEMPT_VOLUNTARY).
>
> Maybe is totally unrelated but... for Hamish: what is/was your PREEMPT
> config?

Hmm...=20

damned stats # gzip -dc /proc/config.gz |grep -i preempt
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_BKL=3Dy
CONFIG_DEBUG_PREEMPT=3Dy
damned stats #=20

I also tried 2.6.17-mm but that dies in reiserfs claiming a bug in bitmap.c

I'll try a re-compile of 2.7.17.1 vanilla with no pre-empt & see how it goe=
s.

H

--nextPart1163088.7CRPIQfnfP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEnb0YwRzSEdQQDooRAmBYAKCzlBR31ZRVmZQuj3zju4kskvH3+QCfZJe5
GFpK+tBtubc2A1RtDRwE37U=
=ILRW
-----END PGP SIGNATURE-----

--nextPart1163088.7CRPIQfnfP--
