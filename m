Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131159AbRAFLnx>; Sat, 6 Jan 2001 06:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131441AbRAFLnn>; Sat, 6 Jan 2001 06:43:43 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:34058 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S131159AbRAFLnf>;
	Sat, 6 Jan 2001 06:43:35 -0500
Date: Sat, 6 Jan 2001 12:43:24 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101061143.MAA01733@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: msg : cannot create ksymoops/nnnnn.ksyms
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With all the kernel 2.2.xx, 2.4.0-testxx, I have the following message at
boot time :

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 56k freed
INIT: version 2.78 booting
NET4: Unix domain sockets 1.0 for Linux NET4.0.
insmod: /lib/modules/2.2.19pre6/misc/unix.o: cannot create /var/log/ksymoops/20010106112242.ksyms Read-only file system
Loading /etc/console-tools/default.kmap
Activating swap...
Adding Swap: 131088k swap-space (priority -1)
Checking root file system...


As it was harmless, I've not taken care of it. I have the same with
2.4.0-prerelease but with 2.4.0 final, there is an unfinite loop with this 
message together with a an other one :

insmod:/lib/modules/2.4.0/kernel/net/unix/unix.o : insmod net-pf-1 failed.

Do I missed something in modules.conf ? Is there a specific alias to net-pf-1 ?

System is :
K6-2/500, 128Mb, running Debian 2.2 
I've tested with both modutils 2.3.24 and 2.4.0

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux debian-f5ibh 2.2.19pre6 #1 jeu jan 4 12:30:22 CET 2001 i586 unknown
Kernel modules         2.3.24
Gnu C                  egcs-2.91.66
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ppp_deflate bsd_comp ppp slhc af_packet scc ax25 parport_probe parport_pc lp parport mousedev usb-ohci hid input autofs lockd sunrpc usbcore serial w83781d sensors i2c-isa i2c-core unix

----

Regards

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
