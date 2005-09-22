Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVIVETN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVIVETN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVIVETN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:19:13 -0400
Received: from h80ad24c8.async.vt.edu ([128.173.36.200]:63679 "EHLO
	h80ad24c8.async.vt.edu") by vger.kernel.org with ESMTP
	id S965225AbVIVETM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:19:12 -0400
Message-Id: <200509220419.j8M4J5gt006469@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-rc1-mm1.5 - keyboard wierdness 
In-Reply-To: Your message of "Wed, 21 Sep 2005 23:00:17 CDT."
             <200509212300.17740.dtor_core@ameritech.net> 
From: Valdis.Kletnieks@vt.edu
References: <200509220335.j8M3ZGEJ004230@turing-police.cc.vt.edu>
            <200509212300.17740.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127362744_2825P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 00:19:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127362744_2825P
Content-Type: text/plain; charset=us-ascii

On Wed, 21 Sep 2005 23:00:17 CDT, Dmitry Torokhov said:

> I have seen this couple of times when I would eject my prism54 card at
> a "bad" time - my card sometimes gets stuck (a known problem with some
> prism54 cards) and if I would eject it "too early" I would lose keyboard.
> So I wait till it complain: 
> 
> 	prism54: Your card/socket may be faulty, or IRQ line too busy :(
> 
> and eject and insert it again and all is fine.

Hmm.. the wireless card in this is (a) an Orinoco and (b) not ejectable, as
it's a built-in, and (c) wasn't even in use at the time...

i8042 is on IRQ1, and the warp-drive modem is on IRQ11.  And the USB that had
the still-working mouse is on IRQ11 too.

Anybody got a better idea than running a cronjob every 5 mins that runs
oprofile for 1 minute, and dumping the stats, and waiting for it to hit again?

--==_Exmh_1127362744_2825P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMjC4cC3lWbTT17ARAqldAJ4x85RKcOKxlJLfpkGbJ/UDVmM2YgCfUnuD
8Yxtou8jWh7bkGSdbnmVLQg=
=2/mx
-----END PGP SIGNATURE-----

--==_Exmh_1127362744_2825P--
