Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUAYLL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 06:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUAYLL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 06:11:26 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:3979 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S264132AbUAYLLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 06:11:24 -0500
Date: Sun, 25 Jan 2004 12:11:29 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Bryan Whitehead <driver@megahappy.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.2-rc1-mm3] fs/xfs/xfs_log_recover.c
Message-ID: <20040125111129.GA29501@cambrant.com>
References: <20040125044859.8A67F13A354@mrhankey.megahappy.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20040125044859.8A67F13A354@mrhankey.megahappy.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 24, 2004 at 08:48:59PM -0800, Bryan Whitehead wrote:
> This patch keeps the same functionality but removes the warning the compiler generates.

I sent you a patch exactly like this a few days ago, but I don't know
if you got it. This way is a lot more simple than the approach you went
for in your last patch, but it really shouldn't matter at all. All it
does is to clear a warning. One tip though, in SubmittingPatches you
can read that the best way to create patches is by making them apply
with the -p1 flag. This is done by including the actual kernel source
directory when making the diff, such as this:

diff -up linux/fs/xfs/xfs_log_recover.c.orig linux/fs/xfs/xfs_log_recover.c

It doesn't matter what you named your kernel directory, since the -p1 flag
ignores that name. Using this command will improve your chances of getting
your patches included.


                Tim Cambrant

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAE6Rg+p4C2FlRhwIRAva6AKCwJnQuC1zPFFie2OoKaH7ZM4AYXwCfVCB7
xIQjGfE+jlLKX0vmkC51WmI=
=WXrs
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
