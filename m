Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132771AbRDDI1V>; Wed, 4 Apr 2001 04:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132772AbRDDI1L>; Wed, 4 Apr 2001 04:27:11 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:64269 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132771AbRDDI05>; Wed, 4 Apr 2001 04:26:57 -0400
Date: Wed, 4 Apr 2001 09:26:10 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Juan <piernas@ditec.um.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SOLVED]Re: 2.2.19 && ppa: total lockup. No problem with 2.2.17
Message-ID: <20010404092610.P9355@redhat.com>
In-Reply-To: <20010330152921.Q10553@redhat.com> <Pine.LNX.4.21.0103310156530.23634-100000@ditec.um.es> <20010403173839.I9355@redhat.com> <3ACA55D5.FC2E444C@ditec.um.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="i7KxW38SoMauyveo"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACA55D5.FC2E444C@ditec.um.es>; from piernas@ditec.um.es on Wed, Apr 04, 2001 at 12:59:33AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i7KxW38SoMauyveo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 04, 2001 at 12:59:33AM +0200, Juan wrote:

> I have the same problem in two different machines but they both are UP.
> However, my kernel configuration has SMP support enabled.

Could you build a kernel without SMP support and see if the problem
still happens?

> options parport_pc io=0x378 irq=7

You could remove this line, just to see if it makes a difference (it
shouldn't, but it might).

> I stop klogd and syslogd services (that causes to display all kernel
> messages on screen, doesn't it?

Better is something like 'dmesg -n 8'.

Thanks,
Tim.
*/

--i7KxW38SoMauyveo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ytqiONXnILZ4yVIRAi2hAKCdG5STL5jOvzIi/XuXPc103kSPxQCfUpeQ
zHOG6/dz+o5EVPH050Bs41s=
=aMoH
-----END PGP SIGNATURE-----

--i7KxW38SoMauyveo--
