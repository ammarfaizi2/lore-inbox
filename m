Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318162AbSG2VBd>; Mon, 29 Jul 2002 17:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318163AbSG2VBc>; Mon, 29 Jul 2002 17:01:32 -0400
Received: from codepoet.org ([166.70.99.138]:44192 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318162AbSG2VBb>;
	Mon, 29 Jul 2002 17:01:31 -0400
Date: Mon, 29 Jul 2002 15:04:53 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Grendel <grendel@thanes.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3-ac4
Message-ID: <20020729210453.GA4770@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Grendel <grendel@thanes.org>, Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200207291740.g6THewQ19578@devserv.devel.redhat.com> <20020729204424.GA4449@codepoet.org> <20020729205147.GB1722@thanes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20020729205147.GB1722@thanes.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon Jul 29, 2002 at 10:51:47PM +0200, Grendel wrote:
> On Mon, Jul 29, 2002 at 02:44:25PM -0600, Erik Andersen scribbled:
> [snip]
> > The problem seems to be that=20
> >     DRM_ERROR( "no scatter/gather memory!\n" );
> >=20
> > expands into
> >     printk("<3>"  "[" "drm"  ":%s] *ERROR* "   "cannot allocate PCI GAR=
T page!\n"   ,  ) ;
> >=20
> > I think the __FUNCTION__ changes to DRM_ERROR and friends in drmP.h=20
> > look awfully bogus.
> Nope, it's a cpp (3.0+ is fine) error - the ##args is not generated corre=
ctly when
> 'args...' in DRM_ERROR is empty.

Yes I know.  And the problem occurs as a result of moving=20
__FUNCTION__ out of the format string,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Ra30X5tkPjDTkFcRAk28AJ931HvqvOA3mk1+yE5tUGvQRlxyWwCff65B
39KkOuxkAAwxKujlPi0JFD0=
=sWQz
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
