Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVASUnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVASUnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVASUnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:43:03 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:44037 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261883AbVASUm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:42:58 -0500
Message-Id: <200501192042.j0JKgPTW024711@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues 
In-Reply-To: Your message of "Wed, 19 Jan 2005 15:12:05 EST."
             <41EEBF15.9050700@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <1106157152.6310.171.camel@laptopd505.fenrus.org> <41EEABEF.5000503@comcast.net> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>
            <41EEBF15.9050700@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106167343_1885P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jan 2005 15:42:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106167343_1885P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jan 2005 15:12:05 EST, John Richard Moser said:

> > And why were they merged?  Because they showed up in 4-8K chunks.

> so you want 90-200 split out patches for GrSecurity?

Even better would be a 30-40 patch train for PaX, a 10-15 patch train
for the other randomization stuff in grsecurity (pid, port number, all
the rest of those), a 50-60 patch train for the RBAC stuff, and so on.

Keep in mind that properly segmented, *parts* of grsecurity have at least
a fighting chance - the fact that (for instance) mainline may reject the
way RBAC is implemented because it's not LSM-based doesn't mean that you
shouldn't at least try to get the PaX stuff in, and the randomization stuff,
and so on.



--==_Exmh_1106167343_1885P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB7sYvcC3lWbTT17ARAur8AJ9umjcqWka7MFG8oI7RajDNK5bfVACg+bF6
XpITnsnBBboK8YkGueI6krk=
=C8T3
-----END PGP SIGNATURE-----

--==_Exmh_1106167343_1885P--
