Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbULaKOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbULaKOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 05:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbULaKOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 05:14:44 -0500
Received: from c201010.adsl.hansenet.de ([213.39.201.10]:22408 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S261847AbULaKOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 05:14:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
References: <m3is6k4oeu.fsf@reason.gnu-hamburg>
	<Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org>
	<m3zmzvl9x1.fsf@reason.gnu-hamburg>
	<Pine.LNX.4.58.0412301418521.22893@ppc970.osdl.org>
From: "Georg C. F. Greve" <greve@fsfeurope.org>
Organisation: Free Software Foundation Europe
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Fri, 31 Dec 2004 10:58:29 +0100
In-Reply-To: <Pine.LNX.4.58.0412301418521.22893@ppc970.osdl.org> (Linus
	Torvalds's message of "Thu, 30 Dec 2004 14:23:01 -0800 (PST)")
Message-ID: <m3hdm2lrga.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="20041231105829+0100-24502877-242178719523027";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--20041231105829+0100-24502877-242178719523027

 || On Thu, 30 Dec 2004 14:23:01 -0800 (PST)
 || Linus Torvalds <torvalds@osdl.org> wrote: 

 lt> Ok. This is apparently a slab cache corruption issue.

So we're one step further, it seems.


 lt> Can you compile with SLAB_DEBUG and DEBUG_PAGEALLOC turned on,
 lt> since that may well catch something in the act (or it may make
 lt> the machine so unusably slow that it's not funny - who knows..)

Did that last night. You are right -- it is so slow that it is no fun
at all. So I started the test run last night and went to bed. 

This morning, the machine had crashed again, but unlike the noisy
crashes, when there was output on the console, this time, with
debugging compiled in, it crashed entirely silently. There was no info
on the console and none in the syslog, it just stopped.

Anything else I can try to help?

Anyone else willing to join the slab corruption bug hunt? :)

Regards,
Georg

-- 
Georg C. F. Greve                                 <greve@fsfeurope.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
GNU Business Network                        (http://mailman.gnubiz.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20041231105829+0100-24502877-242178719523027
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.92 (GNU/Linux)

iD8DBQBB1SLKbvivwoZXSsoRAg8ZAJ9LCaWygWwKMHY/lEYVhDpsFiZL1ACgkTuW
yDP0gARhBzVZTAJpYjKrsEY=
=IoxJ
-----END PGP SIGNATURE-----
--20041231105829+0100-24502877-242178719523027--
