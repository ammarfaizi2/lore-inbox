Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132103AbRASQfN>; Fri, 19 Jan 2001 11:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135541AbRASQe4>; Fri, 19 Jan 2001 11:34:56 -0500
Received: from host213-120-148-5.btopenworld.com ([213.120.148.5]:17515 "EHLO
	nvlonlx01.nv.london") by vger.kernel.org with ESMTP
	id <S135347AbRASQeX>; Fri, 19 Jan 2001 11:34:23 -0500
Date: Fri, 19 Jan 2001 16:33:51 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Mo McKinlay <mmckinlay@gnu.org>, Peter Samuelson <peter@cadcamlab.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <3A6867B1.C4818A70@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.30.0101191633200.2331-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Today, Michael Rothwell (rothwell@holly-springs.nc.us) wrote:

  > Mo McKinlay wrote:
  >
  > > Nono, that's not what I mean - each of the filesystems fails if it
  > > doesn't support what you're trying to do, that's given - but having a
  > > different delimeter registered by the filesystem (and hence the
  > > possibility of every single filesystem using a different delimeter) brings
  > > about a completely different kind of inconsistency.

  > True. Which is why I'd prefer a standard delimiter. ":" seems to be the
  > top candidate.

I would too, but POSIX won't let us unless we start enforcing side-effect
rules for all filesystems. Hence why I came up with openstream() :)

Mo.

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpobHEACgkQRcGgB3aidfnOyQCeNwj2WYbQd059F/JurCkcruED
cWEAoMO0P8eH3BAzpRkzcP3RkVDiEXOl
=siV3
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
