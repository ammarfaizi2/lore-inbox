Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUDEW0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUDEWXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:23:32 -0400
Received: from mailrelay03.sunrise.ch ([194.158.229.31]:25503 "EHLO
	obelix.spectraweb.ch") by vger.kernel.org with ESMTP
	id S263503AbUDEWUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:20:00 -0400
Date: Tue, 6 Apr 2004 00:19:40 +0200
From: Olivier Bornet <Olivier.Bornet@puck.ch>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5, ACPI, suspend and ThinkPad R40
Message-ID: <20040405221940.GA17419@puck.ch>
Mail-Followup-To: Olivier Bornet <Olivier.Bornet@puck.ch>,
	Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040404173646.GA15635@puck.ch> <40708569.7060403@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <40708569.7060403@stud.feec.vutbr.cz>
X-From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Url: http://puck.ch/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 05, 2004 at 12:00:09AM +0200, Michal Schmidt wrote:
> Yes, see:
>   http://bugzilla.kernel.org/show_bug.cgi?id=3D1415
> There is a patch which worked for me.

Thanks a lot. :-) This patch is working as expected for me. Now, after
doing a:

  echo LID > /proc/acpi/wakeup_devices
  echo SLPB > /proc/acpi/wakeup_devices

I can resume by opening the laptop, or by using the Fn button, or by
using the power button. :-)

This patch seems "very" old (first release 2003-10-28).

Anyone know why this patch is not in the kernel source tree at this
time ?

Good day, and thanks for your help.

		Olivier
--=20
Olivier Bornet                |    fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results      |    english  : http://puck.ch/e
http://puck.ch/               |    deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch        |    italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://pgp.mit.edu/

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcdt8dj3R/MU9khgRAhY5AJ0VPhImC7pVewHZglsZeorDqWkFSgCg5UfS
ACrvSsyVbjdGIpYKOWbetew=
=fbXJ
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
