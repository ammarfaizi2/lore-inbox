Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUGRPwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUGRPwa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 11:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUGRPwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 11:52:30 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:62083 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S264265AbUGRPw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 11:52:28 -0400
Date: Sun, 18 Jul 2004 17:51:40 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.6.7
Message-ID: <20040718155140.GA16760@thundrix.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

Jul 18 19:49:02 jules kernel: Unable to handle kernel paging request at virtual address d2389f28
Jul 18 19:49:02 jules kernel:  printing eip:
Jul 18 19:49:02 jules kernel: c030cdc0
Jul 18 19:49:02 jules kernel: *pde = 00047067
Jul 18 19:49:02 jules kernel: *pte = 12389000
Jul 18 19:49:02 jules kernel: Oops: 0000 [#1]
Jul 18 19:49:02 jules kernel: PREEMPT DEBUG_PAGEALLOC
Jul 18 19:49:02 jules kernel: Modules linked in:
Jul 18 19:49:02 jules kernel: CPU:    0
Jul 18 19:49:02 jules kernel: EIP:    0060:[pagebuf_daemon+384/736]    Not tainted
Jul 18 19:49:02 jules kernel: EFLAGS: 00010282   (2.6.7)
Jul 18 19:49:02 jules kernel: EIP is at pagebuf_daemon+0x180/0x2e0
Jul 18 19:49:02 jules kernel: eax: d2389ec4   ebx: d2389ec4   ecx: d2389ec4   edx: d75ddf78
Jul 18 19:49:02 jules kernel: esi: d3beeec4   edi: d7598000   ebp: d7599fd4   esp: d7599fd0
Jul 18 19:49:02 jules kernel: ds: 007b   es: 007b   ss: 0068
Jul 18 19:49:02 jules kernel: Process xfsbufd (pid: 14, threadinfo=d7598000 task=d75d6a10)
Jul 18 19:49:02 jules kernel: Stack: 00003a98 d236cf14 d2374f14 00000000 c030cc40 00000000 00000000 00000000
Jul 18 19:49:02 jules kernel:        c0103ccd 00000000 00000000 00000000
Jul 18 19:49:02 jules kernel: Call Trace:
Jul 18 19:49:02 jules kernel:  [pagebuf_daemon+0/736] pagebuf_daemon+0x0/0x2e0
Jul 18 19:49:02 jules kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Jul 18 19:49:02 jules kernel:
Jul 18 19:49:02 jules kernel: Code: 8b 43 64 8b 40 08 85 c0 74 0e 8b 40 68 85 c0 74 07 8b 50 14

I just booted the PC,  emacsed my /etc/X11/xorg.conf, and saw that one
when I was just idling around thinking what to type.

			    Tonnerre

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD4DBQFA+pyL/4bL7ovhw40RAvgEAKCRkPCPTsmqCrLKG8zERU0+SFVqAACXbmDm
qg8q65BJQmbJUDVwuHNf3Q==
=UP9g
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
