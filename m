Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261923AbSJDO4s>; Fri, 4 Oct 2002 10:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261919AbSJDO4W>; Fri, 4 Oct 2002 10:56:22 -0400
Received: from d5110da8.cable.wanadoo.nl ([213.17.13.168]:7172 "EHLO
	kamphuis.dyndns.org") by vger.kernel.org with ESMTP
	id <S261923AbSJDOzO> convert rfc822-to-8bit; Fri, 4 Oct 2002 10:55:14 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Sander Kamphuis <sander@kamphuis.dyndns.org>
Reply-To: sander79@wanadoo.nl
To: linux-kernel@vger.kernel.org
Subject: bug report
Date: Fri, 4 Oct 2002 17:01:21 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041701.21475.sander@kamphuis.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*This message was transferred with a trial version of CommuniGate(tm) Pro*
error after compiling kernel 2.4.20pre8 after applying the patch pre7 -> pre8
the following error occures after running 'make bzImage'

(translated from dutch)
make[2]: Leave map `/usr/src/linux/fs/nls'
make -C partitions
make[2]: Enter map `/usr/src/linux/fs/partitions'
make all_targets
make[3]: Enter map `/usr/src/linux/fs/partitions'
make[3]: *** No line for farget `/usr/src/linux/include/asm-ia64/efi.h', 
nessery for `efi.h'. Stop.
make[3]: Leave map `/usr/src/linux/fs/partitions'
make[2]: *** [first_rule] Error 2
make[2]: Leave map `/usr/src/linux/fs/partitions'
make[1]: *** [_subdir_partitions] Error 2
make[1]: Leave map `/usr/src/linux/fs'
make: *** [_dir_fs] Error 2



# cat /proc/version
Linux version 2.4.20-pre7 (root@sander) (gcc versie 3.1) #15 SMP vr okt 4 
14:51:49 CEST 2002

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 1
cpu MHz         : 360.823
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 719.25

# cat /proc/modules
tuner                  10404   1 (autoclean)
tvaudio                12928   0 (autoclean) (unused)
msp3400                16944   1 (autoclean)
tda9887                 2912   1 (autoclean)
bttv                   72256   0
i2c-algo-bit            7628   1 [bttv]
i2c-core               13248   0 [tuner tvaudio msp3400 tda9887 bttv 
i2c-algo-bit]
sb                      7808   2 (autoclean)
sb_lib                 39232   0 (autoclean) [sb]
uart401                 6880   0 (autoclean) [sb_lib]
sound                  60172   2 (autoclean) [sb_lib uart401]
NVdriver             1066464  10
smbfs                  39904   5 (autoclean)
parport_pc             13700   1 (autoclean)
lp                      7232   0 (autoclean)
parport                15008   1 (autoclean) [parport_pc lp]
apm                    10696   2
ne2k-pci                6016   1
8390                    6992   0 [ne2k-pci]
ide-scsi                8960   0
nls_iso8859-1           2848   4 (autoclean)
vfat                   10876   2 (autoclean)
fat                    33176   0 (autoclean) [vfat]

