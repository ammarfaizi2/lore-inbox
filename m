Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbRDGTJW>; Sat, 7 Apr 2001 15:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRDGTJN>; Sat, 7 Apr 2001 15:09:13 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:45870 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130317AbRDGTJE>; Sat, 7 Apr 2001 15:09:04 -0400
Date: Sat, 7 Apr 2001 20:08:56 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Michael Reinelt <reinelt@eunet.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
Message-ID: <20010407200856.E3280@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <3ACEFB05.C9C0AB3C@eunet.at> <20010407131631.A3280@redhat.com> <3ACF4D0F.9D15EB7F@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACF4D0F.9D15EB7F@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Apr 07, 2001 at 01:23:27PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 07, 2001 at 01:23:27PM -0400, Jeff Garzik wrote:

> You asked in your last message to show you code, here is a short
> example.  Note that I would love to rip out the SUPERIO code in parport
> and make it a separate driver like this short, contrived example.  Much
> more modular than the existing solution.

(The superio code is on its way out anyway, for different reasons..)

More modular?  Yes, it adds another module to support a card, so yes
there are more modules.

But with the multifunction_quirks approach, support is a question of
adding two lines in a table.

Tim.
*/

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6z2XHONXnILZ4yVIRAp74AJ9a+4R8lm+6LS1SJ0w+44hCs7zIvACeOb7m
acZkZtN6nwZmnpF21QC16zw=
=nh57
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
