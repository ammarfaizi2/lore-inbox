Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbTCYBH0>; Mon, 24 Mar 2003 20:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbTCYBH0>; Mon, 24 Mar 2003 20:07:26 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:26008 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S261314AbTCYBHY>; Mon, 24 Mar 2003 20:07:24 -0500
Date: Tue, 25 Mar 2003 02:18:25 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Gerd Knorr <kraxel@bytesex.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-Id: <20030325021825.4f0e67e4.us15@os.inf.tu-dresden.de>
In-Reply-To: <20030325003048.GC10505@kroah.com>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
	<20030325012252.7aafee8c.us15@os.inf.tu-dresden.de>
	<20030325003048.GC10505@kroah.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.11claws41 (GTK+ 1.2.10; Linux 2.5.66)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.7RH,/2WLBPq2ei"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.7RH,/2WLBPq2ei
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2003 16:30:48 -0800 Greg KH (GK) wrote:

Hello,

GK> Yes, I sent out some patches a few evenings ago to lkml that should fix
GK> this problem.  I'm resyncing them with 2.5.66 right now and will send
GK> them to Linus in a bit.

I've found all 13 patches and applied them here.

GK> If you want to get around this for now, in the bttv driver, memset the
GK> i2c_client structure to 0 after it is initialized.  That will solve the
GK> problem.

Yes, the oops is cured now.

Thanks.

-Udo.

--=.7RH,/2WLBPq2ei
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+f65jnhRzXSM7nSkRAjXsAJ9PXChf4Y4goIo2/pVi5v9XMzugZwCeOHec
p/kNKMRA1ilfkZfjLiOCgWg=
=G+1P
-----END PGP SIGNATURE-----

--=.7RH,/2WLBPq2ei--
