Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271082AbTG1Uid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271104AbTG1Ui3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:38:29 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:267 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271082AbTG1UhB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:37:01 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Ethernet falls into deep sleep.
Date: Mon, 28 Jul 2003 22:37:03 +0200
User-Agent: KMail/1.5.2
References: <200307281323.47013.fsdeveloper@yahoo.de> <20030728130719.33e14be6.akpm@osdl.org>
In-Reply-To: <20030728130719.33e14be6.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307282237.03113.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 28 July 2003 22:07, Andrew Morton wrote:
> Michael Buesch <fsdeveloper@yahoo.de> wrote:
> > I've a problem with my server/router, that I've seen on
> > various kernels. currently I'm running 2.4.21, but I've
> > seen the problem on 2.4.20 and 2.5.70, too.
> > I'm using a 3com 3c509 ISA ethernet card.
> >
> > When this server stays a longer time (about one night, 12 hours)
> > without network-traffic, it seems like the whole network-interface
> > falls into a very deep sleep. It's very hard to wake the machine
> > up.
>
> This could be a router problem: some routers (Cisco?) decide that a host

I've got no hardware-router.
The server (the machine, that locks up; normal pentium linux PC)
works as server and router for my other machines.

> has died if no traffic has been seen for a long time.  Google for "vortex
> sleepy nic" for some discussion.
>
> I haven't seen any reports of this in a looong time.  IIRC it was worked
> around by pinging some remote host once per minute.

I'm now trying it without APM, ACPI support in the
kernel.
If this doesn't work, I'll try to make a cron-job pinging some
server.

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
Penguin on this machine:  Linux 2.4.21  - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/JYlvoxoigfggmSgRAv9PAJwK7b6vA3iYuzUMMtBlke8OjfCpLQCfXKcO
9w/oyKdCiF0Lydx57J88CwQ=
=eeAh
-----END PGP SIGNATURE-----

