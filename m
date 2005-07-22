Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVGVM5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVGVM5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 08:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVGVM5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 08:57:22 -0400
Received: from ns.snowman.net ([66.92.160.21]:17794 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id S261257AbVGVM5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 08:57:20 -0400
Date: Fri, 22 Jul 2005 08:57:32 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Jakob Oestergaard <jakob@unthought.net>,
       Christoph Pleger <Christoph.Pleger@uni-dortmund.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 10 GB in Opteron machine
Message-ID: <20050722125732.GN24207@ns.snowman.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Christoph Pleger <Christoph.Pleger@uni-dortmund.de>,
	linux-kernel@vger.kernel.org
References: <20050722105516.6ccffb8f.Christoph.Pleger@uni-dortmund.de> <42E0B6E4.1030303@pobox.com> <20050722113138.5d81c770.Christoph.Pleger@uni-dortmund.de> <20050722103955.GI30510@unthought.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adbRXwaWUtRVaP/r"
Content-Disposition: inline
In-Reply-To: <20050722103955.GI30510@unthought.net>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 08:51:42 up 41 days,  5:10,  6 users,  load average: 0.00, 0.06, 0.04
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--adbRXwaWUtRVaP/r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Jakob Oestergaard (jakob@unthought.net) wrote:
> This is really the clever way to run a 64-bit system - 99% of what is
> commonly run on most systems only gains overhead from the 64-bit address
> space - tools like postfix, cron, syslog, apache, ... will not gain from
> being native 64-bit.

For most 64-bit systems, sure.  For amd64 it's a little different
because there are additional changes to the architecture (as compared to
ia32/x86) which can more than make up for the difference for many
applications.  Then there's also things like encryption (postfix/tls,
apache/ssl, etc) which can benefit greatly from better handling of
64bit (and larger) types.

So, basically, it's not nearly so clear-cut as you portray it. :)

> Solaris has done this for ages - maintaining a mostly 32-bit user space,
> a 64-bit kernel, and then allowing for certain memory intensive
> applications to run natively 64-bit.

The differences between a 64bit sparc chip in 32bit and 64bit are quite
a bit less than the differences between an amd64 chip in 32bit and
64bit.  Thus, this makes alot more sense for sparc.

> It's a nice way to run a Linux based system too, IMO.

Perhaps on sparc or mips; it's much less clear-cut on amd64.

	Stephen

--adbRXwaWUtRVaP/r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC4O08rzgMPqB3kigRAhoUAKCFTDFKG1gVdKqwQ7Q+FCjOSXy5zwCeNah9
XcOm9eY8pq+K05aErLo16hQ=
=jhMO
-----END PGP SIGNATURE-----

--adbRXwaWUtRVaP/r--
