Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVBWVsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVBWVsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVBWVrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:47:46 -0500
Received: from ns.schottelius.org ([213.146.113.242]:17321 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S261616AbVBWVpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:45:52 -0500
Date: Wed, 23 Feb 2005 22:45:50 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [reiserfs] 100% cpu consum - normal?
Message-ID: <20050223214550.GA1069@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I once again tried reiserfs, this time on my ibook:

ei ~ # mkreiserfs  -V
mkreiserfs 3.6.19 (2003 www.namesys.com)

ei ~ # uname -a
Linux ei 2.6.10 #5 Sun Feb 6 17:26:47 CET 2005 ppc 750CXe PowerBook4,1 GNU/=
Linux

If I tar xf $big_tar (speaking about the gcc-source), my system hangs:

- no console switching
- all keyboard input is lost
- no mouse reaction
- no network response
- no display refreshing=20

When doing that on my dm-crypt-jfs home partition this does not happen.
Nor does it on my xfs root partition.

Is that a normal behaviour of reiserfs 3.6?

Greetings,

Nico

P.S.: I never assumed reiserfs will ever be a stable filesystem, but this
      is the worst result I have with it. Perhaps I am missing
      some tuning/mount option?

PPS: Please CC and confirm, I am not subscribed.

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iQIVAwUBQhz5jLOTBMvCUbrlAQLagQ/8DwjC5QDa0Kp6kk93vPcAC/18yVcvJejq
cvDrUQqRZn9xhDOAY4pGjVM2mBUQypSS0KBxuvgKU8S5bMqx3G+7EwrPqTj4ozpS
r23W5pmwvrHbixLMaB6aRretj/Osw5Sv72Wj9hN4I/5VolgPPjc3EM20l4tqC6ah
8sDYWjRguxZk878NdWJ/9L/LBeA1ZcJAfg58xpIY+erAOIniVYEWEQr+pBG5KwOb
VC5IddZzyQGQvD4aLe+SsMjfoRa68rOxopqYrcxFtHuNbQ17X3oL9io87tJbemXB
qr3JKuVQ9uR0OQmikOsHx7mHdRO+t5ceeSNedkPn/svmy9ugDXchncVPnl/jnF6V
zF7x6XQpFEsqmE4Bqi5DBQaSJiCnnSA/0DpeyZp5M/8jpAoumP8h8zS4VbU3kCOW
TfcOqmCEqo1W+cSZf+vyCyqoDyub5zGE4IAeGFWYRjTyiuWpD8j/0G2dfqu0/6cM
1U5S97xeCLVALFq9btOhY9h4qJ/QsmVK3Az5eRw6N85feFY3GSOxTvE7qelue1EE
m1xL8083AF2p/Bkd9JLqEZwxRtBvb72g+52xaAmcQqrz47IMYAagZDZUsuY83Cga
OeBqrJvNN/9RpTdSmHvJYBsjpJlNN9VGA6deB0avzf/yh0weAd8Oo4UNX7pzhSGW
AiXeZMFu2Pw=
=ExL1
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
