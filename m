Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267978AbUJGTve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbUJGTve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUJGTvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:51:31 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:34791 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267978AbUJGTtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:49:42 -0400
Message-Id: <200410071949.i97JnZjZ009355@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Alexander Clouter <alex-kernel@digriz.org.uk>
Cc: pavel@ucw.cz, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.9-rc1->rc3 and futex's hang 
In-Reply-To: Your message of "Sun, 03 Oct 2004 12:56:49 BST."
             <20041003115649.GA22399@inskipp.digriz.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20041003115649.GA22399@inskipp.digriz.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_72685397P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Oct 2004 15:49:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_72685397P
Content-Type: text/plain; charset=us-ascii

On Sun, 03 Oct 2004 12:56:49 BST, Alexander Clouter said:

> summary: kernel's 2.6.9-rc1->2.6.9-rc3 lock up my jabber client (on a futex)
> keywords: futex, 2.6.9, hanging (no oops)

> The jabber client (with an strace) shows it hangs on a futex.  I do not have
> a clue if this is related to your OpenOffice issue[1], for you it segfaults
> OO, for me it hangs my Jabber client (tkabber) and I have to kill it. :(

> [1] http://www.spinics.net/lists/kernel/msg295867.html

For what it's worth, I was seeing the OpenOffice crash-at-startup as well,
and can report that it does *NOT* happen on 2.6.9-rc3-mm3-VP-T3.

I've perused the changelogs, and remain mystified what fixed it however...

--==_Exmh_72685397P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBZZ3OcC3lWbTT17ARAohKAJ9LwOs3S5qhPCk5gCtqfWMUXmR8tACg9VhH
hrMuDoJ0xDNgulG5DbUTHqA=
=Iywp
-----END PGP SIGNATURE-----

--==_Exmh_72685397P--
