Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTIHXoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTIHXoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:44:18 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:45193 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S263751AbTIHXoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:44:17 -0400
Date: Mon, 08 Sep 2003 19:44:04 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Fwd: Re: Use of AI for process scheduling
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Timothy Miller <miller@techsource.com>
Message-id: <200309081944.11736.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 08 September 2003 18:56, you wrote:
> Well, we have this to deal with:  Someone is exercising the scheduler
> and notices some kind of misscheduling which causes the system to crawl.
>
> How are they going to get to the /proc and /sys directories to do much
> of anything?  The system is completely unresponsive.  Furthermore, even
> if the system IS responsive, we need some way to for the user to hit a
> key and freeze the current state for examination.  Some slow-downs last
> only seconds, but we need to be able to catch them.

Agreed.

> You talk about weights.  Would the linux community be willing to put a
> neural net into the kernel?  I'm sure we could optimize it to not take a
> lot of processing overhead, but it's an "unknown".  It would be scary to
> some people to be unable to disect the actual workings of it and have no
> way of determining corner-case behavior from examining code.  But if we
> have, say, only a 2-layer neural net, we might still be able to
> reverse-engineer it.

I meant weights in a more general way - variables in calculations is more
appropriate. Neural nets can do a lot of interesting things, but they really
need optimization. If we were to use them, we should make it a config option
in the kernel (nnet or standard scheduler.)

Jeff.

- --
Trust me, you don't want me doing _anything_ first thing in the morning.
		- Linus Torvalds
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/XRRHwFP0+seVj/4RAs3KAJ9IISM5bALaOTCJtSWxPDlHxOGVEwCfedgD
bCPO9/Mf1dtmA4zVgGP2Tcc=
=vrNw
-----END PGP SIGNATURE-----

