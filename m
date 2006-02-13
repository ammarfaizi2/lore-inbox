Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWBMPVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWBMPVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWBMPVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:21:33 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:43621 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S932135AbWBMPVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:21:32 -0500
Message-ID: <43F0A4BA.20401@suse.com>
Date: Mon, 13 Feb 2006 10:24:42 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Bernd Schubert <bernd-schubert@gmx.de>,
       Chris Wright <chrisw@sous-sol.org>,
       John M Flinchbaugh <john@hjsoft.com>, reiserfs-list@namesys.com,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 Bug? New security model?
References: <200602080212.27896.bernd-schubert@gmx.de>	<200602081314.59639.bernd-schubert@gmx.de>	<20060208205033.GB22771@shell0.pdx.osdl.net>	<200602082246.15613.bernd-schubert@gmx.de>	<20060208221124.GN30803@sorel.sous-sol.org> <20060212005541.107f7011.vsu@altlinux.ru> <43F01D70.70600@namesys.com>
In-Reply-To: <43F01D70.70600@namesys.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> This is an xattr bug, and I'll let jeff answer it.

Hans -

This bug is about inode attributes (the chattr type), not extended
attributes (the setfacl/setfattr type). Regardless, it's the root cause
of the random attributes we were seeing when the REISERFS_ATTRS
enable-by-default problem was corrected. Thanks to some other people on
the list, I was able to post some patches to address it yesterday evening.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD8KS5LPWxlyuTD7IRApKRAJ0SdbS+/KzO8Kn7RMfVQ2KfwNSg/gCfXIdE
KlxigEBlCZixvy7PObKebE0=
=3wk5
-----END PGP SIGNATURE-----
