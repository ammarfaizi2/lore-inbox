Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTE1BOz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 21:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbTE1BOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 21:14:55 -0400
Received: from h80ad26af.async.vt.edu ([128.173.38.175]:9088 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264469AbTE1BOy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 21:14:54 -0400
Message-Id: <200305280127.h4S1RLN6002823@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jim Keniston <jkenisto@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>,
       "Feldman, Scott" <scott.feldman@intel.com>, Greg KH <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>, Phil Cayton <phil.cayton@intel.com>,
       Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>, shemminger@osdl.org,
       kenistoj@us.ibm.com
Subject: Re: [RFC] [PATCH] Net device error logging (revised) 
In-Reply-To: Your message of "Tue, 27 May 2003 16:17:48 PDT."
             <3ED3F21C.B3052C8C@us.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <3ECF0F64.AAD25389@us.ibm.com> <200305240805.h4O85f9O009429@turing-police.cc.vt.edu>
            <3ED3F21C.B3052C8C@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_5284528P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 27 May 2003 21:27:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_5284528P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 May 2003 16:17:48 PDT, Jim Keniston said:

> Was the name slippage due to the intervention of an administrative utility?
> Just curious.

No, it was due to the *lack* of intervention. Depending where I am, my
laptop can have up to 4 ethernet interfaces - onboard, docking station,
wireless card, and the ethernet side of the Xircom ethernet/modem card.
And of course 2.4 and 2.5 kernels number them differntly,  and if I'm
booting single-user /sbin/nameif doesn't get run yes, etc etc etc.

So if I see 'eth2' in a dmesg, I can usually be sure it's not the onboard NIC,
but it could be any one of the other 3 and require some work to disambiguate.
(Yes, 'nameif' does a *wonderful* job of usually keeping all 4 nailed down
to save my sanity - it's just that it seems to fail to do so at the times
it really matters. ;)


--==_Exmh_5284528P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+1BB4cC3lWbTT17ARAhjzAJ9P5N/mPbK5zXOoPjow5ZQsKs/L/wCcDRSV
7ampCNivW4smXdPBwNSdpLg=
=uPKm
-----END PGP SIGNATURE-----

--==_Exmh_5284528P--
