Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132626AbRDGKPS>; Sat, 7 Apr 2001 06:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132627AbRDGKPA>; Sat, 7 Apr 2001 06:15:00 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:62454 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132626AbRDGKOr>; Sat, 7 Apr 2001 06:14:47 -0400
Date: Sat, 7 Apr 2001 11:14:19 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Michael Reinelt <reinelt@eunet.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
Message-ID: <20010407111419.B530@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACED679.7E334234@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Apr 07, 2001 at 04:57:29AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 07, 2001 at 04:57:29AM -0400, Jeff Garzik wrote:

> Where is this patch available?  I haven't heard of an extension to the
> pci id tables, so I wonder if it's really in the queue for the official
> kernel.

It is.  <URL:http://people.redhat.com/twaugh/patches/>  The
'extension' is just 'more entries', AFAIR.

> > I'm afraid this is not a bug, but a design issue, and will be hard to
> > solve. Maybe we need a flag for such devices which allows it to be
> > claimed ba more thean one driver?
>=20
> Not so hard.

*sigh* Jeff, when I spoke to you about this last year you said
 'tough', or words to that effect. :-(

> There is no need to register more than one driver per PCI device -- just
> create a PCI driver whose probe routine registers serial and parallel,
> and whose remove routine unregisters same.

*cough* modularity *cough*

Wnat to show us some elegant code that does that?

Tim.
*/

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6zuh6ONXnILZ4yVIRAkWfAJ94AtMUGzhwusuXJAOVm3Y2ocQNQQCfXY0k
DrDsrWXWz4MOAAeEyc67s6U=
=+Vz7
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
