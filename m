Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVAYU6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVAYU6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVAYUzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:55:54 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:36107 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262117AbVAYUyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:54:33 -0500
Message-Id: <200501252053.j0PKr3G4022890@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: dtor_core@ameritech.net, Linus Torvalds <torvalds@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues 
In-Reply-To: Your message of "Tue, 25 Jan 2005 14:56:13 EST."
             <41F6A45D.1000804@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org> <41F691D6.8040803@comcast.net> <d120d50005012510571d77338d@mail.gmail.com>
            <41F6A45D.1000804@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106686383_3966P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jan 2005 15:53:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106686383_3966P
Content-Type: text/plain; charset=us-ascii

On Tue, 25 Jan 2005 14:56:13 EST, John Richard Moser said:

> This puts pressure on the attacker; he has to find a bug, write an
> exploit, and find an opportunity to use it before a patch is written and
> applied to fix the exploit.  If say 80% of exploits are suddenly
> non-exploitable, then he's left with mostly very short windows that are
> far and few, and thus may be beyond his level of UNION(task->skill,
> task->luck) in many cases.

Correct.


> If you can circumvent protection A by simply using attack B* to disable
> protection A to do more interesting attack A*, then protection A is
> smoke and mirrors. 

You however missed an important case here.  If attack B is outside 
UNTION(task->skill,  task->luck) protection A is *NOT* smoke-and-mirrors.

And for the *vast* majority of attackers, if they have a canned exploit for
A and it doesn't work, they'll be stuck because B is outside their ability.

--==_Exmh_1106686383_3966P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB9rGvcC3lWbTT17ARAkkKAKCUOiUBcuk97bnhKopkS7BlRz947gCgor5l
8TwYtwhumkigdu85g9xG6/o=
=oI50
-----END PGP SIGNATURE-----

--==_Exmh_1106686383_3966P--
