Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWARW3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWARW3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWARW3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:29:37 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40418 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932565AbWARW3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:29:36 -0500
Message-Id: <200601182229.k0IMTJ56003467@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Wireless issues (was Re: 2.6.16-rc1-mm1 
In-Reply-To: Your message of "Wed, 18 Jan 2006 00:50:53 PST."
             <20060118005053.118f1abc.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20060118005053.118f1abc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137623359_2956P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 17:29:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137623359_2956P
Content-Type: text/plain; charset=us-ascii

On Wed, 18 Jan 2006 00:50:53 PST, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm1/
> 

My laptop has a Dell TrueMobile 1150 wireless card, which fell over using rc1-mm1.

/sbin/pccardctl ident:

Socket 2:
  product info: "Dell", "TrueMobile 1150 Series PC Card", "Version 01.01", ""
  manfid: 0x0156, 0x0002
  function: 6 (network)

Found in 2.6.16-rc1-mm1 dmesg:

orinoco 0.15rc3 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_cs 0.15rc3 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_cs: GetNextTuple(): No matching CIS configuration.  Maybe you need the ignore_cis_vcc=1 parameter.
2.0: GetFirstTuple: No more items
orinoco_cs: GetNextTuple(): No matching CIS configuration.  Maybe you need the ignore_cis_vcc=1 parameter.
2.0: GetFirstTuple: No more items

and a non-functioning wireless card.

A 2.6.15 dmesg says:

orinoco 0.15rc3 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_cs 0.15rc3 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
eth3: Hardware identity 0005:0004:0005:0000
eth3: Station identity  001f:0001:0008:000a
eth3: Firmware determined as Lucent/Agere 8.10
eth3: Ad-hoc demo mode supported
eth3: IEEE standard IBSS ad-hoc mode supported
eth3: WEP supported, 104-bit key
eth3: MAC address 00:02:2D:5C:11:48
eth3: Station name "HERMES I"
eth3: ready
eth3: index 0x01: Vcc 3.3, irq 11, io 0xe100-0xe13f

I haven't tried adding ignore_cis_vcc to the boot yet, I'm on my way out the door...

--==_Exmh_1137623359_2956P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDzsE/cC3lWbTT17ARAj20AJ9uV8SDaByDOCxKLaFPXPMVsP7c9ACeJrr3
oO0lrJ4gKIkiix6aH677abk=
=rW8K
-----END PGP SIGNATURE-----

--==_Exmh_1137623359_2956P--
