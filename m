Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUCKQzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUCKQzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:55:12 -0500
Received: from linux.us.dell.com ([143.166.224.162]:10414 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261533AbUCKQzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:55:03 -0500
Date: Thu, 11 Mar 2004 10:54:39 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 no boot report
Message-ID: <20040311165439.GC6173@lists.us.dell.com>
References: <043MWM712@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <043MWM712@server5.heliogroup.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 11, 2004 at 04:32:31PM +0000, Hubert Tonneau wrote:
> I've successfully run Linux kernel 2.6 on several boxes, with the excepti=
on
> of the Dell PowerEdge 2600:
> The box is:
> . dual Xeon
> . Fusion SCSI controler
> . root partition is software RAID 1
> . Intel pro 1000 ethernet
>=20
> It fails with all 2.6 kernel I tried, including the fresh 2.6.4
> No error message at all, the machine just freezes after displaying network
> protocols and before displaying VFS root mounting message.
>=20
> CONFIG_2GB:  y
> CONFIG_APM:  y

Might it be failing initializing APM?  You might try disabling APM, or
pass 'apm=3Doff' on the kernel command line and see if that helps.  This
is a server, and APM isn't specifically tested.  We've seen this
problem on other platforms recently.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAUJnPIavu95Lw/AkRAoTzAKCI8cEVTjLwEiviqYa/O4A/DGnwgACcDaKP
3GsgG5+6bCpNWI2X1tguEH0=
=H94e
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
