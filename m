Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVATRyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVATRyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVATRxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:53:55 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:20998 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261490AbVATRwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:52:10 -0500
Message-Id: <200501201751.j0KHpvdQ030760@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Chris Han <xiphux@gmail.com>
Subject: Re: [ANNOUNCE][RFC] plugsched-2.0 patches ... 
In-Reply-To: Your message of "Thu, 20 Jan 2005 11:14:48 EST."
             <NIBBJLJFDHPDIBEEKKLPGELGDHAA.mef@cs.princeton.edu> 
From: Valdis.Kletnieks@vt.edu
References: <NIBBJLJFDHPDIBEEKKLPGELGDHAA.mef@cs.princeton.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106243517_12559P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Jan 2005 12:51:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106243517_12559P
Content-Type: text/plain; charset=us-ascii

On Thu, 20 Jan 2005 11:14:48 EST, "Marc E. Fiuczynski" said:
> Peter, thank you for maintaining Con's plugsched code in light of Linus' and
> Ingo's prior objections to this idea.  On the one hand, I partially agree
> with Linus&Ingo's prior views that when there is only one scheduler that the
> rest of the world + dog will focus on making it better. On the other hand,
> having a clean framework that lets developers in a clean way plug in new
> schedulers is quite useful.
> 
> Linus & Ingo, it would be good to have an indepth discussion on this topic.
> I'd argue that the Linux kernel NEEDS a clean pluggable scheduling
> framework.

Is this something that would benefit from several trips around the -mm series?

ISTR that we started with one disk elevator, and now we have 3 or 4 that are
selectable on the fly after some banging around in -mm.  (And yes, I realize that
the only reason we can change the elevator on the fly is because it can switch
from the current to the 'stupid FIFO none' elevator and thence to the new one,
which wouldn't really work for the CPU scheduler....)

All the arguments that support having more than one elevator apply equally
well to the CPU scheduler....

--==_Exmh_1106243517_12559P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB7++9cC3lWbTT17ARAsaBAKCh5Te8ZpOBpM7PFUN0ncChoeTcIwCg2L3Y
0s+K6UTZn5AfLL2P6XA0vls=
=UfYn
-----END PGP SIGNATURE-----

--==_Exmh_1106243517_12559P--
