Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271852AbTGYBMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 21:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271885AbTGYBMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 21:12:32 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:33798 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S271852AbTGYBMb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 21:12:31 -0400
Date: Thu, 24 Jul 2003 18:27:24 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Ben Collins <bcollins@debian.org>, gaxt <gaxt@rogers.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725012723.GF23196@ruvolo.net>
Mail-Followup-To: Torrey Hoffman <thoffman@arnor.net>,
	Ben Collins <bcollins@debian.org>, gaxt <gaxt@rogers.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux firewire devel <linux1394-devel@lists.sourceforge.net>
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
In-Reply-To: <1059095616.1897.34.camel@torrey.et.myrio.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 24, 2003 at 06:13:37PM -0700, Torrey Hoffman wrote:
> Sometimes the driver seems to go into an loop of "unsolicted packet
> received" messages and attempted resets.  Here's what the log looks like
> when that happens:  (this was on 2.5.75)
[..]
> (this sequence repeats until I turn off or unplug the drive.)

This sounds like what happens to me when I turn on my DV cam.  CPU usage
goes up to 40% kernel and loops like that until the device goes off.

What hardware do you have?  lspci?

Marcello's latest 2.4.22-pre8 updates to rev 1010 of the 1394 modules, so
I'm curious if I can reproduce this in 2.4 now.

-Chris

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IId7KO6EG1hc77ERAutEAJwOhPKJlkjCZIZTkiKXGun9BwmVsQCeMM2H
BhQoxHGfNEw0S4QmCVqcQpk=
=gB+c
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
