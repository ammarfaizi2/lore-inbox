Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264921AbUFAR5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbUFAR5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUFAR5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 13:57:39 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3780 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265099AbUFAR5f (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 13:57:35 -0400
Message-Id: <200406011757.i51HvBUB010879@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Martin Olsson <mnemo@minimum.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all? (what the user feels) 
In-Reply-To: Your message of "Tue, 01 Jun 2004 19:38:54 +0200."
             <40BCBF2E.7030802@minimum.se> 
From: Valdis.Kletnieks@vt.edu
References: <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua> <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net> <20040531104928.GA1465@ncsu.edu> <40BC6F0C.7000602@vision.ee> <20040601164946.GA22798@ncsu.edu>
            <40BCBF2E.7030802@minimum.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_258973221P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Jun 2004 13:57:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_258973221P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Jun 2004 19:38:54 +0200, Martin Olsson <mnemo@minimum.se>  said:

> Maybe we could just have a "Allow file system cache to swap out 
> applications checkbox somewhere"?
> 
> Or, Am I missing something?

Isn't that what /proc/sys/vm/swappiness is for? (And yes, I know that it's not
a total solution to the whole range of conflicting requirements that we have -
I suspect that it's really difficult to make it work much better than it is
without adding a lot more history-tracking instrumentation).


--==_Exmh_258973221P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvMN3cC3lWbTT17ARAoA9AKDaVLvZRqJPFVBA5jqhj5CmqgO/bQCg2L6f
0zzo2PfTvO44TcsYRd180l0=
=BRdc
-----END PGP SIGNATURE-----

--==_Exmh_258973221P--
