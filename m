Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbTALXNZ>; Sun, 12 Jan 2003 18:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267638AbTALXLT>; Sun, 12 Jan 2003 18:11:19 -0500
Received: from h80ad2762.async.vt.edu ([128.173.39.98]:13184 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267616AbTALXI4>; Sun, 12 Jan 2003 18:08:56 -0500
Message-Id: <200301122316.h0CNGmkr003807@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
Cc: jochen@jochen.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5.55, PCI, PCMCIA, XIRCOM] 
In-Reply-To: Your message of "Sun, 12 Jan 2003 14:58:39 PST."
             <1755778.1042412319026.JavaMail.nobody@web55.us.oracle.com> 
From: Valdis.Kletnieks@vt.edu
References: <1755778.1042412319026.JavaMail.nobody@web55.us.oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1721357872P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Jan 2003 18:16:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1721357872P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jan 2003 14:58:39 PST, Alessandro Suardi said:
> > On Fri, 10 Jan 2003 20:00:31 +0100, Jochen Hein said:
> > > > - and I've seen a report it causes an OOPS
> > > > on 2.5.53.  I've not tried it on post-52, but I had a -54 kernel OOPS
> 
> Guess the report was mine :) note for readers, this is bug 134
>  in the 2.5 kernel bug database at http://bugme.osdl.org .
> 
> > > > right around that point in bootup (right after IDE and somewhere in PCI
> > > > init).  Haven't chased that one at all...
> > if it OOPSes without my patch, then it's somebody else's problem.  
> 
> No, it did oops only with the patch.

My *original* patch (the one that just moved 2 lines) plus the 2-liner
by Zwane Mwaikambo to fix the DMA patch is working for me.  I know Zwane's
patch is already in Bitkeeper, I don't think we've ever resolved the "right"
solution for mine....
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-1721357872P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+IfdgcC3lWbTT17ARAtiwAJ9zr6PJkluFp5+ffEP/PZGqpnX4vwCg6hoW
O3zhb/Av0h8+3Fm7ReeD82E=
=MmJS
-----END PGP SIGNATURE-----

--==_Exmh_-1721357872P--
