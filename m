Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUFYQnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUFYQnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266795AbUFYQnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:43:12 -0400
Received: from mout1.freenet.de ([194.97.50.132]:1257 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S266796AbUFYQlo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:41:44 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
Date: Fri, 25 Jun 2004 18:40:21 +0200
User-Agent: KMail/1.6.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406251840.46577.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I just applied the patch against 2.6.7-bk7 and saw
the following strange thing:

I was compiling some program, as suddenly compilation
stopped. g++ was running (sorry, I didn't look at the
process state. Maybe it was in T or something like that),
but it didn't get any timeslice. (so didn't execute. Simply
stayed around and didn't finish).
I noticed this since I switched from staircase 7.1 to 7.4
a few minutes ago. No such problems before.
I'm not really sure, if it's a staircase problem. Just
wanted to let you know.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3FWNFGK1OIvVOP4RAhw1AJ9P50RtKh86EvHWRxJ8l2EdF7lWZACgnFV3
JATebGeaWIOOkBZs4ly6d3g=
=8SfQ
-----END PGP SIGNATURE-----
