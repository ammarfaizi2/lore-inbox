Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269237AbUIYEya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbUIYEya (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 00:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269238AbUIYEya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 00:54:30 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12183 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269237AbUIYEyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 00:54:16 -0400
Message-Id: <200409250452.i8P4qXvo009259@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Andrea Arcangeli <andrea@novell.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1) 
In-Reply-To: Your message of "Sat, 25 Sep 2004 06:07:10 +0200."
             <20040925040710.GH3309@dualathlon.random> 
From: Valdis.Kletnieks@vt.edu
References: <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <Pine.LNX.4.60.0409241819580.1341@dlang.diginsite.com> <20040925013013.GD3309@dualathlon.random> <200409250147.i8P1kxtm016914@turing-police.cc.vt.edu> <20040925021501.GF3309@dualathlon.random> <200409250246.i8P2kWwx027390@turing-police.cc.vt.edu> <20040925025848.GG3309@dualathlon.random> <200409250329.i8P3TwJY002358@turing-police.cc.vt.edu>
            <20040925040710.GH3309@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2044348288P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Sep 2004 00:52:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2044348288P
Content-Type: text/plain; charset=us-ascii

On Sat, 25 Sep 2004 06:07:10 +0200, Andrea Arcangeli said:
> On Fri, Sep 24, 2004 at 11:29:58PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > loop-AES stuff does and forces a minimim 20-char passphrase) - there's goin
g to
> > be all too many blocks in the swsusp area that are "known plaintext" and ea
sily
> 
> well, it's not a filesystem with superblock at fixed location for
> example, the data location and contents is mostly random, or certainly
> not a "known plaintext".

I'm sure there's enough pages that live at magic addresses that end up at
predictable/identifiable locations on the disk to supply enough "known
plaintext". Remember - the attacker only has to find *one* crypto-block sized
set of bits - even with a 256-bit algo, they only have to find 32 consecutive
bytes that they can identify or reconstruct.


--==_Exmh_2044348288P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBVPmQcC3lWbTT17ARAqsUAKDX6bYPLxyo/6QQ8DsIDcOwAkRS6ACghAoy
0cmNathRix5xSrCgzwFs4yU=
=9k5x
-----END PGP SIGNATURE-----

--==_Exmh_2044348288P--
