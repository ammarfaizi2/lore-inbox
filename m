Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVCANgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVCANgy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVCANgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:36:54 -0500
Received: from h80ad264f.async.vt.edu ([128.173.38.79]:26888 "EHLO
	h80ad264f.async.vt.edu") by vger.kernel.org with ESMTP
	id S261904AbVCANgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:36:51 -0500
Message-Id: <200503011336.j21DaaqC008164@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1 
In-Reply-To: Your message of "Tue, 01 Mar 2005 01:27:41 PST."
             <20050301012741.1d791cd2.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20050301012741.1d791cd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109684196_5227P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Mar 2005 08:36:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109684196_5227P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Mar 2005 01:27:41 PST, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/

> - A pcmcia update which obsoletes cardmgr (although cardmgr still works) and
>   makes pcmcia work more like regular hotpluggable devices.  See the
>   changelong in pcmcia-dont-send-eject-request-events-to-userspace.patch for
>   details.

This is still showing the same 'cs: unable to map card memory!' issue on my
Dell laptop.  Backing out bk-pci.patch makes it work again.

For what it's worth, the hotplug system wasn't able to initialize the wireless
card (TrueMobile 1150) at boot - still needed cardmgr to get it started up.
But that might just me being an idiot...


--==_Exmh_1109684196_5227P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCJG/kcC3lWbTT17ARAre5AKCiWrhysnSavYrlAvH40ZsoGemphQCfepj0
VIlWzN6Srzist6BJhoUPh6g=
=JHM3
-----END PGP SIGNATURE-----

--==_Exmh_1109684196_5227P--
