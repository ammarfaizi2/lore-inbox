Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131816AbRAKRmt>; Thu, 11 Jan 2001 12:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131831AbRAKRmj>; Thu, 11 Jan 2001 12:42:39 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:30190 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S131816AbRAKRmb>; Thu, 11 Jan 2001 12:42:31 -0500
Date: Thu, 11 Jan 2001 17:40:55 +0000
From: Tim Waugh <twaugh@redhat.com>
To: f5ibh <f5ibh@db0bm.ampr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops while loading ppa in 2.2.19-pre7
Message-ID: <20010111174055.L16951@redhat.com>
In-Reply-To: <200101111729.SAA24053@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101111729.SAA24053@db0bm.ampr.org>; from f5ibh@db0bm.ampr.org on Thu, Jan 11, 2001 at 06:29:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 11, 2001 at 06:29:27PM +0100, f5ibh wrote:

> I got this non-fatal oops while loading the ppa module for my IOMEGA parallel
> port ZIP drive.

It doesn't look like it's related to the ZIP drive though:

> Warning: kfree_skb passed an skb still on a list (from c8074fc1).
> Oops: 0002
> CPU:    0
> EIP:    0010:[skb_recv_datagram+359/416]
                ^^^^^^^^^^^^^^^^^

Seems to be a networking problem..

Tim.
*/

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6XfAmONXnILZ4yVIRAvkPAKCbeSc0Weimes0UOJCXJaMS4CxIbwCePzeg
sBW5+vlUVPieBcxLjW6soaw=
=08B5
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
