Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261503AbRERUCp>; Fri, 18 May 2001 16:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbRERUCf>; Fri, 18 May 2001 16:02:35 -0400
Received: from ulima.unil.ch ([130.223.144.143]:39430 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S261503AbRERUC2>;
	Fri, 18 May 2001 16:02:28 -0400
Date: Fri, 18 May 2001 22:02:23 +0200
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac10: Oops -> 2.4.4
Message-ID: <20010518220223.A23508@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010518200023.A22231@ulima.unil.ch> <E150pa7-0007XV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E150pa7-0007XV-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 18, 2001 at 08:06:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thus spake Alan Cox (alan@lxorguk.ukuu.org.uk):

> Can you boot a kernel without fdomain.c compiled in next

Yes, but I am too stupid: there were a faillure in my
patch-2.4.4-ac10.bz2, which is 0 bits.... so I have bunzip -c
patch-2.4.4-ac10.bz2|patch -p1 -s with an empty file :-((

That mean I compiled a 2.4.4 kernel, and not a 2.4.4-ac10 one.

I know that becauseause I reemoved my fdomain SCSI controller and put an
Adaptec 2940 at the same place, and it booted very well...

So the problem is ME: I am too stupid!!!

Anyway, the bug is in 2.4.4, not in 2.4.4-ac10: I am really sorry for
having loosing your time. With 2.4.4-ac9 with my fdomain, everything is
also working great ;-)

If I can do anything, just let me know ;-)

Thanks you very much,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7BX/PFDWhsRXSKa0RAiGCAKDJ5KTN6QY8gGAbyJyo84wosY74KwCdEtcz
aCVtFgGb7qTdfSh0hwtoK5U=
=dsTY
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
