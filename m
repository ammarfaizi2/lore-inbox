Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbUEOHTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUEOHTp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 03:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUEOHTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 03:19:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262862AbUEOHTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 03:19:43 -0400
Date: Sat, 15 May 2004 09:19:09 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040515071908.GA27240@devserv.devel.redhat.com>
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com> <20040514114746.GB23863@wohnheim.fh-wedel.de> <20040514151520.65b31f62.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20040514151520.65b31f62.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 14, 2004 at 03:15:20PM -0700, Andrew Morton wrote:
> would be better to do:
> 
> find . -name '*.o' | xargs objdump -d | perl scripts/checkstack.pl i386

if you do '*.ko' you only look at the modules not the intermediate results
(which duplicate the vmlinux twice, once for the .o, once for the
built-in.o)


--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFApcRsxULwo51rQBIRAtSNAKCkvmyGvqkxc4fDGK95KMsMAXbYnwCcDqK6
ouhpirkSHL5HPMcU/SskZ+g=
=vqiy
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
