Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTIDKms (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 06:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbTIDKms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 06:42:48 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:59520
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S262217AbTIDKmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 06:42:46 -0400
Date: Thu, 4 Sep 2003 12:42:45 +0200
To: linux-kernel@vger.kernel.org
Subject: nasm over gas?
Message-ID: <20030904104245.GA1823@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1063536166.2852@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I recently posted a module for twofish which implements the algorithm in
assembler (http://marc.theaimsgroup.com/?l=linux-kernel&m=106210815132365&w=2)

Unfortunately the assembler used is masm. I'd like to change that. Netwide
Assembler (nasm) is the assembler of my choice since it focuses on
portablity and has a more powerful macro facility (macros are heavily used
by 2fish_86.asm). But as I'd like to make my work useful (aim for an
inclusion in the kernel) I noticed that this would be the first module to
depend on nasm. Everything else uses gas.

So the question is: Is a patch which depends on nasm likely to be merged?

For more information on "what is nasm":
http://nasm.sourceforge.net/doc/html/nasmdoc1.html#section-1.1

Regards, Clemens

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/VxclW7sr9DEJLk4RAnN2AJ9PS+yPKg8pwBr/dZ+nxXRJTJku7wCfYFUo
wQctUEFkGNfVG6dZA/9qOm4=
=Rb4W
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
