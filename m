Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVAMUeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVAMUeb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVAMUbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:31:45 -0500
Received: from grendel.firewall.com ([66.28.58.176]:42657 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261438AbVAMU3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:29:06 -0500
Date: Thu, 13 Jan 2005 21:29:05 +0100
From: Marek Habersack <grendel@caudium.net>
To: Chris Wright <chrisw@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113202905.GD24970@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113115004.Z24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <20050113115004.Z24171@build.pdx.osdl.net>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2005 at 11:50:04AM -0800, Chris Wright scribbled:
> * Marek Habersack (grendel@caudium.net) wrote:
> > On Thu, Jan 13, 2005 at 03:36:27PM +0000, Alan Cox scribbled:
> > > On Mer, 2005-01-12 at 17:42, Marcelo Tosatti wrote:
> > > > The kernel security list must be higher in hierarchy than vendorsec.
> > > >=20
> > > > Any information sent to vendorsec must be sent immediately for the =
kernel
> > > > security list and discussed there.
> > >=20
> > > We cannot do this without the reporters permission. Often we get
> > I think I don't understand that. A reporter doesn't "own" the bug - not=
 the
> > copyright, not the code, so how come they can own the fix/report?
>=20
> It's not about ownership.  It's about disclosure and common sense.
> If someone reports something to you in private, and you disclose it
> publically (or even privately to someone else) without first discussing
> that with them, you'll lose their confidence.  Consequently they won't
> be so kind to give you forewarning next time.
I understand that, but I don't see a point in holding the fixes back for the
majority of people (since the vendors on vendor-sec are a minority and I
suspect that more people run self-compiled kernels on their servers than the
vendor kernels, I might be wrong on that). If there is a list that's at
least half-open (i.e. invitation required, but no CV required :) then there
is no issue of confidence, is there? And with such list, everybody has
equal chances - bad, good and the ugly too. Maybe my logic is flawed, but
that's how I see it - the linux kernel is a piece of open code, accessible
to all, with all its features, bugs, flaws. So, if the code is open, the
reports about the code security/bugs should be as open, together with fixes,
=66rom the day one of finding the bug. Otherwise, if we have the scenario w=
hen
the vendor-sec members are informed about a bug+fix 2 months earlier and the
vulnerability+fix are disclosed 2 months later, then this is creating a
situation where not everybody has equal chances of reacting to the bug. As I
wrote earlier, that puts the folks using non-vendor kernels way behind both
the vendors _and_ the bad guys - since the latter have both the
vulnerability, the fix _and_ (usually) the exploit (or they can come up with
it in a matter of hours). For me it's all about equal chances in reacting to
the security issues. Again, I might be totally wrong in my reasoning, feel
free to correct me.

> > > material that even the list isn't allowed to directly see only by
> > > contacting the relevant bodies directly as well. The list then just
> > > serves as a "foo should have told you about issue X" notification.
> > This sounds crazy. I understand that this may happen with proprietary
> > software, or software that is made/supported by a company but otherwise=
 opensource
> > (like OpenOffice, for instance), but the kernel?
>=20
> Licensing is irrelevant.  Like it or not, the person who is discovering
> the bugs has some say in how you deal with the information.  It's in our
> best interest to work nicely with these folks, not marginalize them.
It's not about marginalizing, because by requesting that their report is
kept secret for a while and known only to a small bunch of people, you could
say they are marginalizing us, the majority of people who use the linux
kernel (us - those who aren't on the vendor-sec list). It's, again IMHO,
about equal chances. More and more often it seems that security advisories
and releases are treated as an asset for security companies, not a common
good/knowledge. And that's pretty sad...

regards,

marek

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5toRq3909GIf5uoRAhViAJ0VWPE+Fg8tCJg5K+SY3cMRNh5ZngCbBHML
e06f+fEgennUjqTzT5CGnJw=
=5SqZ
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
