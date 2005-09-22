Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbVIVGHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbVIVGHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbVIVGHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:07:07 -0400
Received: from h80ad24c8.async.vt.edu ([128.173.36.200]:31445 "EHLO
	h80ad24c8.async.vt.edu") by vger.kernel.org with ESMTP
	id S965236AbVIVGHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:07:06 -0400
Message-Id: <200509220606.j8M66u8d010990@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: rep stsb <repstsb@yahoo.ca>
Cc: linux-kernel@vger.kernel.org, 06020051@lums.edu.pk
Subject: Re: In-kernel graphics subsystem 
In-Reply-To: Your message of "Thu, 22 Sep 2005 01:51:20 EDT."
             <20050922055120.23356.qmail@web33203.mail.mud.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050922055120.23356.qmail@web33203.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127369215_2825P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 02:06:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127369215_2825P
Content-Type: text/plain; charset=us-ascii

On Thu, 22 Sep 2005 01:51:20 EDT, rep stsb said:

> 1. Convert svgalib drivers into kernel modules to get
> v-sync interrupts. 
> 
> 2. Write a windowing program on svgalib. 

Wouldn't it make more sense to extend the current framebuffer driver
support to support v-sync? (framebuffers are already in the kernel, and
there were so many security holes with svgalib-based programs that it left
a bad taste in a lot of people's mouths)

And having gotten a v-sync interrupt, what would you *do* with it?
You'll need an API here....



--==_Exmh_1127369215_2825P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMkn/cC3lWbTT17ARAtAcAKCIuuHQVPpJVljBn5josVQSmGUKsgCeIDF3
KiRe63QE3rCENQLTsBNYKO4=
=Oil2
-----END PGP SIGNATURE-----

--==_Exmh_1127369215_2825P--
