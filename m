Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131148AbQLQNnZ>; Sun, 17 Dec 2000 08:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131495AbQLQNnP>; Sun, 17 Dec 2000 08:43:15 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:50951 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131148AbQLQNm4>; Sun, 17 Dec 2000 08:42:56 -0500
Date: Sun, 17 Dec 2000 14:12:47 +0100
From: Dieter Schuster <didischuster@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic with 2.4.0-test12 when using iso9660 over nfs
Message-ID: <20001217141247.A579@Poseidon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
X-Registered-Linux-user: 186360  http://counter.li.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I mount a cdrom over NFS with 2.4.0-test12 on the NFS-Server, the server
crashs. In the log-files are no Information. On the screen comes the following:

Code: 89 42 04 89 10 b8 01 00 00 c7 43 04 00 00 00 c 03 00
Aieee, killing interupt handler
Unable to handle kernel Null pointer deveference at virtural address 0000029e.

It crashs only with 2.4.0-test12 with 2.4.0-test10 it doesn't (with 
2.4.0-test11 I cannot use cdroms at all). 

I have an Alladin V chipset and a IDE-CDROM.

My System:
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux Poseidon 2.4.0-test12 #2 Wed Nov 29 19:54:45 MET 2000 i586 unknown
Kernel modules         found
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.2
Procps                 2.0.6
Mount                  2.10f
Net-tools              (1999-04-20)
Kbd                    [option...]
Sh-utils               2.0
Sh-utils               Parker.
Sh-utils               Inc.
Sh-utils               NO
Sh-utils               PURPOSE.

	Dieter

Registered Linux User #186360
-- 
I am the "ILOVEGNU" signature virus. Just copy me to your signature.
This email was infected under the terms of the GNU General Public License.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
