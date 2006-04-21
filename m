Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWDUUGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWDUUGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWDUUGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:06:53 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60811 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932385AbWDUUGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:06:53 -0400
Message-Id: <200604212006.k3LK6LtH015500@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview 
In-Reply-To: Your message of "Fri, 21 Apr 2006 14:07:33 EDT."
             <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> 
From: Valdis.Kletnieks@vt.edu
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org>
            <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145649981_14107P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Apr 2006 16:06:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145649981_14107P
Content-Type: text/plain; charset=us-ascii

On Fri, 21 Apr 2006 14:07:33 EDT, Stephen Smalley said:
> On Fri, 2006-04-21 at 10:30 -0700, Chris Wright wrote:
> > * Stephen Smalley (sds@tycho.nsa.gov) wrote:
> > > Difficult to evaluate, when the answer whenever a flaw is pointed out is
> > > "that's not in our threat model."  Easy enough to have a protection
> > > model match the threat model when the threat model is highly limited
> > > (and never really documented anywhere, particularly in a way that might
> > > warn its users of its limitations).
> > 
> > I know, there's two questions.  Whether the protection model is valid,
> > and whether the threat model is worth considering.  So far, I've not
> > seen anything that's compelling enough to show AppArmor fundamentally
> > broken.  Ugly and inefficient, yes...broken, not yet.
> 
> Access control of any form requires unambiguous identification of
> subjects and objects in the system.   Paths don't achieve such
> identification.  Is that broken enough?  If not, what is?  What
> qualifies as broken?

I'd be willing to at least *listen* to an argument of the form "paths are
in general broken, but we have constraints X, Y, and Z on the system such
that the broken parts never manifest" (for instance, a restriction on
hardlinks that prevents hardlinking 2 files unless the resulting security
domains of the two paths would be identical).

However, I'll say up front that such an argument would only suffice to
move it from "broken" to "very brittle in face of changes" (for instance,
would such a hardlink restriction cause collateral damage that an attacker
could exploit?  How badly does it fail in the face of a misdesigned policy?)

--==_Exmh_1145649981_14107P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD0DBQFESTs9cC3lWbTT17ARAv5UAJj8+0pil8b4vjUt0pNDL+SqoJT0AJj5UfXg
EHOuJ1zvK/d8DDMFc9mw
=Hb+1
-----END PGP SIGNATURE-----

--==_Exmh_1145649981_14107P--
