Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131496AbRASMD6>; Fri, 19 Jan 2001 07:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131567AbRASMDr>; Fri, 19 Jan 2001 07:03:47 -0500
Received: from tabaluga.ipe.uni-stuttgart.de ([129.69.22.180]:45835 "EHLO
	tabaluga.ipe.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S131496AbRASMDc>; Fri, 19 Jan 2001 07:03:32 -0500
From: Nils Rennebarth <nils@ipe.uni-stuttgart.de>
Date: Fri, 19 Jan 2001 13:02:16 +0100
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: More filesystem corruption under 2.4.1-pre8 and SW Raid5
Message-ID: <20010119130216.M28575@ipe.uni-stuttgart.de>
Mail-Followup-To: nils, Holger Kiehl <Holger.Kiehl@dwd.de>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A68226D.4FDEFB7B@colorfullife.com> <Pine.LNX.4.30.0101191222170.28348-100000@talentix.dwd.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="skNneT8yDpR3Aw11"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101191222170.28348-100000@talentix.dwd.de>; from Holger.Kiehl@dwd.de on Fri, Jan 19, 2001 at 12:36:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--skNneT8yDpR3Aw11
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 19, 2001 at 12:36:33PM +0100, Holger Kiehl wrote:
> Would reiserfs be better and does it now work with SW Raid5?
It appears to not work with SW raid5 currently. But I suspect this is the
fault of raid5. I got fs corruption too, some files unreadable, odd sizes in
the terabyte range for single files, etc. Some of the corruption goes away
on reboot, so it is vm related.


Nils

--
*New* *New* *New*    - on shellac records
   Windows HE        - see top 10 reasons to downgrade on
Historical Edition     http://www.microsoft.com/windowshe

--skNneT8yDpR3Aw11
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6aCzIqgAZ+sZlgs4RAmN6AKCeKdWjWX61d9eeprnytTmcqXiBmQCfZRMD
dsOCFbwv/dVWaV8zJPHAnmc=
=ZPfo
-----END PGP SIGNATURE-----

--skNneT8yDpR3Aw11--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
