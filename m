Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTJQPG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 11:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263550AbTJQPG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 11:06:29 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12160 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263549AbTJQPGZ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 11:06:25 -0400
Message-Id: <200310171506.h9HF6MbN006154@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS 
In-Reply-To: Your message of "Fri, 17 Oct 2003 10:16:29 EDT."
             <20031017141629.GB8412@gtf.org> 
From: Valdis.Kletnieks@vt.edu
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017013245.GA6053@ncsu.edu> <1066355235.3f8f4a2395fa0@horde.sandall.us> <20031017130729.GB2794@ncsu.edu>
            <20031017141629.GB8412@gtf.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1744076400P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Oct 2003 11:06:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1744076400P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Oct 2003 10:16:29 EDT, Jeff Garzik said:

> > This assumes that the probability of there being a bug in the code which
> > checks for identical blocks is less than the probability of a hash collision.
> > I am not sure that is a good assumption.
> 
> The complexity of a memcmp() is pretty low...

What's the probability of a non-ECC-corrected error on a memory read during the
computation of the hash or the memcmp()? (Remember that Linux *does* boot on
machines that don't support ECC memory by default, such as many Macs).


--==_Exmh_1744076400P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/kAVucC3lWbTT17ARAkdAAKDjkVROLA08QY2B+nMO0CebDhzQAACeK9Ne
oUQsMWSfuQgnuHYr3sOflNI=
=Gtzy
-----END PGP SIGNATURE-----

--==_Exmh_1744076400P--
