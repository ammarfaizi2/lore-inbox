Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264616AbTKNRv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbTKNRvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:51:25 -0500
Received: from h80ad279b.async.vt.edu ([128.173.39.155]:31362 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264616AbTKNRvQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:51:16 -0500
Message-Id: <200311141750.hAEHoUI2023152@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Harald Welte <laforge@gnumonks.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [2.6] Nonsense-messages from iptables + co. 
In-Reply-To: Your message of "Fri, 14 Nov 2003 16:10:04 +0100."
             <20031114151004.GE2395@obroa-skai.de.gnumonks.org> 
From: Valdis.Kletnieks@vt.edu
References: <20031114132054.GA646@merlin.emma.line.org>
            <20031114151004.GE2395@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1451045386P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Nov 2003 12:50:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1451045386P
Content-Type: text/plain; charset=us-ascii

On Fri, 14 Nov 2003 16:10:04 +0100, Harald Welte said:
> > "ipt_hook: happy cracking."
> 
> I guess it was Rusty.  The idea message is a funny way of telling you
> that you are sending incomplete ip headers.  Something that is not
> likely to occur unless you are trying to send corrupt packets via raw ip
> sockets...

Actually, once I found the message, and saw the context, it was actually
clear and self-explanatory. It was actually the ipfilter code's fault
that it got generated in any context other than "trying to send an intentionall
busticated packet"...

> There are people who do actually have fun developing linux code.  And
> Rusty has a peculiar sense of humor... for further reference see the
> comments like 'furniture shopping' throughout the netfilter/iptables
> source code.  I sometimes wish I had the same humor like he has.

find arch/sparc* -name '*.[ch]'| xargs grep -i penguin

and then read through the files that finds (trap.c is particularly fun).

Somebody was having fun porting. ;)


--==_Exmh_1451045386P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/tRXmcC3lWbTT17ARAsrwAKCRKRKpj9ojXpJtaohQWKIWdubgAQCcDfqA
5AQ0hTzUU9nVa/I7jgI+HFo=
=WUIQ
-----END PGP SIGNATURE-----

--==_Exmh_1451045386P--
