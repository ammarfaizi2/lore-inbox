Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUBLPeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 10:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266496AbUBLPeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 10:34:44 -0500
Received: from mout0.freenet.de ([194.97.50.131]:25564 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S266494AbUBLPem convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 10:34:42 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Subject: Re: lock up with 2.4.23
Date: Thu, 12 Feb 2004 16:34:21 +0100
User-Agent: KMail/1.6.50
References: <Pine.LNX.4.58.0402111939370.5221@potato.cts.ucla.edu>
In-Reply-To: <Pine.LNX.4.58.0402111939370.5221@potato.cts.ucla.edu>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402121634.32186.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 12 February 2004 06:18, you wrote:
> When the machine locked up, it was not pingable.  I connected via serial
> console and used sysrq to sync and remount the disks readonly.  I also got
> output from sysrq+t, sysrq+p, and sysrq+m.  Output is below.

I had a lockup on 2.4.24 today, too.
The machine was not pingable (suddenly) and all network
access failed (NFS, SSH).
The box had an uptime of aproximately 20 days.

Machine is a pentium 1 75 Mhz with 48MB Ram.

The bad things are:
- - I have no logs. They got lost when I reset the machine.
- - The kernel was tainted with the fritzcard dsl driver.
  But exact the same driver had uptimes of over 30 days on
  this machine several times in the past.
- - The machine has no peripheral hardware, so I was not
  able to test sysrq, catch dmesg or something like that.

I know, that this mail is not very helpfull, but maybe
better than sending no mail at all. :)

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAK50GFGK1OIvVOP4RAhYtAJ4+oiQYelqEB9kS5mjLC+HTHo9gnwCgmpVW
GWYjyRLplaKcY2Rt22cRQIw=
=dyJN
-----END PGP SIGNATURE-----
