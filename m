Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268733AbRGZX11>; Thu, 26 Jul 2001 19:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268734AbRGZX1R>; Thu, 26 Jul 2001 19:27:17 -0400
Received: from jalon.able.es ([212.97.163.2]:52427 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S268733AbRGZX1G>;
	Thu, 26 Jul 2001 19:27:06 -0400
Date: Fri, 27 Jul 2001 01:31:38 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: mount-2.11e bug ?
Message-ID: <20010727013138.A4186@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello...

Can anybody tell me if there was a bug in mount from util-linux-2.11e that could
do things like this with new kernels:

/etc/fstab:
...
tmpfs /dev/shm tmpfs defaults,size=128M 0 0
...

werewolf:~/soft/util/util-linux-2.11e/mount# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1               248895     83086    152959  36% /
/dev/sda2              3099292   2092872    848984  72% /usr
/dev/sda3              4095488   1603796   2283652  42% /home
/dev/sda5              1027768         8    975552   1% /toast
/home/soft/util/util-linux-2.11e/mount/tmpfs
                        131072         0    131072   0% /dev/shm

2.11h works ok.

TIA.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7-ac1 #1 SMP Thu Jul 26 19:53:39 CEST 2001 i686
