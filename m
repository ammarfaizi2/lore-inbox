Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVASUpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVASUpe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVASUpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:45:34 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47884 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261885AbVASUpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:45:19 -0500
Message-Id: <200501192044.j0JKiwJ2005994@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Arjan van de Ven <arjan@infradead.org>
Cc: John Richard Moser <nigelenki@comcast.net>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues 
In-Reply-To: Your message of "Wed, 19 Jan 2005 20:53:51 +0100."
             <1106164432.6310.195.camel@laptopd505.fenrus.org> 
From: Valdis.Kletnieks@vt.edu
References: <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <1106157152.6310.171.camel@laptopd505.fenrus.org> <41EEABEF.5000503@comcast.net> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>
            <1106164432.6310.195.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106167498_1885P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jan 2005 15:44:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106167498_1885P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jan 2005 20:53:51 +0100, Arjan van de Ven said:

> > Now look at http://www.kernel.org/pub/linux/kernel/people/arjan/execshield/
.
> > 4 separate hunks, the biggest is under 7K.  Other chunks of similar size
> > for non-exec stack and NX support are already merged.
> > 
> > And why were they merged?  Because they showed up in 4-8K chunks.
> >   
> note to readers: I'm still not happy about the split up and want to
> split this up even further in smaller pieces; the split up there is only
> a first order split.

Right - the point is that even an idiot like me can get my head wrapped around
that biggest 7K chunk and figure out what's going on.  On the other hand, even
the Alan Cox gnome-cluster isn't able to digest a 280K patch...


--==_Exmh_1106167498_1885P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB7sbKcC3lWbTT17ARAhfDAKCC7+/enOdRUmsQi3sh/L9y7v+OGwCgkaWv
XOIghQrCAEYVZQvG8s932rE=
=kMpQ
-----END PGP SIGNATURE-----

--==_Exmh_1106167498_1885P--
