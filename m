Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVBOV0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVBOV0D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVBOV0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:26:03 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7183 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261894AbVBOVZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 16:25:59 -0500
Message-Id: <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device 
In-Reply-To: Your message of "Tue, 15 Feb 2005 20:48:13 +0100."
             <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com> 
From: Valdis.Kletnieks@vt.edu
References: <1108426832.5015.4.camel@bastov> <1108434128.5491.8.camel@bastov> <42115DA2.6070500@osdl.org> <1108486952.4618.10.camel@localhost.localdomain>
            <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1108502728_4257P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Feb 2005 16:25:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1108502728_4257P
Content-Type: text/plain; charset=us-ascii

On Tue, 15 Feb 2005 20:48:13 +0100, "Kiniger, Karl (GE Healthcare)" said:

> I can confirm that. Creating a correct  iso image from a CD is a
> major pain w/o ide-scsi. Depending on what one has done before the iso
> image is missing some data at the end most of the time.
> (paired with lots of kernel error messages)
> 
> Testing was done here using Joerg Schilling's sdd:
> 
> sdd ivsize=`isosize /dev/cdxxx` if=/dev/cdxxx of=/dev/null \
> 	bs=<several block sizes from 2048 up tried,does not matter>
> 
> and most of the time it results in bad iso images....

Have you tested the ISO on some *OTHER* hardware?  The impression I got
was that the cd was *burned* right by ide-cd, but when *read back*, it
bollixed things up at the end of the CD.....

--==_Exmh_1108502728_4257P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCEmjIcC3lWbTT17ARAn0dAJ9pVqt4k807hWL7EjeubVAW+mM2BwCglzRt
elTlNoISYBCNF1xmlqa3Pfc=
=2hdw
-----END PGP SIGNATURE-----

--==_Exmh_1108502728_4257P--
