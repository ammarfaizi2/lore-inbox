Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUBEKVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUBEKVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:21:41 -0500
Received: from h80ad2548.async.vt.edu ([128.173.37.72]:18582 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265114AbUBEKVi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:21:38 -0500
Message-Id: <200402051017.i15AHA99025783@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Alexander Viro <aviro@redhat.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
       selinux@tycho.nsa.gov, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] (3/3) SELinux context mount support - SELinux changes. 
In-Reply-To: Your message of "Wed, 04 Feb 2004 10:33:12 EST."
             <Xine.LNX.4.44.0402040953280.4796-100000@thoron.boston.redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <Xine.LNX.4.44.0402040953280.4796-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-58655779P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Feb 2004 05:17:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-58655779P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 Feb 2004 10:33:12 EST, James Morris said:
> This patch implements context mount support within SELinux.
> 
> Three new mount options are provided:

<30 lines of summary information elided>

> Filesystems with binary mount option data (e.g. NFS, SMBFS, AFS, Coda) 
> need to be handled as special cases: only NFS is supprted at this stage 
> per the previous patch.

First I kept these patches around.

Then I saw that Andrew picked them up for 2.6.2-mm1, so I didn't need
to keep them.

Then I saw I had to either keep them, extract the summary info and keep that,
hope that I could find it while searching the LKML archives when I need it,
reverse engineer the code (how many times would I end up reading the code
if I got stuck by the relabelfrom/relabelto stuff?), or otherwise get lucky.

This isn't the first time that we've had patches go by with nice explanitory
text that doesn't make it into the kernel tree.  Does anybody have a good
idea on what we can/should do about these?  Even just dropping them into
one big Documentation/hints file might be good enough.


--==_Exmh_-58655779P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIhglcC3lWbTT17ARAjd6AJ4xhWDBoc00EXaSXkez0wO0NWOfFwCfcaFH
3mb7pPBdcc7VkKvpzt1ZkTs=
=fekM
-----END PGP SIGNATURE-----

--==_Exmh_-58655779P--
