Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132735AbRDINFm>; Mon, 9 Apr 2001 09:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbRDINFd>; Mon, 9 Apr 2001 09:05:33 -0400
Received: from proxy.povodiodry.cz ([212.47.5.214]:3312 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S132735AbRDINFV>;
	Mon, 9 Apr 2001 09:05:21 -0400
From: "Vitezslav Samel" <samel@mail.cz>
Date: Mon, 9 Apr 2001 14:57:24 +0200
To: linux-kernel@vger.kernel.org
Subject: reboots under load in 2.4.3
Message-ID: <20010409145724.A4322@pc11.op.pod.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  When I booted freshly compiled linux-2.4.3 on my SMP machine, during some
compilling (make -j2 in gtk+ sources) the machine reboots. There were some
other processes running: trplayer (command line realaudio player), some
bashes and midnight-commanders. XFree86 wasn't running. Reboots were
spontaneous - no messages in logs nor on console. I've tried booting once
again and tried compilling gtk+. After cca 10 seconds the machine rebooted.

  I've tried booting with and without 'nmi_watchdog' option reboots were
still happening. Also tried 'noapic' option and the system seems to be solid
(3days now).

  Are there any known problems with APIC in recent kernels?

	Thanks,
			Vita Samel



HW:	ASUS P2B-D dual mainboard
	2x PIII/700
	Adaptec 29160 SCSI card
	SB Live! sound card

SW:	(kernel compiled without modules)

Linux pc11 2.4.3 #1 SMP Fri Apr 6 09:13:41 CEST 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79
binutils               2.9.5.0.42
util-linux             2.10l
modutils               2.4.1
e2fsprogs              1.19
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.55
Kbd                    0.99
Sh-utils               2.0

