Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUGGPmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUGGPmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUGGPmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:42:08 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:3308 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265207AbUGGPl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:41:58 -0400
Message-ID: <40EC19C6.9010309@comcast.net>
Date: Wed, 07 Jul 2004 11:41:58 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@clusterfs.com>
CC: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: Re: [0/9] Lustre VFS patches for 2.6
References: <20040707124732.GA25877@clusterfs.com>
In-Reply-To: <20040707124732.GA25877@clusterfs.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Interesting, but what exactly does this do?  Extra performance?  How?
Extra security?  Avoid deadlocks?

I'm not the kind of guy that just looks into a patch and claims to
understand all.  :)

Oleg Drokin wrote:
| Hello!
|
|    Following this mail, there are nine patches necessary for Lustre
support
|    in 2.6. The patches are against latest 2.6 bk snapshot.
|    Compared to previous sets of patches, this one does not change existing
|    structure and field names therefore leaving kernel VFS API
completely intact.
|    Also raw operations approach is changed, extra inode operation is
introduced
|    that is supposed to be called at the end of parent lookup and do
necessary
|    operations, if possible.
|    Of course it would be great if these patches would be included into the
|    kernel right away (and that is one of the reasons this set of patches
|    keeps old API intact). Also there were at least some interest in
some of the
|    patches from other parties (e.g. Trond Myklebust was interested in some
|    intent changes as I remember) and we are ready to work with those
so that
|    the patches will suit their needs as well.
|
| Bye,
|     Oleg
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
|
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7BnFhDd4aOud5P8RAhiGAKCJJUqqL9aylG8hkfCAD4GpfMYK+wCdHIj6
njpYVufE205L7MFz04ysdI4=
=tDnN
-----END PGP SIGNATURE-----
