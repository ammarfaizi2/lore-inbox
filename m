Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbRCCXWB>; Sat, 3 Mar 2001 18:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRCCXVv>; Sat, 3 Mar 2001 18:21:51 -0500
Received: from ns.suse.de ([213.95.15.193]:45066 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129851AbRCCXVg>;
	Sat, 3 Mar 2001 18:21:36 -0500
Date: Sun, 4 Mar 2001 00:21:34 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-pre1 md_autodetect_dev unresolved
Message-ID: <20010304002134.A1854@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

and sorry, no patch.


cantaloupe:~/kernel/linuxppc_2_4 # depmod -Vae
depmod version 2.4.2
depmod: *** Unresolved symbols in /lib/modules/2.4.3-pre1-SMP/kernel/drivers/md/md.o
depmod:         md_autodetect_dev
cantaloupe:~/kernel/linuxppc_2_4 # cat /proc/version 
Linux version 2.4.3-pre1-SMP (root@mandarine) (gcc version 2.95.3 19991030 (prerelease/franzo/20000625)) #2 SMP Sat Mar 3 22:06:38 CET 2001
cantaloupe:~/kernel/linuxppc_2_4 # sh scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux cantaloupe 2.4.3-pre1-SMP #2 SMP Sat Mar 3 22:06:38 CET 2001 ppc unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.10q
modutils               2.4.2
e2fsprogs              1.19
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1499361 Feb 16 23:16 /lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         nfsd autofs ipv6
cantaloupe:~/kernel/linuxppc_2_4 # zgrep _MD /proc/config.gz 
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_USB_MDC800=m



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
