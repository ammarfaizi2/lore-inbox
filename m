Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbUL0WxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbUL0WxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 17:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbUL0WxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 17:53:17 -0500
Received: from h80ad25c6.async.vt.edu ([128.173.37.198]:40369 "EHLO
	h80ad25c6.async.vt.edu") by vger.kernel.org with ESMTP
	id S261995AbUL0Wuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:50:50 -0500
Message-Id: <200412272250.iBRMo2Qb011114@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: "David S. Miller" <davem@davemloft.net>
Cc: Patrick McHardy <kaber@trash.net>, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: PATCH: kmalloc packet slab 
In-Reply-To: Your message of "Mon, 27 Dec 2004 14:23:50 PST."
             <20041227142350.1cf444fe.davem@davemloft.net> 
From: Valdis.Kletnieks@vt.edu
References: <1104156983.20944.25.camel@localhost.localdomain> <41D043AC.2070203@trash.net>
            <20041227142350.1cf444fe.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1419475951P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Dec 2004 17:50:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1419475951P
Content-Type: text/plain; charset=us-ascii

On Mon, 27 Dec 2004 14:23:50 PST, "David S. Miller" said:

> If we are really going to do something like this, it should
> be calculated properly and be determined per-interface
> type as netdevs are registered.

Would you prefer to see this done for all interface types if we do it
at all, or would a special-case for 1 or 2 types that can use a slab
without being wasteful be an acceptable solution? (Let's face it - if
3.95 objects fit in each slab, we may not want to do it...)

--==_Exmh_-1419475951P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB0JGZcC3lWbTT17ARAtkPAKDjhu4Ocy8aQbbY8GwpjCG9aaTu+wCgybsg
s31h8DjurnRR1B6j4DuSr7Y=
=3OVm
-----END PGP SIGNATURE-----

--==_Exmh_-1419475951P--
