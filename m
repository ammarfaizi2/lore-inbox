Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTDXOPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263668AbTDXOPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:15:53 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:58122 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263462AbTDXOPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:15:52 -0400
Date: Thu, 24 Apr 2003 10:21:08 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: Re: [Bug 622] New: ALSA Choppy During Thing Like Window Changes
In-reply-to: <1051135300.652.11.camel@teapot.felipe-alfaro.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <20030424142108.GB11116@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=bCsyhTFzCvuiizWE;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <21270000.1051112116@[10.10.2.4]>
 <1051135300.652.11.camel@teapot.felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2003 at 12:01:40AM +0200, Felipe Alfaro Solana wrote:
> Uhmm... Maybe a problem with the backboost interactivity enhancements.
> Does this happen with command-line apps like mpg123, mpg321, ogg123,
> etc? In my case, I've experienced those "sound skips" when using XMMS,
> but not mpg123 or ogg123. I think it's both a "corner-case" problem with
> the interactivity changes in the 2.5-series scheduler and XMMS itself.

i started seeing the problem a couple kernels back (maybe .65) when
there was a bit of noise on the list about scheduler changes.  i
usually run gqmpeg -> (mpg123|ogg123) -> esd -> alsa (maestro3).

i can reproduce it with just ogg123 -> alsa, but it's not as easy.
ogg123 -> esd -> alsa does it more.

i never had issues with this in the kernels before (< 2.5.65 or so).

here's a link to my original note back then:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D104818963700788&w=3D2

i liked the boost in java performance ;), but it's come at a price
that is quite annoying (sound skips).  though, the extreme performance
of my jboss server went away in the 2.5.66, and the sound got a little
better, but it's still pretty bad.

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+p/LUCGPRljI8080RAjCUAJ9J91QDZ87m6vvLKsjAK69ZJOCg7gCgiucM
3Uq9q/nf68sTZsLZXr6NS04=
=mTDC
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
