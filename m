Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbUKVSAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbUKVSAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUKVSAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:00:43 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:58531 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262218AbUKVR71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:59:27 -0500
Message-Id: <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Amit Gud <amitgud1@gmail.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory 
In-Reply-To: Your message of "Mon, 22 Nov 2004 19:24:36 +0530."
             <2c59f00304112205546349e88e@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <2c59f00304112205546349e88e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1072869811P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Nov 2004 12:59:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1072869811P
Content-Type: text/plain; charset=us-ascii

On Mon, 22 Nov 2004 19:24:36 +0530, Amit Gud said:

>  A straight forward question. Wouldn't adding a "file as a directory"
> mechanism more logical in VFS itself,

There was quite the flame-fest on the lkml a while back regarding
how the semantics of "file as a directory" should operate.  There's
a number of really nasty corner cases that you need to deal with.

Go back and re-read the whole flame-fest, understand all the points
raised, and let us know when you have a workable proposal.

(Hint - "file as directory" broke a number of programs that didn't
expect that a file *could* be a directory, when run on a reiser4
filesystem...)

--==_Exmh_-1072869811P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBoijmcC3lWbTT17ARAkZCAJ47MrC4HdCzSyyogwH+peEOLHfPaACcCaFm
1V0Yd6AiVGhBGQVOOY2XuV0=
=mnMB
-----END PGP SIGNATURE-----

--==_Exmh_-1072869811P--
