Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTIKOTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbTIKOTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:19:49 -0400
Received: from h80ad26f8.async.vt.edu ([128.173.38.248]:29834 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261152AbTIKOTs (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:19:48 -0400
Message-Id: <200309111419.h8BEJbSo010948@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Breno Silva <brenosp@brasilsec.com.br>
Cc: Stan Bubrouski <stan@ccs.neu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Size of Tasks during ddos 
In-Reply-To: Your message of "Thu, 11 Sep 2003 09:33:41 -0300."
             <009201c37860$f0d3c5f0$131215ac@poslab219> 
From: Valdis.Kletnieks@vt.edu
References: <001b01c39047$d65cf580$f8e4a7c8@bsb.virtua.com.br> <20030911002755.GA13177@triplehelix.org> <3F5FD993.2060900@ccs.neu.edu>
            <009201c37860$f0d3c5f0$131215ac@poslab219>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-28858842P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 11 Sep 2003 10:19:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-28858842P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2003 09:33:41 -0300, Breno Silva said:

> My servers are in ddos attack , what i=B4d like to know is about size o=
f tasks
> in memory during this kind of attack. I have some ideas to do in my ker=
nel.

The answer will differ depending whether (for example) you're being ICMP
flooded, SYN-flooded, hit with a mass of HTTP 'GET /' commands, hit with =
a mass
of HTTP commands that invoke a resource-intensive CGI like a database sea=
rch,
and so on.

We'd really need to know what the traffic involved in the DDoS is in orde=
r to
be able to comment on memory usage.


--==_Exmh_-28858842P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/YIR4cC3lWbTT17ARAtZCAJ9Quy7uCPnCg2T/z00qSiCt94F5sgCfZ6GN
M8E0O+Y33wFQ94x+xuJQg9s=
=cckN
-----END PGP SIGNATURE-----

--==_Exmh_-28858842P--
