Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132039AbRDCQjr>; Tue, 3 Apr 2001 12:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132223AbRDCQjg>; Tue, 3 Apr 2001 12:39:36 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:31703 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132039AbRDCQj2>; Tue, 3 Apr 2001 12:39:28 -0400
Date: Tue, 3 Apr 2001 17:38:39 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Juan Piernas Canovas <piernas@ditec.um.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SOLVED]Re: 2.2.19 && ppa: total lockup. No problem with 2.2.17
Message-ID: <20010403173839.I9355@redhat.com>
In-Reply-To: <20010330152921.Q10553@redhat.com> <Pine.LNX.4.21.0103310156530.23634-100000@ditec.um.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103310156530.23634-100000@ditec.um.es>; from piernas@ditec.um.es on Sat, Mar 31, 2001 at 01:59:39AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 31, 2001 at 01:59:39AM +0200, Juan Piernas Canovas wrote:

> Yes!!!. It works. I am happy now :-)

Unfortunately, the problem isn't solved, merely worked around.  We
need to figure out why this is happening in the first place.

To recap, the system hangs completely when you load the ppa module.

Are you using any special parport/ppa parameters?  Is this an SMP or a
uniprocessor machine?  Come to that, which architecture is it?

Are there any messages displayed to the console when the hang happens?
If you could scatter some printks around (KERN_CRIT so they show up on
the console) to figure out the example point at which it's hanging,
that would be great.

Thanks,
Tim.
*/

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6yfyOONXnILZ4yVIRApwIAJ9qLRFg9xs1bffzJRwM0a9Rhol+iACZAeB0
Mxm9npprNmTos0kc1Wq8uiY=
=FSN/
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--
