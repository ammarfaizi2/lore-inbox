Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318032AbSIJTMW>; Tue, 10 Sep 2002 15:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSIJTMV>; Tue, 10 Sep 2002 15:12:21 -0400
Received: from pop.gmx.net ([213.165.64.20]:49696 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S318032AbSIJTMN> convert rfc822-to-8bit;
	Tue, 10 Sep 2002 15:12:13 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@gmx.net>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] [PATCH] Linux-2.5.34-mcp1
Date: Tue, 10 Sep 2002 21:10:52 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209102044.57514.m.c.p@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

since v2.5.25 the devel kernel series didn't boot for me. I've tested each new 
version but without success. Saw "Loading Linux..." and after that, a blank 
screen, even sysrq was non-working, even Serial Console didn't give me _any_ 
output. I was really afraid, since I was not able to find that problem, that 
future 2.5.xx kernels won't boot for me also, BUT fortunately v2.5.34 boots 
again for me :-) and is working fine so far and I am really impressed how 
v2.5 goes ahead :-)

Therefor I decided to make a really small patch available for vanilla v2.5.34 
kernel which includes the following:

 o   2.5.34-mm1                                (Andrew Morton)
 o   aty128 Framebuffer fixes                  (Paul Mackerras)
 o   ftape damage fix                          (Mikael Pettersson)
 o   devfs fix                                 (Alexander Viro)
 o   do_syslog__down_try lock lockup           (Ingo Molnar)
 o   floppy driver init/exit fixes             (Mikael Pettersson)
 o   pcibios_fixup_irqs-static                 (Adam J. Richter)
 o   some tuning                               (me)
     - OPEN_MAX 1024
     - NR_FILE 65536
     - NR_RESERVED_FILES 128
     - TCP_KEEPALIVE_TIME (5*60*HZ)
     - int sysctl_local_port_range[2] = { 1024, 9999 };
 o   ext3 version information fix              (me)
 o   ALSA v0.9.0rc3                            (ALSA Team)
 o   XFS + KDB (2.5.33-20020908-cvs)           (SGI)


I hope you need this a bit and find it usefull as I do.

Feedback welcome :)


md5sums:
--------
fab4908b8b864fc36072d6f00ff64519 *linux-2.5.34-mcp1.patch.bz2
123067907208ee27eb93a04560667012 *linux-2.5.34-mcp1.patch.gz

URL:
----
http://prdownloads.sf.net/wolk/linux-2.5.34-mcp1.patch.bz2?download
http://prdownloads.sf.net/wolk/linux-2.5.34-mcp1.patch.gz?download



Thanks goes out to all the great developers who made this possible !!


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


