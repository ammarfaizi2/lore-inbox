Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266092AbUF2VqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266092AbUF2VqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUF2VqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:46:13 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:15571 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S266096AbUF2Vpu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:45:50 -0400
Message-Id: <200406292145.i5TLjlu0010297@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Willy Tarreau <willy@w.ods.org>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt 
In-Reply-To: Your message of "Tue, 29 Jun 2004 23:22:56 +0200."
             <87brj212kv.fsf@deneb.enyo.de> 
From: Valdis.Kletnieks@vt.edu
References: <40DC9B00@webster.usu.edu> <20040625150532.1a6d6e60.davem@redhat.com> <cbp62t$a38$1@news.cistron.nl> <20040628183709.GL29808@alpha.home.local> <87vfhbjxgw.fsf@deneb.enyo.de> <200406292003.i5TK3Y6o017275@turing-police.cc.vt.edu>
            <87brj212kv.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1796366355P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Jun 2004 17:45:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1796366355P
Content-Type: text/plain; charset=us-ascii

On Tue, 29 Jun 2004 23:22:56 +0200, Florian Weimer said:
> * Valdis Kletnieks:
> 
> > The latest numbers I saw on the NANOG list estimated that only 30%
> > to 40% of core peerings were using MD5 even several weeks after the
> > Great MD5-Fest...
> 
> 30% to 40% is extremely high.  Are you sure these numbers are correct?

Well, here's the start of the thread...

http://www.merit.edu/mail.archives/nanog/2004-05/msg00144.html

Anywhere from 12% to 45% depending which methodology you believe in.. ;)

> I think the MD5 option is designed to be processed *before* semantic
> analysis of the TCP header.  This way, it will protect the router in
> case of TCP header parsing bugs.  So it's not "Very Very Wrong", just
> a different trade-off.

I saw several people who dropped hints that if it had an MD5 on it,
it got handed to the CPU for checking, without even bothering to verify
that the source IP was something you had an MD5 configured for.. "Hey, this
MD5 is borked! Good thing it's not from a host we talk to...." :)


--==_Exmh_-1796366355P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA4eMLcC3lWbTT17ARAhqHAJ9elYIyMVwqc9yj49shPxTuHqiszQCfR8VK
KbX4nH2kywqfSb1UHd1hMGY=
=gPFO
-----END PGP SIGNATURE-----

--==_Exmh_-1796366355P--
