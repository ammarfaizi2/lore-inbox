Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVATS6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVATS6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVATS4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:56:40 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:26897 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261383AbVATSzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:55:33 -0500
Message-Id: <200501201853.j0KIrVEi005212@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues 
In-Reply-To: Your message of "Thu, 20 Jan 2005 13:16:33 EST."
             <41EFF581.6050108@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu> <41EEA86D.7020108@comcast.net> <20050120104451.GE12665@elte.hu>
            <41EFF581.6050108@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106247209_12559P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Jan 2005 13:53:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106247209_12559P
Content-Type: text/plain; charset=us-ascii

On Thu, 20 Jan 2005 13:16:33 EST, John Richard Moser said:

> > 1) the halving of the per-process VM space from 3GB to 1.5GB.

> Which has *never* caused a problem in anything I've ever used, and can
> be disabled on a per-process basis.

Just because something has never caused *you* a problem doesn't mean that
it's suitable for inclusion in something like RedHat where it's almost
certain to cause a problem for *some* user.

> > [ 3) requires manual tagging of applications. ]
> > 
> 
> Good.  Maybe distributors will actually know what they're talking about
> when flapping their mouths, rather than say "Oh look PaX it's magic so
> we just need to turn it on!"  Even I (at user level) examine everything
> I'm using and try to understand it; I don't expect all users to do this,
> but the distribution has to.

OK.. but then you say...

> PT_GNU_STACK is actually explicitly disabled -- apparently this is hard
> work, as my distribution can't seem to always keep up with it or get it
> quite right.

Can you explain why your distro has difficulty getting PT_GNU_STACK 100%
right, but you expect them to get tagging of apps with a flag that has
almost identical semantics to PT_GNU_STACK correct?



--==_Exmh_1106247209_12559P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB7/4pcC3lWbTT17ARAmC7AJ9UacRI7qqWQpcv8F5GusDAhYbbXQCeNU+W
CfLtaLG95JcoH2EKVWkKh1U=
=wng4
-----END PGP SIGNATURE-----

--==_Exmh_1106247209_12559P--
