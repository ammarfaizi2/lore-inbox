Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRJPKAF>; Tue, 16 Oct 2001 06:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275853AbRJPJ74>; Tue, 16 Oct 2001 05:59:56 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:7751 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S275693AbRJPJ7j>; Tue, 16 Oct 2001 05:59:39 -0400
Date: Tue, 16 Oct 2001 11:00:10 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Enver Haase <ehaase@inf.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Parport PCI card doesn't share IRQ
Message-ID: <20011016110010.W13359@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10110161156410.1239-100000@haneman.hacenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Wt10+cXOThorkX0z"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10110161156410.1239-100000@haneman.hacenet>; from ehaase@inf.fu-berlin.de on Tue, Oct 16, 2001 at 12:03:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Wt10+cXOThorkX0z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 16, 2001 at 12:03:01PM +0200, Enver Haase wrote:

> Communication controller: PCI device 9710:9815 (rev 1).

A NetMos card; currently not supported because of reported crashes
with the experimental support.

> here, and it runs fine as long as you don't try to share its
> IRQ. Maybe related: "cat /proc/interrupts" does not show the card is
> on IRQ 11 --- so when I put my NE2000 clone network card _also_ on
> IRQ 11, the system hangs as soon as the card is used,
> i.e. ifconfig'ed.

In general, interrupt use at all with parallel port PCI cards is not
implemented yet; it might work for some people, but for others it
might not.

I think it needs someone knowledgeable to go through the code and fix
the bugs. :-(

Tim.
*/

--Wt10+cXOThorkX0z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7zAUpyaXy9qA00+cRAqqAAKCaedOhwO/DD1gmgs9K7qIUPDvfdACgt5Sl
eE37I4Ajcbaz78ya7EKCmS4=
=04Tn
-----END PGP SIGNATURE-----

--Wt10+cXOThorkX0z--
