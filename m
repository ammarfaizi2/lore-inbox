Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTDIWLb (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTDIWLb (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:11:31 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:772 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263969AbTDIWLa (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 18:11:30 -0400
Date: Wed, 09 Apr 2003 18:21:27 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: 2.5.67 scheduling still erratic
To: linux-kernel@vger.kernel.org
Message-id: <20030409222126.GA4402@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=SLDf9lqlvOQaIe6s;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

the cpu starvation issues seem to have cleared a little, but i'm still
seeing issues.

everytime a larger process wakes up, like java gc (jboss) or xfree86
server (especially while switching desktops), mpg123 and/or esd's
audio output gets interrupted and pops.  vmstat shows no swapping,
just spikes in user cpu.  while rapidly switching desktops, audio can
be delayed for seconds at a time, interrupt count drops slightly (i
guess since no audio), and context switches can double.

are there proc knobs to adjust to alleviate this? =20
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+lJzmCGPRljI8080RArd3AJ9DbxKheQ8upqslxCVLGxsek0MJ1QCeJ5/M
RtwiAtqyS+VbcrQFrummuRk=
=Mnd0
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
