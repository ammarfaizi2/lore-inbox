Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132810AbRASPtv>; Fri, 19 Jan 2001 10:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132811AbRASPtl>; Fri, 19 Jan 2001 10:49:41 -0500
Received: from host213-120-148-5.btopenworld.com ([213.120.148.5]:13160 "EHLO
	nvlonlx01.nv.london") by vger.kernel.org with ESMTP
	id <S132810AbRASPtZ>; Fri, 19 Jan 2001 10:49:25 -0500
Date: Fri, 19 Jan 2001 15:49:00 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Mo McKinlay <mmckinlay@gnu.org>, Peter Samuelson <peter@cadcamlab.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <3A6860F9.EC882411@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.30.0101191547210.2331-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Today, Michael Rothwell (rothwell@holly-springs.nc.us) wrote:

  > The filesystem, when registering that it supports the "named streams"
  > namespace, could specify its preferred delimiter to the VFS as well.
  > Ext4 could use /directory/file/stream, and NTFS could use
  > /directory/file:stream.

Erk - nice from a programming point of view, horrible from a consistency
one. The nice thing about VFS is that it provides a consistent abstract
interface - I'd place a small amount of money on the fact that Al Viro
would probably flame you to high heaven for that last suggestion if he was
paying much attention to this thread :-)

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpoYe4ACgkQRcGgB3aidfn2RQCfa1nnClzSXxBCB0XnJ35RmOcm
ysoAoJSg+USBkDCp4PKcX5iD0JQQvXw9
=Lkci
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
