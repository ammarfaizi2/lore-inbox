Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVAUOpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVAUOpD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 09:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVAUOpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 09:45:03 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:24583 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262378AbVAUOo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 09:44:56 -0500
Date: Fri, 21 Jan 2005 15:44:44 +0100
From: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
To: linux-kernel@vger.kernel.org
Subject: ppp0 out of control
Message-ID: <20050121144444.GA2100@roxor.be>
Reply-To: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi there,

I am running 2.6.10 from kernel.org on Debian Sid ppc/x86, the same
issue occurs with 2.6.9. Though, 2.6.8.1 and previous are fine.

When my ISP connection via PPPoE (kernel side) goes down, reconnection
does not occur, and the kernel displays continuous:

kernel: unregister_netdevice: waiting for ppp0 to become free. Usage count = 1

This is that on both machine: x86 and ppc.

The only solution is a reboot, because pppd is not killable, and the
kernel keeps on with this message.

Does anyone have a solution? I am completely clueless. :( I thought
about stalled sockets, but how can I destroy them?

What is blocking ppp0?

What system outputs do you need to solve this?

Cheers.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB8RVcI2xgxmW0sWIRAgqsAJ9l5uGjqr4ib6YkY9Veo9v4yh993gCgqy2U
xkssdhLe0bn5cj1hbgIkIM8=
=PiTb
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
