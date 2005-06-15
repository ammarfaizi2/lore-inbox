Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVFOGT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVFOGT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 02:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVFOGT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 02:19:27 -0400
Received: from [213.69.232.60] ([213.69.232.60]:49422 "HELO ei.schottelius.org")
	by vger.kernel.org with SMTP id S261505AbVFOGTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 02:19:19 -0400
Date: Wed, 15 Jun 2005 08:19:04 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is one sync() not enough?
Message-ID: <20050615061904.GJ1467@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <20050614094141.GE1467@schottelius.org> <20050614125828.GM446@admingilde.org> <9a87484905061408585c52f96b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
Content-Disposition: inline
In-Reply-To: <9a87484905061408585c52f96b@mail.gmail.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jesper Juhl [Tue, Jun 14, 2005 at 05:58:36PM +0200]:
> [sync twice, sync waits for sync]
>=20
> I believe sync in recent Linux's actually waits for the data to be
> written and never returns early, so I don't think this is relevant any
> more - and everyone uses shutdown these days anyway. But go read the
> implementation of sync if you really want to know.

Thanks for the detailled instructions. I'll have a look at
the sync implementation to see how it really works.

Anyway: As I am writing an init-system, I also have to write a
shutdown procedure ;-)

Greetings,

Nico


--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--72k7VsmfIboquFwl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQq/IVrOTBMvCUbrlAQLyQRAAkVley0DAKg2NAWbmBCX+byoMe8mc2VKr
WFrXSN5sCFveJv9++/bbmGuJViDQo2rzTZkRFMPWKsGcXtYoL8f+0NAGT2FBIhQi
jVA4iPgPaSNNJpPsXMT/4oNE3bkScOXm18eN9+qKaewlUpJvsnNp3dcHP8loVjXR
yuEd0pTPM3ZN52hXO8worTtaqj1hUtrNQyytVtyJItUbKrHiQOUMV3hgEGJGGQfl
zS8PvqvWFEOi1byoBFr02IWPoKtD5MxgHmysWnJARGA4suO5beKODJvcKjmjHX9T
csvKmF4sXXLPgNdO7T+RGLhsbi2WJYgmi2EF0XPnrrAEPyfW9exbtA5e7r/pvNS6
hB7jNBOp9SqAjDrsTkfXkIovmImf4iVFGi/MnFgJu191AlWGrumxnCrmhWzQUoMl
UudFAXEEDLFBNwpHM+5afVbrF3xzIMJ2rlZmcNGgAfYiahCFSo5APTuOPc/VQkyU
Yqz/ggZXqDYFi4P828V6KHXJoyBAb0VBpn/vvf7DktlJBak/s4zc8udei84DAo7t
jhGRaqytdr+fzJ1YtYKSz5lfcUvTkkS/RafkPUfJC8hP7LQlk80x9y+ckdZNXhQR
lSzqwiHpbh1t7jQ1s98TkMoSSWiEYDCkP+S1BP2ExlqNEWVgEZs43uHKGKfYgWBx
Ytt4z0Uoww8=
=TBmh
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--
