Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSIYPER>; Wed, 25 Sep 2002 11:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261999AbSIYPER>; Wed, 25 Sep 2002 11:04:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27274 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S261996AbSIYPEQ>; Wed, 25 Sep 2002 11:04:16 -0400
Date: Wed, 25 Sep 2002 16:09:15 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Steve Underwood <steveu@coppice.org>, linux-kernel@vger.kernel.org
Subject: Re: USB IEEE1284 gadgets and ppdev
Message-ID: <20020925150915.GM9457@redhat.com>
References: <3D90831A.7060709@coppice.org> <20020924162130.GE9457@redhat.com> <3D91BF58.8080803@coppice.org> <20020925142757.GL9457@redhat.com> <20020925150129.GC30339@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6s2ZrHmC7gitT33w"
Content-Disposition: inline
In-Reply-To: <20020925150129.GC30339@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6s2ZrHmC7gitT33w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 25, 2002 at 08:01:29AM -0700, Greg KH wrote:

> I understand that the uss720 driver should register with parport, as
> it is a USB to parallel port adapter, but the usblp driver should
> not, as it is just a pass-through to a printer.  Do you see any
> advantage to having usblp registering with parport?

Well, it would mean that ppdev could use it.  I understand that only a
few functions of a normal parallel port could be implemented (read,
write, get status).

Alternatively I suppose I could get libieee1284 to grok /dev/usb/lp*.
Steve---would that solve the problem that you're running into?

Tim.
*/

--6s2ZrHmC7gitT33w
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9kdGbtO8Ac4jnUq4RAsizAJ98va3psSXG8WYbtNg/TI/QBYyfGwCfSre6
cinWaEthqfMftrHtbrrWAeQ=
=Z+Mb
-----END PGP SIGNATURE-----

--6s2ZrHmC7gitT33w--
