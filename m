Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbRF3Dll>; Fri, 29 Jun 2001 23:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264710AbRF3Dla>; Fri, 29 Jun 2001 23:41:30 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:30727 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S264697AbRF3DlX>;
	Fri, 29 Jun 2001 23:41:23 -0400
Message-ID: <3B3D4A96.A81A13AD@bigfoot.com>
Date: Fri, 29 Jun 2001 21:42:14 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: EEPro100 problems in SMP on 2.4.5 ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi.  While doing some file tranfers to our new server (a Compaq Proliant
8way XEON 500 with 4gb ram and an EEPro100 NIC), the box socked solid (no
oops, no response via network, no response via console).  The other hardware
in the system was a Compaq Smart Array 9SMART2 driver).  It's running
Slackware 7.1.  The other system was a dual P3 450 running Redhat 7.1 (Linux
velocity.kuro5hin.org 2.4.2-2smp #1 SMP Sun Apr 8 20:21:34 EDT 2001 i686
unknown) w/ 3c59x NIC.  The Redhat machine experienced no problems.
	In Uni processor mode, the system is totally stable.  But only using 1/8th
of its power :-/  We had to roll back to 2.2.19 with a bigmem patch, but
we'd like to have a stable 2.4 kernel to use (since it's so much better SMP
wise, throughput wise, etc).
--
    www.kuro5hin.org -- technology and culture, from the trenches.
