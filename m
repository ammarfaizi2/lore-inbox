Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272458AbRH3VBP>; Thu, 30 Aug 2001 17:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272456AbRH3VAz>; Thu, 30 Aug 2001 17:00:55 -0400
Received: from ns2.cypress.com ([157.95.67.5]:29072 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S272453AbRH3VAo>;
	Thu, 30 Aug 2001 17:00:44 -0400
Message-ID: <3B8EA974.9060201@cypress.com>
Date: Thu, 30 Aug 2001 16:00:36 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, 
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS in 2.4.8/9ac
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've suddenly started getting host not responding messages
on NFS mounts. The mounts are from Solaris8 and HPUX-10.20.
Other Solaris8 machines don't have this problem,
and the machines serving the mounts are unloaded, and responsive.

2.4.7-ac10 worked fine.2.4.8-ac8 through 2.4.9-ac3
have trouble. I have not tested 2.4.8-ac[1..7] yet.

Linux Tulip driver version 0.9.15-pre6 (July 2, 2001)
tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 33 at 0xe400, 00:A0:CC:50:35:C2, IRQ 10
(Tulip FA310TX card)
NETDEV WATCHDOG: eth0: transmit timed out
nfs: server nd not responding, still trying


gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)
binutils 2.10.91.0.2 (from RedHat -3 i386 package)
mount-2.11b
autofs-3.1.7-14 (using autofs.o NOT autofs4.o)
from /proc/mounts:
nd:/export/nd00/ted /home/ted nfs
     rw,v3,rsize=32768,wsize=32768,hard,udp,lock,addr=nd 0 0
hp3:/users/hp02 /users/hp02 nfs
     rw,v3,rsize=16384,wsize=16384,hard,udp,lock,addr=hp3 0 0

	-Thomas

