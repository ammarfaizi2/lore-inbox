Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270854AbTGVTix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270860AbTGVTix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:38:53 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:19328 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270854AbTGVTiv (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:38:51 -0400
Message-Id: <200307221953.h6MJroXb001837@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ON TOPIC] HELP: Getting lousy memory throughput from Abit KD7 
In-Reply-To: Your message of "Tue, 22 Jul 2003 15:34:51 EDT."
             <Pine.LNX.4.53.0307221520290.5609@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <3F1711B5.9020800@techsource.com> <3F1D8EAB.6020801@techsource.com>
            <Pine.LNX.4.53.0307221520290.5609@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_439975274P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Jul 2003 15:53:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_439975274P
Content-Type: text/plain; charset=us-ascii

On Tue, 22 Jul 2003 15:34:51 EDT, "Richard B. Johnson" said:

> If I needed to really find the memory access time, I would write
> a program to test it.

> (4) Warm the cache first by reading everything in the buffer you
>     are going to test.

At which point you're measuring the cache speed not the memory speed.

> You will probably be amazed at how well your system performs. This
> dual CPU 400 MHz thing, with 100 MHz memory does 1,900++ MiB/sec.

Which probably explains this result.  Do a quick sanity check - this number
seems to indicate 20 bytes per memory clock, EVERY clock - either there's
some VERY creative use of prefetching to make sure that you never hit a
cache line miss, or you're measuring the cache.. ;)

--==_Exmh_439975274P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/HZZNcC3lWbTT17ARAlk6AJ9JZdkInkg6CCiX3NA0XcXqYM5mbwCfUaaG
nNkE481Tl5/y60ofxUG961U=
=pCb6
-----END PGP SIGNATURE-----

--==_Exmh_439975274P--
