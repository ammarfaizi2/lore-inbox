Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbTDAV1G>; Tue, 1 Apr 2003 16:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262651AbTDAV1G>; Tue, 1 Apr 2003 16:27:06 -0500
Received: from smtp-out.comcast.net ([24.153.64.115]:41685 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S262648AbTDAV1E>;
	Tue, 1 Apr 2003 16:27:04 -0500
Date: Tue, 01 Apr 2003 16:25:40 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: Re: ptrace patch fails stress testing
In-reply-to: <20030401122256.A34952@forte.austin.ibm.com>
To: linas@austin.ibm.com
Cc: alan@lxorguk.ukuu.org.uk, linas@linas.org, ppc@suse.de,
       linux-kernel@vger.kernel.org
Message-id: <20030401212540.GB7837@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=DocE+STaALJfprDB;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <20030401122256.A34952@forte.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2003 at 12:22:56PM -0600, linas@austin.ibm.com wrote:
> I've got a number of machines here that crash after installing
> the recent ptrace fix.  The crash only occurrs when machines=20
> are highly stressed.

i've seen suspicious behaviour since installing the ptrace patch as
well, but i couldn't really narrow it down to anything, as i have
absolutely nothing of interest in logs.  i just login during the day
and notice that it had rebooted itself (uncleanly) over night at
around 3-5am.  this is when the disk-intensive nightly stuff happens,
like some backups, updatedb, etc.

i was starting to suspect power issues, since i never see oopses in
logs.

this is a dual athlon box.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+igPUCGPRljI8080RAtMqAJ9wM6j0c9o6Py/SQknjJePMNSr+XgCfaDWD
xbyZ/IK5Ln1bqXWC+TXqppI=
=yINi
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
