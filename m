Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264253AbUEYRjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbUEYRjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUEYRjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:39:51 -0400
Received: from mout1.freenet.de ([194.97.50.132]:37847 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S264253AbUEYRjt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:39:49 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: System clock running too fast
Date: Tue, 25 May 2004 19:39:45 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405251939.47165.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I've got the problem with my server, that the system-clock
is running really fast. It's running over one second too
fast in one hour (aproximately).

The CPU of this machine is underclocked.
It's a Pentium-1 133Mhz running at 75Mhz. All other hardware
is running in its specifications. Can underclocking the CPU
make the clock running faster? (I never saw a clock running
slower on overclocked CPUs. 8-) )

root@server:~> uname -r
2.4.26-grsec

root@server:~> cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 12
cpu MHz         : 75.172
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 149.91

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAs4ThFGK1OIvVOP4RAk/5AKCJH2XinQupYoYVU0X9uMIJFxb7VwCfTSQ4
cwGH1+bb6XXBxA3XcXLh4cU=
=krSc
-----END PGP SIGNATURE-----
