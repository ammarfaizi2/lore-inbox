Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUCZVGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbUCZVGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:06:45 -0500
Received: from dhcp18-183.bio.purdue.edu ([128.210.18.183]:52097 "EHLO
	lapdog.ravenhome.net") by vger.kernel.org with ESMTP
	id S264140AbUCZVGk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:06:40 -0500
From: Praedor Atrebates <praedor@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: system clock too fast
Date: Fri, 26 Mar 2004 17:13:01 -0500
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403261713.04401.praedor@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have mandrake 10.0, kernel-2.6.3-7mdk on my desktop Athlon XP2700+ system 
and on my IBM Thinkpad 1412 (celeron 366).  The distro/kernel works fine on 
the desktop but on the Thinkpad, the system clock is flying at about 3x 
normal speed.  I upgraded from the default install kernel-2.6.3-4mdk in the 
hopes that the upgrade would fix my system clock problem.  It didn't.  

On my laptop I had to slow the keyboard repeat rate WAY down to make typing 
possible.  Later, I noticed that timed events were happening way too soon.  
Checking my clock, I can see the seconds tick away at about 3 system 
seconds/real second.  Both with and without ntpd running (and properly 
configured) the clock runs away.  I have checked and the system properly 
identifies the CPU as a celeron 366, so the clock rate isn't "real" or coming 
from the bios.  I cannot change the clock in bios in any case.

I saw in the kernel archives that this problem was brought up with regards to 
a 2.4.x kernel (and there was also mention of a 2.5.x test kernel with the 
same results).

Can anyone shed light on this problem?  Better yet, is there a fix?  

praedor
- -- 
"George W. Bush is a deserter, an election thief, a drunk driver, a WMD 
liar and a functional illiterate. And he poops his pants." 
- --Barbara Bush, his mother
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAZKrvSTapoRk9vv8RAkIgAJ964QaR333kAiDhztHApmC2nZjaNgCgoIOy
e6tDC2ntIQ/lk9ob2RdMji0=
=r3Zk
-----END PGP SIGNATURE-----
