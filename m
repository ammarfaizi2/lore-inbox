Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbRH1UPu>; Tue, 28 Aug 2001 16:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRH1UPl>; Tue, 28 Aug 2001 16:15:41 -0400
Received: from pc2-camb6-0-cust223.cam.cable.ntl.com ([213.107.107.223]:52615
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S266806AbRH1UP0>; Tue, 28 Aug 2001 16:15:26 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: "Tony Hoyle" <tmh@nothing-on.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Treating parallel port as serial device 
In-Reply-To: Message from "Tony Hoyle" <tmh@nothing-on.tv> 
   of "Tue, 28 Aug 2001 21:09:12 BST." <9mgtpb$mf4$1@sisko.my.home> 
In-Reply-To: <9mgtpb$mf4$1@sisko.my.home> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2145994864P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Aug 2001 21:15:32 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E15bpGm-0000Em-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2145994864P
Content-Type: text/plain; charset=us-ascii

>even comes close.  Userspace probably wouldn't cut it as I'm reading as
>9600 baud and usleep doesn't have nearly enough resolution.

9600 baud is only 1 bit every 100us or so.  SCHED_FIFO and nanosleep should be 
perfectly adequate for timing.  You can use ppdev or direct port I/O to get at 
the pins.

p.


--==_Exmh_-2145994864P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7i/vkVTLPJe9CT30RAqHKAJ9RRV50ur9BSXAzIm/zffNu7NIwkgCg2ZMm
gev/z9Nt9gp7lnHsrVxBFVQ=
=8bVz
-----END PGP SIGNATURE-----

--==_Exmh_-2145994864P--
