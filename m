Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWGQTxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWGQTxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 15:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWGQTxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 15:53:09 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23468 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751164AbWGQTxI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 15:53:08 -0400
Message-Id: <200607171952.k6HJqmQ1022070@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Hans Reiser <reiser@namesys.com>
Cc: Jeffrey Mahoney <jeffm@suse.com>, 7eggert@gmx.de,
       Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
In-Reply-To: Your message of "Mon, 17 Jul 2006 11:27:20 PDT."
             <44BBD688.6070502@namesys.com>
From: Valdis.Kletnieks@vt.edu
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com> <44BAFDC3.7020301@namesys.com> <200607171808.k6HI8kjL018161@turing-police.cc.vt.edu>
            <44BBD688.6070502@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153165968_13479P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Jul 2006 15:52:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153165968_13479P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 Jul 2006 11:27:20 PDT, Hans Reiser said:
> Valdis.Kletnieks@vt.edu wrote:
> >On Sun, 16 Jul 2006 20:02:27 PDT, Hans Reiser said:

> >>Create a mountpoint which knows how to resolve a/b without using a
> >>"directory".

For wanting to resolve it *without* using a "directory"...

> >And said mountpoint gets past the '/' interpretation in the VFS, how, exactly?
> >
> >fs/namei.c, do_path_lookup() does magic on a '/' on about the 3rd line.
> >So you're going to get handed 'a'.

> It does not need to be so complex actually,  Just create a plain old
> parent directory just like every other parent directory in procfs.

This smells a lot like using a directory to resolve it....

--==_Exmh_1153165968_13479P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEu+qQcC3lWbTT17ARAoWVAJ9dXP8NfHRcjp7b0LbtzZXHuxp9WwCcCTyi
KnjJjq3KCEPXNTRflGd2/tM=
=veLN
-----END PGP SIGNATURE-----

--==_Exmh_1153165968_13479P--
