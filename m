Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263841AbVBDVuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263841AbVBDVuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbVBDVtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:49:42 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:18580 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S264530AbVBDVed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:34:33 -0500
Message-ID: <4203EA83.4020509@arcor.de>
Date: Fri, 04 Feb 2005 22:34:59 +0100
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050121)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 051 release
References: <20050203180528.GB24742@kroah.com>
In-Reply-To: <20050203180528.GB24742@kroah.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE43EB48FA5627FBF3E328195"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE43EB48FA5627FBF3E328195
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

would you consider adding these rules to your default udev rules:

KERNEL="dvb[0-9].dvr*",        NAME="dvb/adapter%n/dvr%n", GROUP="video"
KERNEL="dvb[0-9].demux*",      NAME="dvb/adapter%n/demux%n", GROUP="video"
KERNEL="dvb[0-9].frontend*",   NAME="dvb/adapter%n/frontend%n", GROUP="video"
KERNEL="dvb[0-9].audio*",      NAME="dvb/adapter%n/audio%n", GROUP="video"
KERNEL="dvb[0-9].ca*",         NAME="dvb/adapter%n/ca%n", GROUP="video"
KERNEL="dvb[0-9].osd*",        NAME="dvb/adapter%n/osd%n", GROUP="video"
KERNEL="dvb[0-9].net*",        NAME="dvb/adapter%n/net%n", GROUP="video"
KERNEL="dvb[0-9].video*",      NAME="dvb/adapter%n/video%n", GROUP="video"

I guess DVD users would appreciate this.

Thanks !

--
Prakash Punnoor

formerly known as Prakash K. Cheemplavam


--------------enigE43EB48FA5627FBF3E328195
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCA+qGxU2n/+9+t5gRAspkAJ0cALr2OwRBWAYTOoRErHtp8nFL8QCcDOgU
XoOJTU3U7amQAfUkdcYyDTs=
=ZUb1
-----END PGP SIGNATURE-----

--------------enigE43EB48FA5627FBF3E328195--
