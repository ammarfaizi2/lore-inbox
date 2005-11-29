Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVK2Huu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVK2Huu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 02:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVK2Hut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 02:50:49 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:49692 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750820AbVK2Hut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 02:50:49 -0500
Date: Tue, 29 Nov 2005 08:50:47 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: Re: PowerBook5,8 - TrackPad update
Message-ID: <20051129075047.GA26460@hansmi.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net> <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net> <20051129000615.GA20843@hansmi.ch> <68465DDA-053F-4A85-9204-549E830B2269@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <68465DDA-053F-4A85-9204-549E830B2269@comcast.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Parag

On Tue, Nov 29, 2005 at 01:11:00AM -0500, Parag Warudkar wrote:
> Is yours the 15" model or the 17"? Mine is 15" and the product id is =20
> 0x0214.

It's the 15" one.

> I haven't looked at your changes completely yet but are you saying it
> works? Meaning mouse moves properly?

The mouse moves, but slowly. Maybe something isn't correct yet, but it
works basically.

> Also I find it strange that your model requires 80 bytes ATP_DATASIZE
> - mine isn't happy at all with anything less than 256. The less number
> of sensors you  defined is again a puzzle.

That are points I need to investigate further.

> If the format of the data is same (which looks like it is with your
> model) then yes, but in my case the data arrives is 64 byte blocks -
> there are 4 of them in one  transfer, each a reading on it's own.

I get 256 bytes in each transfer as well, but didn't look at the bytes
behind 40. Maybe that'll help to make it more responsive.

> Hmm. More confusion.

Oh yes. Why does Apple ship the basically same PowerBook with different
Touchpads?

Greets,
Michael

--=20
Gentoo Linux Developer using m0n0wall | http://hansmi.ch/

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDjAhX6J0saEpRu+oRAomaAJ9RtINrl7BVjuMN+n9376vmz9N8lwCfUzVK
MtXyHU/wRwh2XPtYIIr4Ae0=
=wPid
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
