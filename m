Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311756AbSDCOs2>; Wed, 3 Apr 2002 09:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311782AbSDCOsV>; Wed, 3 Apr 2002 09:48:21 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:14097 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S311756AbSDCOr6>; Wed, 3 Apr 2002 09:47:58 -0500
Date: Wed, 3 Apr 2002 16:46:55 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: CD-ROM eject/load problems
Message-ID: <20020403164655.H733@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,
hi list readers,

I experience problem with my CD-ROM drive since one week.

I use the automounter, cdplay and xine to access it. After some
usage it tries to eject if I open the device and vice versa.

If I run a continous loop of 

   while true; do cdplay; done

my drive will continously eject and load the tray.

I could not find anything about this in the archive. If it is a
known problem, please tell me. If not, I would appriciate your
help of course ;-)

PS: Attached is my config, a summary of hardware and software
   information and the offending log entries.

Thanks & Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
     >>>   4. Chemnitzer Linux-Tag - 09.+10. Maerz 2002 <<<
              http://www.tu-chemnitz.de/linux/tag/

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hwinfo

+ Kernel
Linux version 2.4.18-pre9 (root@bertha) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Thu Feb 14 13:38:04 CET 2002
BOOT_IMAGE=cur ro root=301 mem=64M nopnp forcefsck
+ System
- CPU(s)
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 12
cpu MHz		: 150.000
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 299.00

- Memory
        total:    used:    free:  shared: buffers:  cached:
Mem:  64397312 49180672 15216640        0  9564160 21553152
Swap: 269320192 21364736 247955456
MemTotal:        62888 kB
MemFree:         14860 kB
MemShared:           0 kB
Buffers:          9340 kB
Cached:          18328 kB
SwapCached:       2720 kB
Active:          18088 kB
Inactive:        15236 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        62888 kB
LowFree:         14860 kB
SwapTotal:      263008 kB
SwapFree:       242144 kB
- IO ranges
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
ec00-ec7f : 3Com Corporation 3c905B 100BaseTX [Cyclone] (#2)
  ec00-ec7f : 00:14.0
ec80-ecff : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  ec80-ecff : 00:13.0
ef00-ef3f : Ensoniq ES1371 [AudioPCI-97]
  ef00-ef3f : es1371
ffa0-ffaf : Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
- Memory mapped IO ranges
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-001c34cf : Kernel code
  001c34d0-00200957 : Kernel data
fc000000-fdffffff : Cirrus Logic GD 5464 [Laguna]
ffaeff00-ffaeff7f : 3Com Corporation 3c905B 100BaseTX [Cyclone] (#2)
ffaeff80-ffaeffff : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ffaf8000-ffafffff : Cirrus Logic GD 5464 [Laguna]
- Interrupts
           CPU0       
  0:   89085150          XT-PIC  timer
  1:     197345          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:         45          XT-PIC  serial
  7:          0          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:    3026238          XT-PIC  eth0
 11:   13041310          XT-PIC  es1371
 14:    4339782          XT-PIC  ide0
NMI:          0 
ERR:          0
- Filesystems
nodev	rootfs
nodev	bdev
nodev	proc
nodev	sockfs
nodev	tmpfs
nodev	shm
nodev	pipefs
	ext2
nodev	devfs
nodev	devpts
nodev	autofs
	iso9660
- Device majors
Character devices:
  1 mem
  2 pty/m%d
  3 pty/s%d
  4 tts/%d
  5 cua/%d
  7 vcs
 10 misc
 14 sound
108 ppp
128 ptm
136 pts/%d
162 raw

Block devices:
  3 ide0
+ Ide devices:

/dev/hda:

 Model=IBM-DTTA-351010, FwRev=T56OA73A, SerialNo=WF0WFJ55801
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=466kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=19807200
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 udma0 udma1 udma2 

/dev/hdb:

 Model=TOSHIBA CD-ROM XM-6002B, FwRev=0527, SerialNo=8100710639
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=256kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:180,w/IORDY:180}, tDMA={min:150,rec:150}
 PIO modes: pio0 pio1 pio2 pio3 
 DMA modes: sdma0 sdma1 sdma2 mdma0 *mdma1 
/dev/hdc is not present.
/dev/hdd is not present.
/dev/hde is not present.
/dev/hdf is not present.
/dev/hdg is not present.
/dev/hdh is not present.
+ PCI devices:
00:00.0 Host bridge: Intel Corporation 430VX - 82437VX TVX [Triton VX] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Region 4: I/O ports at ffa0

00:11.0 Multimedia audio controller: Ensoniq: Unknown device 1371 (rev 08)
	Subsystem: Unknown device 1274:1371
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 12 min, 128 max, 64 set
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ef00

00:12.0 VGA compatible controller: Cirrus Logic GD 5464 [Laguna] (rev 01)
	Subsystem: Unknown device dead:beef
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 192 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ffaf8000 (32-bit, non-prefetchable)
	Region 1: Memory at fc000000 (32-bit, non-prefetchable)

00:13.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
	Subsystem: Unknown device 10b7:9055
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 10 min, 10 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at ec80
	Region 1: Memory at ffaeff80 (32-bit, non-prefetchable)

00:14.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
	Subsystem: Unknown device 10b7:9055
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 10 min, 10 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at ec00
	Region 1: Memory at ffaeff00 (32-bit, non-prefetchable)

+ ISAPnP devices:
# $Id: pnpdump.c,v 1.10 1997/07/14 22:30:47 fox Exp $
# This is free software, see the sources for details.
# This software has NO WARRANTY, use at your OWN RISK
#
# For details of this file format, see isapnp.conf(5)
#
# For latest information on isapnp and pnpdump see:
# http://www.roestock.demon.co.uk/isapnptools/
#
# Compiler flags: -DREALTIME -DNEEDSETSCHEDULER
#
# Trying port address 0203
# Trying port address 020b
# Trying port address 0213
# Trying port address 021b
# Trying port address 0223
# Trying port address 022b
# Trying port address 0233
# Trying port address 023b
# Trying port address 0243
# Trying port address 024b
# Trying port address 0253
# Trying port address 025b
# Trying port address 0263
# Trying port address 026b
# Trying port address 0273
# Trying port address 027b
# Trying port address 0283
# Trying port address 028b
# Trying port address 0293
# Trying port address 029b
# Trying port address 02a3
# Trying port address 02ab
# Trying port address 02b3
# Trying port address 02bb
# Trying port address 02c3
# Trying port address 02cb
# Trying port address 02d3
# Trying port address 02db
# Trying port address 02e3
# Trying port address 02eb
# Trying port address 02f3
# Trying port address 0303
# Trying port address 030b
# Trying port address 0313
# Trying port address 031b
# Trying port address 0323
# Trying port address 032b
# Trying port address 0333
# Trying port address 033b
# Trying port address 0343
# Trying port address 034b
# Trying port address 0353
# Trying port address 035b
# Trying port address 0363
# Trying port address 036b
# Trying port address 0373
# Trying port address 0383
# Trying port address 038b
# Trying port address 0393
# Trying port address 039b
# Trying port address 03a3
# Trying port address 03ab
# Trying port address 03b3
# Trying port address 03bb
# Trying port address 03e3
# Trying port address 03eb
# Trying port address 03f3
# No boards found
+ SCSI devices:
- via scsiinfo:

- via proc:
(none)
+ Additional information
- snapshot of running processes
 FLAGS   UID   PID  PPID PRI  NI   SIZE   RSS WCHAN       STA TTY TIME COMMAND
   100     0     1     0   8   0   1184    68 pause       S   ?   0:05 init [3]             
    40     0     3     0  19  19      0     0 ksoftirqd   SWN ?   0:00 (ksoftirqd_CPU0)
   840     0     4     0   9   0      0     0 kswapd      SW  ?   1:23 (kswapd)
    40     0     5     0   9   0      0     0 bdflush     SW  ?   0:01 (bdflush)
    40     0     6     0   9   0      0     0 kupdate     SW  ?   0:09 (kupdated)
    40     0     2     1   9   0      0     0 context_thr SW  ?   0:06 (keventd)
    40 60001   390     1   9   0   1496   172 do_select   S   ?   0:00 /usr/local/sbin/netplan -a 
    40     0   414     1   9   0   1260   328 do_poll     S   ?   0:00 /usr/sbin/automount /mnt/misc file /etc/auto.misc 
    40     0   419     1   9   0   1260   328 do_poll     S   ?   0:00 /usr/sbin/automount /mnt/net program /etc/auto.net 
   140     0   435     1  10   0   1224   408 do_select   S   ?   0:01 syslogd -m 0 
   140     0   442     1  10   0   1152   348 do_syslog   S   ?   0:00 klogd -x -c 3 
    40     2   451     1   8   0   1196   424 nanosleep   S   ?   0:00 /usr/sbin/atd 
    40     0   460     1   8   0   1200   472 nanosleep   S   ?   0:00 crond 
    40     0 25544   460   8   0   1204   508 pipe_wait   S   ?   0:00  \_ CROND 
   100     0 25547 25544   9   0   1888   884 pipe_wait   S   ?   0:00      \_ /usr/sbin/sendmail -FCronDaemon -odi -oem -or0s root 
   140     1   469     1   9   0   1176   300 do_select   S   ?   0:00 portmap 
   100     0   472     1   9   0   2024   820 do_select   S   ? 362:18 /usr/bin/top -s 
   140     0   481     1   9   0   2280   472 do_select   S   ?   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf 
   140   505   487   481   9   0   2292   448 wait_for_co S   ?   0:00  \_ /usr/sbin/httpd -f /etc/httpd/httpd.conf 
   140   505   488   481   9   0   2292   448 interruptib S   ?   0:00  \_ /usr/sbin/httpd -f /etc/httpd/httpd.conf 
   140   505   489   481   9   0   2292   448 interruptib S   ?   0:00  \_ /usr/sbin/httpd -f /etc/httpd/httpd.conf 
   140   505   493   481   9   0   2292   448 interruptib S   ?   0:00  \_ /usr/sbin/httpd -f /etc/httpd/httpd.conf 
   140     0   494     1   8   0   1192   384 do_select   S   ?   0:00 inetd 
   140     0   508     1   9   0   1424  1424 do_select   S   ?   0:00 xntpd -A 
    40     0   518     1   9   0   1408    76 do_select   S   ?   0:00 rpc.mountd 
    40     0   526     1   9   0   1440    76 do_select   S   ?   0:00 rpc.nfsd 
    40     0   561     1   9   0   1184     8 do_select   S   ?   0:00 gpm -t MouseMan 
   140     0   564     1   9   0   1648    92 wait4       S   ?   0:00 /bin/sh /etc/rc.d/rc3.d/S90junkbuster start 
   100     0   571   564   8   0   1448   120 wait_for_co S   ?   0:02  \_ /usr/sbin/junkbuster /usr/share/junkbuster/junkbuster.conf 
   140     0   612     1   9   0   1652   124 do_select   S   ?   0:01 /usr/local/sbin/sshd 
     0   500   621     1   9   0   1156   100 nanosleep   S   ?   0:00 /usr/bin/tail -n 25 -f /home/ioe/tmp/from 
   100     0   643     1   9   0   1980    12 wait4       S    1  0:00 login -- ioe                                                                             
   100   500   672   643   9   0   1808    56 wait4       S    1  0:00  \_ -bash 
   100   500 18567   672   9   0   1928   100 pause       S    1  0:00      \_ screen -a -x 
   100     0   645     1   9   0   1980    60 wait4       S    3  0:00 login -- ioe                                                                             
   100   500 18469   645   8   0   1816    64 read_chan   S    3  0:00  \_ -bash 
   100     0   646     1   9   0   1148     8 read_chan   S    4  0:00 /sbin/mingetty tty4 
   100     0   647     1   9   0   1148     8 read_chan   S    5  0:00 /sbin/mingetty tty5 
   100     0   648     1   9   0   1148     8 read_chan   S    6  0:00 /sbin/mingetty tty6 
   100     0   649     1   9   0   1148     8 read_chan   S   ?   0:00 /sbin/mingetty tty17 
   100     0   654     1   9   0   1148     8 read_chan   S   ?   0:00 /sbin/mingetty tty18 
   100     0   655     1   9   0   1148     8 read_chan   S   ?   0:00 /sbin/mingetty tty19 
   100     0   656     1   9   0   1148     8 read_chan   S   ?   0:00 /sbin/mingetty tty20 
   100     0   663     1  15  10   1156    72 nanosleep   S N ?   0:00 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
   140     0   687     1   9   0   3588  1116 do_select   S   ?   7:22 SCREEN -a 
   100   500   696   687   9   0   8716  1192 do_poll     S   ?   2:58  \_ mutt 
   100     0   702   687   9   0   1924   140 wait4       S   ?   0:00  \_ su -l root 
   100     0   703   702   9   0   1852   768 wait4       S   ?   0:02  |   \_ -bash 
   100     0 26675   703  10   0   1592   708 wait4       S   ?   0:00  |       \_ /bin/bash /home/ioe/sources/scripts/detect_hw 
100000     0 26703 26675  17   0   1672   704             R   ?   0:00  |           \_ ps faxuwl 
   100   500   732   687   9   0   4736   848 do_select   S   ?   6:40  \_ centericq -a 
   100   500   733   687   9   0   2180   844 wait4       S   ?   0:24  \_ mutt 
     0   500 26664   733   9   0   3964  1492 do_select   S   ?   0:00  |   \_ /bin/vim /home/ioe/tmp/mutt-nightmaster-733-166 
   100   500   763   687   9   0   1904   528 read_chan   S   ?   0:04  \_ bash 
   100   500   772   687   9   0   1736   196 do_select   S   ?   0:22  \_ ssh bertha 
   100   500   993   687   9   0   1724     4 do_select   S   ?   0:02  \_ ssh bertha 
   100   500 16593   687   9   0   2728   136 do_select   S   ?   0:00  \_ lynx -book 
   100   500 18745   687   9   0   1848   348 wait4       S   ?   0:01  \_ bash 
     0   500 17499 18745   9   0   3932   156 do_select   S   ?   0:00  |   \_ vim widerspruch_auslbeh.tex 
     0   500 29639 18745   9   0   3832   124 do_signal   T   ?   0:00  |   \_ vim 
   100   500 25903   687   9   0   1708   104 do_select   S   ?   0:03  \_ ssh bertha 
   100   500 28477   687   9   0   1820   112 read_chan   S   ?   0:00  \_ bash 
   100     0   911     1   9   0   1156    96 nanosleep   S   ?   0:00 /usr/bin/tail -n 25 -f /var/log/messages 
   100     0  2904     1  15  10   1156    72 nanosleep   S N ?   0:01 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
   100     0  5456     1  15  10   1156    72 nanosleep   S N ?   0:00 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
    40     0  9178     1  10   0   1244   160 devfsd_read S   ?   0:00 devfsd /dev/ 
    40     0  9277     1   9   0   1644     4 wait4       S   ?   0:00 /bin/bash /etc/rc.d/init.d/mixer start 
   100     0  9284  9277   9   0   1484    40 read_chan   S   ?   0:01  \_ /usr/bin/aumix 
   100     0  9670     1  15  10   1156    72 nanosleep   S N ?   0:01 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
   100     0 10714     1  15  10   1156    96 nanosleep   S N ?   0:00 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
   100     0 14824     1  15  10   1156   356 nanosleep   S N ?   0:00 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
   100     0 15789     1  15  10   1156    72 nanosleep   S N ?   0:01 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
   100     0 20278     1  15  10   1156   356 nanosleep   S N ?   0:00 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
   100     0 21506     1  15  10   1156    72 nanosleep   S N ?   0:01 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
    40   500 22535     1   9   0   1424   540 nanosleep   S   ?   0:00 /usr/local/bin/pland -L 
    40   500 25621     1  15  10    880   320 sigsuspend  S N ?   0:00 /usr/bin/fetchpop -p -d 
   100     0 25657     1  15  10   1608   736 wait4       S N ?   0:00 /bin/sh /usr/bin/safe_mysqld --user=mysql --pid-file=/var/lib/mysql/mysqld.pid --tmpdir=/
   100   100 25669 25657  17  15  10832  1300 do_select   S N ?   0:00  \_ /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --skip-locking --log --user=mys
    40   100 25671 25669  17  15  10832  1300 do_poll     S N ?   0:00      \_ /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --skip-locking --log --user
    40   100 25672 25671  17  15  10832  1300 rt_sigsuspe S N ?   0:00          \_ /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --skip-locking --log --
   100     0 25659     1  15  10   1156   396 nanosleep   S N ?   0:00 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
   100     0 26733     1   9   0   1980    52 wait4       S    2  0:00 login -- root                                                                            
   100     0 26734 26733   8   0   1832    56 read_chan   S    2  0:00  \_ -bash 
   100     0 26746     1   9   0   9956   140 do_select   S   ?   0:05 /etc/X11/X :1 vt16 -xf86config /etc/X11/XF86Config.xmess -bpp 16 
   100     0 27394     1  15  10   1156    72 nanosleep   S N ?   0:01 /usr/bin/tail -n 25 -f /var/lib/mysql/nightmaster.csn.tu-chemnitz.de.log 
- versions of some programs
Kernel modules         2.4.15
Gnu C                  2.95.2
Gnu Make               3.76.1
Binutils               2.9.5.0.22
Linux C Library        2.1.2
Dynamic linker         ldd (GNU libc) 2.1.2
Linux C++ Library      2.9.
Procps                 1.2.9
Mount                  2.7l
Net-tools              1.50
Kbd                    0.94
Sh-utils               1.16
+ Module information
- Modules Loaded       es1371 ac97_codec soundcore nls_iso8859-1 ppp_deflate bsd_comp ppp_async ppp_generic slhc isofs inflate_fs autofs4 3c59x ipt_limit ipt_REJECT ipt_LOG ipt_MASQUERADE iptable_nat ip_conntrack iptable_filter ip_tables parport_pc parport
- Modules Loaded (detailed)        
es1371                 25992   1
ac97_codec              9320   0 [es1371]
soundcore               3684   4 [es1371]
nls_iso8859-1           2844   0 (autoclean)
ppp_deflate            39552   0 (autoclean)
bsd_comp                4160   0 (autoclean)
ppp_async               6352   0
ppp_generic            18512   0 [ppp_deflate bsd_comp ppp_async]
slhc                    4720   0 [ppp_generic]
isofs                  25232   0 (autoclean)
inflate_fs             17808   0 (autoclean) [isofs]
autofs4                 9024   2 (autoclean)
3c59x                  24880   1 (autoclean)
ipt_limit               1184   2 (autoclean)
ipt_REJECT              3104   2 (autoclean)
ipt_LOG                 3472   4 (autoclean)
ipt_MASQUERADE          1936   1 (autoclean)
iptable_nat            20144   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           20352   1 (autoclean) [ipt_MASQUERADE iptable_nat]
iptable_filter          1952   1
ip_tables              13024   8 [ipt_limit ipt_REJECT ipt_LOG ipt_MASQUERADE iptable_nat iptable_filter]
parport_pc             21760   0 (autoclean)
parport                24352   0 (autoclean) [parport_pc]
- Symbols
c4835ae0 __insmod_es1371_S.rodata_L1482	[es1371]
c4830000 __insmod_es1371_O/lib/modules/2.4.18-pre9/kernel/drivers/sound/es1371.o_M3C6BB0ED_V132114	[es1371]
c48362a0 __insmod_es1371_S.data_L744	[es1371]
c4830060 __insmod_es1371_S.text_L22862	[es1371]
c482c888 ac97_read_proc	[ac97_codec]
c482cb88 ac97_probe_codec	[ac97_codec]
c482d054 ac97_set_dac_rate	[ac97_codec]
c482d17c ac97_set_adc_rate	[ac97_codec]
c482d1e8 ac97_save_state	[ac97_codec]
c482d1ec ac97_restore_state	[ac97_codec]
c482c000 __insmod_ac97_codec_O/lib/modules/2.4.18-pre9/kernel/drivers/sound/ac97_codec.o_M3C6BB0ED_V132114	[ac97_codec]
c482c060 __insmod_ac97_codec_S.text_L4559	[ac97_codec]
c482d260 __insmod_ac97_codec_S.rodata_L3510	[ac97_codec]
c482e1c0 __insmod_ac97_codec_S.data_L680	[ac97_codec]
c482a260 register_sound_special	[soundcore]
c482a314 register_sound_mixer	[soundcore]
c482a340 register_sound_midi	[soundcore]
c482a36c register_sound_dsp	[soundcore]
c482a398 register_sound_synth	[soundcore]
c482a3c4 unregister_sound_special	[soundcore]
c482a3e0 unregister_sound_mixer	[soundcore]
c482a3f4 unregister_sound_midi	[soundcore]
c482a408 unregister_sound_dsp	[soundcore]
c482a41c unregister_sound_synth	[soundcore]
c482a7a0 mod_firmware_load	[soundcore]
c482a000 __insmod_soundcore_O/lib/modules/2.4.18-pre9/kernel/drivers/sound/soundcore.o_M3C6BB0ED_V132114	[soundcore]
c482a060 __insmod_soundcore_S.text_L1899	[soundcore]
c482a7e0 __insmod_soundcore_S.rodata_L825	[soundcore]
c482ad80 __insmod_soundcore_S.data_L104	[soundcore]
c482ae00 __insmod_soundcore_S.bss_L100	[soundcore]
c484f0f6 __insmod_nls_iso8859-1_S.rodata_L10	[nls_iso8859-1]
c484f000 __insmod_nls_iso8859-1_O/lib/modules/2.4.18-pre9/kernel/fs/nls/nls_iso8859-1.o_M3C6BB0EF_V132114	[nls_iso8859-1]
c484f060 __insmod_nls_iso8859-1_S.text_L150	[nls_iso8859-1]
c484f200 __insmod_nls_iso8859-1_S.data_L2332	[nls_iso8859-1]
c48b8aa0 deflateOutputPending	[ppp_deflate]
c48ba860 _tr_stored_block	[ppp_deflate]
c48bb62c inflateEnd	[ppp_deflate]
c48bd468 inflate_trees_bits	[ppp_deflate]
c48babf8 _tr_flush_block	[ppp_deflate]
c48bd7f0 inflate_codes	[ppp_deflate]
c48bb774 inflateInit_	[ppp_deflate]
c48bfaa0 ppp_deflate	[ppp_deflate]
c48ba988 _tr_align	[ppp_deflate]
c48be0b8 inflate_codes_free	[ppp_deflate]
c48bd5fc inflate_trees_fixed	[ppp_deflate]
c48beec0 __insmod_ppp_deflate_S.rodata_L2190	[ppp_deflate]
c48b83b4 deflateReset	[ppp_deflate]
c48bbd90 inflate_blocks_new	[ppp_deflate]
c48bff00 __insmod_ppp_deflate_S.bss_L6592	[ppp_deflate]
c48b8278 deflateSetDictionary	[ppp_deflate]
c48bfa60 z_errmsg	[ppp_deflate]
c48be590 zlibVersion	[ppp_deflate]
c48bbc1c inflateSync	[ppp_deflate]
c48bce10 inflate_packet_flush	[ppp_deflate]
c48b8088 deflateInit2_	[ppp_deflate]
c48bd4c8 inflate_trees_dynamic	[ppp_deflate]
c48bb684 inflateInit2_	[ppp_deflate]
c48bee70 deflate_init	[ppp_deflate]
c48bcc70 inflate_blocks_free	[ppp_deflate]
c48bbe08 inflate_blocks	[ppp_deflate]
c48bccdc inflate_addhistory	[ppp_deflate]
c48bb5d0 inflateReset	[ppp_deflate]
c48beea4 deflate_cleanup	[ppp_deflate]
c48ba910 _tr_stored_type_only	[ppp_deflate]
c48bf760 __insmod_ppp_deflate_S.data_L952	[ppp_deflate]
c48b8060 __insmod_ppp_deflate_S.text_L28252	[ppp_deflate]
c48bbcfc inflate_blocks_reset	[ppp_deflate]
c48bcca8 inflate_set_dictionary	[ppp_deflate]
c48b88c8 deflateCopy	[ppp_deflate]
c48bbbfc inflateIncomp	[ppp_deflate]
c48be0d0 inflate_flush	[ppp_deflate]
c48b85a0 deflate	[ppp_deflate]
c48bae3c _tr_tally	[ppp_deflate]
c48bf760 deflate_copyright	[ppp_deflate]
c48bd76c inflate_trees_free	[ppp_deflate]
c48b8824 deflateEnd	[ppp_deflate]
c48b8444 deflateParams	[ppp_deflate]
c48bf9c0 inflate_copyright	[ppp_deflate]
c48bfae0 ppp_deflate_draft	[ppp_deflate]
c48bfa00 inflate_mask	[ppp_deflate]
c48bb790 inflate	[ppp_deflate]
c48be230 inflate_fast	[ppp_deflate]
c48b9790 _tr_init	[ppp_deflate]
c48bd7b0 inflate_codes_new	[ppp_deflate]
c48b8000 __insmod_ppp_deflate_O/lib/modules/2.4.18-pre9/kernel/drivers/net/ppp_deflate.o_M3C6BB0ED_V132114	[ppp_deflate]
c48be598 adler32	[ppp_deflate]
c48b8060 deflateInit_	[ppp_deflate]
c48bbb70 inflateSetDictionary	[ppp_deflate]
c48aace0 __insmod_bsd_comp_S.rodata_L490	[bsd_comp]
c48aa000 __insmod_bsd_comp_O/lib/modules/2.4.18-pre9/kernel/drivers/net/bsd_comp.o_M3C6BB0ED_V132114	[bsd_comp]
c48aaccc bsdcomp_cleanup	[bsd_comp]
c48aa060 __insmod_bsd_comp_S.text_L3194	[bsd_comp]
c48aaca4 bsdcomp_init	[bsd_comp]
c48aaee0 __insmod_bsd_comp_S.data_L56	[bsd_comp]
c48a86c0 ppp_crc16_table	[ppp_async]
c48a7000 __insmod_ppp_async_O/lib/modules/2.4.18-pre9/kernel/drivers/net/ppp_async.o_M3C6BB0ED_V132114	[ppp_async]
c48a7060 __insmod_ppp_async_S.text_L4742	[ppp_async]
c48a8360 __insmod_ppp_async_S.rodata_L429	[ppp_async]
c48a8660 __insmod_ppp_async_S.data_L608	[ppp_async]
c48a3d88 ppp_register_channel	[ppp_generic]
c48a3e94 ppp_unregister_channel	[ppp_generic]
c48a3e48 ppp_channel_index	[ppp_generic]
c48a3e54 ppp_unit_number	[ppp_generic]
c48a2ddc ppp_input	[ppp_generic]
c48a2f68 ppp_input_error	[ppp_generic]
c48a3f34 ppp_output_wakeup	[ppp_generic]
c48a43a0 ppp_register_compressor	[ppp_generic]
c48a43f0 ppp_unregister_compressor	[ppp_generic]
c48a57b4 all_ppp_units	[ppp_generic]
c48a57c0 all_channels	[ppp_generic]
c48a1000 __insmod_ppp_generic_O/lib/modules/2.4.18-pre9/kernel/drivers/net/ppp_generic.o_M3C6BB0ED_V132114	[ppp_generic]
c48a1060 __insmod_ppp_generic_S.text_L16064	[ppp_generic]
c48a4fa0 __insmod_ppp_generic_S.rodata_L1385	[ppp_generic]
c48a57a0 __insmod_ppp_generic_S.data_L148	[ppp_generic]
c48a5834 __insmod_ppp_generic_S.bss_L8	[ppp_generic]
c486e060 slhc_init	[slhc]
c486e1dc slhc_free	[slhc]
c486ec4c slhc_remember	[slhc]
c486e298 slhc_compress	[slhc]
c486e870 slhc_uncompress	[slhc]
c486eddc slhc_toss	[slhc]
c486e000 __insmod_slhc_O/lib/modules/2.4.18-pre9/kernel/drivers/net/slhc.o_M3C6BB0ED_V132114	[slhc]
c486e060 __insmod_slhc_S.text_L3593	[slhc]
c486ee80 __insmod_slhc_S.rodata_L711	[slhc]
c488c000 __insmod_isofs_O/lib/modules/2.4.18-pre9/kernel/fs/isofs/isofs.o_M3C6BB0EE_V132114	[isofs]
c488c060 __insmod_isofs_S.text_L16020	[isofs]
c488ff00 __insmod_isofs_S.rodata_L4175	[isofs]
c4890f60 __insmod_isofs_S.data_L520	[isofs]
c4891240 __insmod_isofs_S.bss_L4120	[isofs]
c4887ca0 zlib_fs_inflate_workspacesize	[inflate_fs]
c4887e30 zlib_fs_inflate	[inflate_fs]
c4887e14 zlib_fs_inflateInit_	[inflate_fs]
c4887d3c zlib_fs_inflateInit2_	[inflate_fs]
c4887cfc zlib_fs_inflateEnd	[inflate_fs]
c48881fc zlib_fs_inflateSync	[inflate_fs]
c4887ca8 zlib_fs_inflateReset	[inflate_fs]
c4886060 zlib_fs_adler32	[inflate_fs]
c48882d0 zlib_fs_inflateSyncPoint	[inflate_fs]
c4886000 __insmod_inflate_fs_O/lib/modules/2.4.18-pre9/kernel/fs/inflate_fs/inflate_fs.o_M3C6BB0EE_V132114	[inflate_fs]
c4886060 __insmod_inflate_fs_S.text_L11264	[inflate_fs]
c4888c60 __insmod_inflate_fs_S.rodata_L1473	[inflate_fs]
c4889420 __insmod_inflate_fs_S.data_L4452	[inflate_fs]
c487cdcc is_autofs4_dentry	[autofs4]
c487c414 autofs4_read_super	[autofs4]
c487d870 autofs4_expire_multi	[autofs4]
c487d268 autofs4_wait	[autofs4]
c487dee0 autofs4_root_operations	[autofs4]
c487c138 autofs4_free_ino	[autofs4]
c487d900 __insmod_autofs4_S.rodata_L1349	[autofs4]
c487c0a0 autofs4_init_ino	[autofs4]
c487c5f8 autofs4_get_inode	[autofs4]
c487de60 __insmod_autofs4_S.data_L580	[autofs4]
c487c000 __insmod_autofs4_O/lib/modules/2.4.18-pre9/kernel/fs/autofs4/autofs4.o_M3C6BB0EE_V132114	[autofs4]
c487d060 autofs4_catatonic_mode	[autofs4]
c487c060 __insmod_autofs4_S.text_L6266	[autofs4]
c487dfe0 autofs4_dir_inode_operations	[autofs4]
c487df40 autofs4_dir_operations	[autofs4]
c487dfa0 autofs4_root_inode_operations	[autofs4]
c487d790 autofs4_expire_run	[autofs4]
c487d4b8 autofs4_wait_release	[autofs4]
c487e060 autofs4_symlink_inode_operations	[autofs4]
c487a0d4 __insmod_3c59x_S.bss_L40	[3c59x]
c4877c80 __insmod_3c59x_S.rodata_L7091	[3c59x]
c4874060 __insmod_3c59x_S.text_L15357	[3c59x]
c4879860 __insmod_3c59x_S.data_L1960	[3c59x]
c4874000 __insmod_3c59x_O/lib/modules/2.4.18-pre9/kernel/drivers/net/3c59x.o_M3C6BB0ED_V132114	[3c59x]
c486c000 __insmod_ipt_limit_O/lib/modules/2.4.18-pre9/kernel/net/ipv4/netfilter/ipt_limit.o_M3C6BB0EF_V132114	[ipt_limit]
c486c340 __insmod_ipt_limit_S.data_L88	[ipt_limit]
c486c200 __insmod_ipt_limit_S.rodata_L298	[ipt_limit]
c486c060 __insmod_ipt_limit_S.text_L406	[ipt_limit]
c486a8e0 __insmod_ipt_REJECT_S.rodata_L488	[ipt_REJECT]
c486aae0 __insmod_ipt_REJECT_S.data_L56	[ipt_REJECT]
c486a060 __insmod_ipt_REJECT_S.text_L2166	[ipt_REJECT]
c486a000 __insmod_ipt_REJECT_O/lib/modules/2.4.18-pre9/kernel/net/ipv4/netfilter/ipt_REJECT.o_M3C6BB0EF_V132114	[ipt_REJECT]
c4868760 __insmod_ipt_LOG_S.rodata_L1149	[ipt_LOG]
c4868be0 __insmod_ipt_LOG_S.data_L184	[ipt_LOG]
c4868000 __insmod_ipt_LOG_O/lib/modules/2.4.18-pre9/kernel/net/ipv4/netfilter/ipt_LOG.o_M3C6BB0EF_V132114	[ipt_LOG]
c4868060 __insmod_ipt_LOG_S.text_L1787	[ipt_LOG]
c48665e0 __insmod_ipt_MASQUERADE_S.data_L120	[ipt_MASQUERADE]
c4866060 __insmod_ipt_MASQUERADE_S.text_L834	[ipt_MASQUERADE]
c4866000 __insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre9/kernel/net/ipv4/netfilter/ipt_MASQUERADE.o_M3C6BB0EF_V132114	[ipt_MASQUERADE]
c48663c0 __insmod_ipt_MASQUERADE_S.rodata_L513	[ipt_MASQUERADE]
c485919c ip_nat_setup_info	[iptable_nat]
c4858294 ip_nat_helper_register	[iptable_nat]
c48584f8 ip_nat_helper_unregister	[iptable_nat]
c4857a30 ip_nat_expect_register	[iptable_nat]
c4857b18 ip_nat_expect_unregister	[iptable_nat]
c4858928 ip_nat_cheat_check	[iptable_nat]
c4857d10 ip_nat_mangle_tcp_packet	[iptable_nat]
c485813c ip_nat_seq_adjust	[iptable_nat]
c48581ec ip_nat_delete_sack	[iptable_nat]
c4857000 __insmod_iptable_nat_O/lib/modules/2.4.18-pre9/kernel/net/ipv4/netfilter/iptable_nat.o_M3C6BB0EF_V132114	[iptable_nat]
c4857060 __insmod_iptable_nat_S.text_L13347	[iptable_nat]
c485a4a0 __insmod_iptable_nat_S.rodata_L4622	[iptable_nat]
c485b8e0 __insmod_iptable_nat_S.data_L1444	[iptable_nat]
c485be84 __insmod_iptable_nat_S.bss_L20	[iptable_nat]
c4851620 ip_conntrack_protocol_register	[ip_conntrack]
c4852f0c invert_tuplepr	[ip_conntrack]
c48532e8 ip_conntrack_alter_reply	[ip_conntrack]
c4855acc ip_conntrack_destroyed	[ip_conntrack]
c4851f4c ip_conntrack_get	[ip_conntrack]
c4855a40 ip_conntrack_module	[ip_conntrack]
c48534bc ip_conntrack_helper_register	[ip_conntrack]
c48535a8 ip_conntrack_helper_unregister	[ip_conntrack]
c4853c00 ip_ct_selective_cleanup	[ip_conntrack]
c4853894 ip_ct_refresh	[ip_conntrack]
c4852f78 ip_conntrack_expect_related	[ip_conntrack]
c4852390 ip_conntrack_tuple_taken	[ip_conntrack]
c485396c ip_ct_gather_frags	[ip_conntrack]
c4855ae8 ip_conntrack_htable_size	[ip_conntrack]
c4851000 __insmod_ip_conntrack_O/lib/modules/2.4.18-pre9/kernel/net/ipv4/netfilter/ip_conntrack.o_M3C6BB0EF_V132114	[ip_conntrack]
c4851060 __insmod_ip_conntrack_S.text_L14528	[ip_conntrack]
c4854940 __insmod_ip_conntrack_S.rodata_L3554	[ip_conntrack]
c4855a40 __insmod_ip_conntrack_S.data_L1324	[ip_conntrack]
c4855f6c __insmod_ip_conntrack_S.bss_L12	[ip_conntrack]
c483f000 __insmod_iptable_filter_O/lib/modules/2.4.18-pre9/kernel/net/ipv4/netfilter/iptable_filter.o_M3C6BB0EF_V132114	[iptable_filter]
c483f060 __insmod_iptable_filter_S.text_L338	[iptable_filter]
c483f320 __insmod_iptable_filter_S.data_L872	[iptable_filter]
c483f1c0 __insmod_iptable_filter_S.rodata_L321	[iptable_filter]
c484be8c ipt_register_table	[ip_tables]
c484c0d8 ipt_unregister_table	[ip_tables]
c484bc7c ipt_register_match	[ip_tables]
c484bda0 ipt_unregister_match	[ip_tables]
c484a080 ipt_do_table	[ip_tables]
c484ba68 ipt_register_target	[ip_tables]
c484bb90 ipt_unregister_target	[ip_tables]
c484a000 __insmod_ip_tables_O/lib/modules/2.4.18-pre9/kernel/net/ipv4/netfilter/ip_tables.o_M3C6BB0EF_V132114	[ip_tables]
c484a060 __insmod_ip_tables_S.text_L10883	[ip_tables]
c484cb40 __insmod_ip_tables_S.rodata_L942	[ip_tables]
c484d0e0 __insmod_ip_tables_S.data_L504	[ip_tables]
c48451ac parport_pc_probe_port	[parport_pc]
c484577c parport_pc_unregister_port	[parport_pc]
c4843000 __insmod_parport_pc_O/lib/modules/2.4.18-pre9/kernel/drivers/parport/parport_pc.o_M3C6BB0ED_V132114	[parport_pc]
c4843060 __insmod_parport_pc_S.text_L12952	[parport_pc]
c4846300 __insmod_parport_pc_S.rodata_L3918	[parport_pc]
c48473c0 __insmod_parport_pc_S.data_L4384	[parport_pc]
c48484e0 __insmod_parport_pc_S.bss_L8	[parport_pc]
c483893c parport_claim	[parport]
c4838abc parport_claim_or_block	[parport]
c4838b18 parport_release	[parport]
c4838300 parport_register_port	[parport]
c483851c parport_announce_port	[parport]
c48385a4 parport_unregister_port	[parport]
c4838144 parport_register_driver	[parport]
c48381e4 parport_unregister_driver	[parport]
c483862c parport_register_device	[parport]
c4838808 parport_unregister_device	[parport]
c48382ec parport_enumerate	[parport]
c48382c4 parport_get_port	[parport]
c48382d0 parport_put_port	[parport]
c48388c8 parport_find_number	[parport]
c4838904 parport_find_base	[parport]
c483915c parport_negotiate	[parport]
c4839524 parport_write	[parport]
c483961c parport_read	[parport]
c4838d90 parport_ieee1284_wakeup	[parport]
c4838f00 parport_wait_peripheral	[parport]
c4838e74 parport_poll_peripheral	[parport]
c4838dc4 parport_wait_event	[parport]
c4839744 parport_set_timeout	[parport]
c4839500 parport_ieee1284_interrupt	[parport]
c4839d34 parport_ieee1284_ecp_write_data	[parport]
c4839f98 parport_ieee1284_ecp_read_data	[parport]
c483a278 parport_ieee1284_ecp_write_addr	[parport]
c4839780 parport_ieee1284_write_compat	[parport]
c48399d0 parport_ieee1284_read_nibble	[parport]
c4839b88 parport_ieee1284_read_byte	[parport]
c483a4e8 parport_ieee1284_epp_write_data	[parport]
c483a5f0 parport_ieee1284_epp_read_data	[parport]
c483a6f0 parport_ieee1284_epp_write_addr	[parport]
c483a800 parport_ieee1284_epp_read_addr	[parport]
c483aecc parport_proc_register	[parport]
c483b014 parport_proc_unregister	[parport]
c483b03c parport_device_proc_register	[parport]
c483b148 parport_device_proc_unregister	[parport]
c483b170 parport_default_proc_register	[parport]
c483b188 parport_default_proc_unregister	[parport]
c4838d48 parport_parse_irqs	[parport]
c4838d68 parport_parse_dmas	[parport]
c483b3ec parport_open	[parport]
c483b4ac parport_close	[parport]
c483bf5c parport_device_id	[parport]
c483b4bc parport_device_num	[parport]
c483b4fc parport_device_coords	[parport]
c483b784 parport_daisy_deselect_all	[parport]
c483b794 parport_daisy_select	[parport]
c483b244 parport_daisy_init	[parport]
c483b9dc parport_find_device	[parport]
c483ba70 parport_find_class	[parport]
c4838000 __insmod_parport_O/lib/modules/2.4.18-pre9/kernel/drivers/parport/parport.o_M3C6BB0ED_V132114	[parport]
c4838060 __insmod_parport_S.text_L16502	[parport]
c483c0e0 __insmod_parport_S.rodata_L4989	[parport]
c483dc00 __insmod_parport_S.data_L708	[parport]
c483dee0 __insmod_parport_S.bss_L64	[parport]
c0236fe0 drive_info
c01f1ee0 boot_cpu_data
c0236ca8 MCA_bus
c010d690 __verify_write
c010562c dump_thread
c010bca8 dump_fpu
c010bd50 dump_extended_fpu
c010df44 __ioremap
c010e020 iounmap
c0107e70 enable_irq
c0107e18 disable_irq
c01084e4 disable_irq_nosync
c01081b4 probe_irq_mask
c0105458 kernel_thread
c0236844 pm_idle
c0236848 pm_power_off
c010a9b4 get_cmos_time
c0236d00 apm_info
c010024c gdt
c0105ae0 __down_failed
c0105aec __down_failed_interruptible
c0105af8 __down_failed_trylock
c0105b04 __up_wakeup
c01bffbc csum_partial_copy_generic
c01c010c __udelay
c01c00e4 __delay
c01c0140 __const_udelay
c01c0320 __get_user_1
c01c0334 __get_user_2
c01c0350 __get_user_4
c01c04d4 strtok
c01c04a0 strpbrk
c01c03b0 strstr
c01c0228 strncpy_from_user
c01c0204 __strncpy_from_user
c01c0278 clear_user
c01c02b8 __clear_user
c01c01ac __generic_copy_from_user
c01c0170 __generic_copy_to_user
c01c02e4 strnlen_user
c010b2b0 pci_alloc_consistent
c010b320 pci_free_consistent
c010d3d4 pcibios_penalize_isa_irq
c01f1f80 pci_mem_start
c010cbac pcibios_set_irq_routing
c02081f4 pcibios_get_irq_routing_table
c0236cc0 screen_info
c01058bc get_wchan
c01f237c rtc_lock
c01c0370 memcpy
c01c0398 memset
c010d804 do_BUG
c0237264 is_sony_vaio_laptop
c0110428 register_exec_domain
c0110474 unregister_exec_domain
c01104b0 __set_personality
c01f280c abi_defhandler_coff
c01f2810 abi_defhandler_elf
c01f2814 abi_defhandler_lcall7
c01f2818 abi_defhandler_libcso
c0239b60 abi_traceflg
c0239b5c abi_fake_utsname
c0110c50 printk
c0110d68 acquire_console_sem
c0110e48 console_print
c0110e5c console_unblank
c0110e90 register_console
c0110fec unregister_console
c0117bf8 dequeue_signal
c0117a00 flush_signals
c01182bc force_sig
c011806c force_sig_info
c01182d4 kill_pg
c01180f4 kill_pg_info
c011831c kill_proc
c0118fd8 kill_proc_info
c01182f8 kill_sl
c0118150 kill_sl_info
c0118454 notify_parent
c0119020 recalc_sigpending
c0118298 send_sig
c0117fe4 send_sig_info
c0117aa8 block_all_signals
c0117ad8 unblock_all_signals
c0119050 notifier_chain_register
c0119084 notifier_chain_unregister
c01190b0 notifier_call_chain
c01190e8 register_reboot_notifier
c01190fc unregister_reboot_notifier
c011a15c in_group_p
c011a184 in_egroup_p
c011a970 exec_usermodehelper
c011af58 call_usermodehelper
c011ad4c request_module
c011b0b0 schedule_task
c011b2ac flush_scheduled_tasks
c01110a0 inter_module_register
c011117c inter_module_unregister
c0111208 inter_module_get
c0111260 inter_module_get_request
c0111288 inter_module_put
c0111a08 try_inc_mod_count
c011d160 do_mmap_pgoff
c011da8c do_munmap
c011dd14 do_brk
c0113040 exit_mm
c0112e30 exit_files
c0112ef0 exit_fs
c0117a1c exit_sighand
c0125550 _alloc_pages
c01257a8 __alloc_pages
c01277e0 alloc_pages_node
c012590c __get_free_pages
c0125924 get_zeroed_page
c0125948 __free_pages
c0125968 free_pages
c023fda4 num_physpages
c0123cbc kmem_find_general_cachep
c01232e4 kmem_cache_create
c01236d4 kmem_cache_destroy
c012369c kmem_cache_shrink
c01239bc kmem_cache_alloc
c0123b94 kmem_cache_free
c0123a90 kmalloc
c0123c28 kfree
c0122d38 vfree
c0122da0 __vmalloc
c023fdac mem_map
c011c3cc remap_page_range
c023fda0 max_mapnr
c023fda8 high_memory
c011c794 vmtruncate
c011d714 find_vma
c011d60c get_unmapped_area
c01f1320 init_mm
c01f43c0 def_blk_fops
c013d058 update_atime
c012ebcc get_fs_type
c012eff4 get_super
c012eed4 drop_super
c0132f60 getname
c0241ab8 names_cachep
c012b718 fput
c012b7e8 fget
c013cc94 igrab
c013cc2c iunique
c013ccec iget4
c013ce10 iput
c013d018 force_delete
c01332ac follow_up
c013332c follow_down
c013e0d0 lookup_mnt
c0133c7c path_init
c0133b00 path_walk
c0133168 path_release
c0133e9c __user_walk
c0133e30 lookup_one_len
c0133da4 lookup_hash
c012a8b4 sys_close
c01f47a0 dcache_lock
c013b374 d_alloc_root
c013b54c d_delete
c013ad14 dget_locked
c013b4b0 d_validate
c013b5b8 d_rehash
c013acb4 d_invalidate
c013b614 d_move
c013b330 d_instantiate
c013b1c4 d_alloc
c013b3b0 d_lookup
c013b72c __d_path
c012c764 mark_buffer_dirty
c012e8b0 set_buffer_async_io
c012c738 __mark_buffer_dirty
c013bc3c __mark_inode_dirty
c012b5a0 get_empty_filp
c012b6a8 init_private_file
c012a43c filp_open
c012a850 filp_close
c012b810 put_filp
c01f41e4 files_lock
c013033c check_disk_change
c012c1e0 __invalidate_buffers
c012c0a8 invalidate_bdev
c013c770 invalidate_inodes
c013c7d8 invalidate_device
c011e2c8 invalidate_inode_pages
c011e54c truncate_inode_pages
c012bc60 fsync_dev
c012bc40 fsync_no_super
c01330ec permission
c0132ffc vfs_permission
c013d308 inode_setattr
c013d1e0 inode_change_ok
c013c2f4 write_inode_now
c013d404 notify_change
c012faf8 set_blocksize
c012c664 getblk
c01307fc cdget
c01308c0 cdput
c012fefc bdget
c013004c bdput
c012c858 bread
c012c80c __brelse
c012c830 __bforget
c016ff40 ll_rw_block
c016fecc submit_bh
c012b8c0 unlock_buffer
c012b8fc __wait_on_buffer
c011eba8 ___wait_on_page
c012daf0 generic_direct_IO
c012cba0 discard_bh_page
c012d92c block_write_full_page
c012d22c block_read_full_page
c012d6cc block_prepare_write
c012e668 block_sync_page
c012d404 generic_cont_expand
c012d4dc cont_prepare_write
c012d72c generic_commit_write
c012d78c block_truncate_page
c012dab4 generic_block_bmap
c011f798 generic_file_read
c011f130 do_generic_file_read
c0120dbc generic_file_write
c012015c generic_file_mmap
c01f40a0 generic_ro_fops
c011e77c generic_buffer_fdatasync
c023fdb8 page_hash_bits
c023fdbc page_hash_table
c01f4790 file_lock_list
c013861c locks_init_lock
c01386c0 locks_copy_lock
c01392d0 posix_lock_file
c0138ee4 posix_test_lock
c013a6dc posix_block_lock
c013a6f0 posix_unblock_lock
c0138f20 posix_locks_deadlock
c0138fc4 locks_mandatory_area
c013ab70 dput
c013b09c have_submounts
c013ad44 d_find_alias
c013ad98 d_prune_aliases
c013ae00 prune_dcache
c013af58 shrink_dcache_sb
c013b170 shrink_dcache_parent
c013ba48 find_inode_number
c013b9d0 is_subdir
c012a61c get_unused_fd
c0133eec vfs_create
c01348b8 vfs_mkdir
c0134600 vfs_mknod
c0135058 vfs_symlink
c0135220 vfs_link
c0134ad4 vfs_rmdir
c0134dd0 vfs_unlink
c0135ccc vfs_rename
c0129430 vfs_statfs
c012a980 generic_read_dir
c012a988 generic_file_llseek
c012aa1c no_llseek
c0137714 __pollwait
c01376d0 poll_freewait
c0240e00 ROOT_DEV
c011ed30 __find_get_page
c011ee20 __find_lock_page
c011ef04 grab_cache_page
c011ef1c grab_cache_page_nowait
c0120c98 read_cache_page
c011e280 set_page_dirty
c0135f74 vfs_readlink
c0135fc8 vfs_follow_link
c013616c page_readlink
c01361b8 page_follow_link
c01f46e0 page_symlink_inode_operations
c012e070 block_symlink
c0137100 vfs_readdir
c01397a0 __get_lease
c01399ac lease_get_mtime
c013aa68 lock_may_read
c013aaf0 lock_may_write
c013717c dcache_readdir
c012aa28 default_llseek
c012a490 dentry_open
c011fd44 filemap_nopage
c011ff54 filemap_sync
c011e85c filemap_fdatasync
c011e8e8 filemap_fdatawait
c011ed18 lock_page
c011ec38 unlock_page
c012b33c register_chrdev
c012b3b4 unregister_chrdev
c013025c register_blkdev
c01302e0 unregister_blkdev
c0159ecc tty_register_driver
c0159f74 tty_unregister_driver
c0242520 tty_std_termios
c02560c0 blksize_size
c02564c0 hardsect_size
c0255cc0 blk_size
c024d940 blk_dev
c016f570 is_read_only
c016f5b4 set_device_ro
c013d02c bmap
c012bc98 sync_dev
c01489bc devfs_register_partitions
c0130608 blkdev_open
c0130590 blkdev_get
c0130630 blkdev_put
c01303f4 ioctl_by_bdev
c0148ab8 grok_partitions
c0148a8c register_disk
c01fc580 tq_disk
c012c260 init_buffer
c012c7fc refile_buffer
c0256cc0 max_sectors
c02568c0 max_readahead
c0157ca8 tty_hangup
c015c5e0 tty_wait_until_sent
c0157930 tty_check_change
c0157ccc tty_hung_up_p
c0159bc0 tty_flip_buffer_push
c0159b48 tty_get_baud_rate
c0159a38 do_SAK
c012e9a8 register_filesystem
c012e9f8 unregister_filesystem
c012f8d0 kern_mount
c013e2bc __mntput
c013e674 may_umount
c0131140 register_binfmt
c013118c unregister_binfmt
c0131dd8 search_binary_handler
c0131b28 prepare_binprm
c0131c38 compute_creds
c0131d74 remove_arg_zero
c0132144 set_binfmt
c011507c register_sysctl_table
c01150fc unregister_sysctl_table
c0115f8c sysctl_string
c01160c4 sysctl_intvec
c0116148 sysctl_jiffies
c01153a0 proc_dostring
c01158a4 proc_dointvec
c0115f60 proc_dointvec_jiffies
c011591c proc_dointvec_minmax
c0115f30 proc_doulongvec_ms_jiffies_minmax
c0115f04 proc_doulongvec_minmax
c0116ca0 add_timer
c0116e38 del_timer
c0107fa0 request_irq
c0108044 free_irq
c023e4a0 irq_stat
c010f2e0 add_wait_queue
c010f308 add_wait_queue_exclusive
c010f32c remove_wait_queue
c010e748 wait_for_completion
c010e6a8 complete
c01080bc probe_irq_on
c010821c probe_irq_off
c0116d6c mod_timer
c01f35d4 tq_timer
c01f35dc tq_immediate
c013db5c alloc_kiovec
c013dbf0 free_kiovec
c013dc5c expand_kiobuf
c011bf20 map_user_kiobuf
c011c090 unmap_kiobuf
c011c0d4 lock_kiovec
c011c1c0 unlock_kiovec
c012dcd8 brw_kiovec
c013dcf4 kiobuf_wait_for_io
c010f278 request_dma
c010f2b0 free_dma
c01f26c0 dma_spin_lock
c0105140 disable_hlt
c0105148 enable_hlt
c0114a44 request_resource
c0114a64 release_resource
c0114b64 allocate_resource
c0114a74 check_resource
c0114bbc __request_region
c0114c38 __check_region
c0114c78 __release_region
c01f2aa0 ioport_resource
c01f2abc iomem_resource
c01134d4 complete_and_exit
c010e570 __wake_up
c010e608 __wake_up_sync
c010f1d8 wake_up_process
c010e888 sleep_on
c010e8d8 sleep_on_timeout
c010e7dc interruptible_sleep_on
c010e82c interruptible_sleep_on_timeout
c010e24c schedule
c010e1a8 schedule_timeout
c023e864 jiffies
c023e870 xtime
c010a630 do_gettimeofday
c010a69c do_settimeofday
c01f1448 loops_per_jiffy
c0237360 kstat
c0238b20 nr_running
c0110620 panic
c01c105c sprintf
c01c1020 snprintf
c01c1410 sscanf
c01c1040 vsprintf
c01c0c3c vsnprintf
c01c1074 vsscanf
c012b468 kdevname
c0130728 bdevname
c012b494 cdevname
c01c0664 simple_strtol
c01c05c0 simple_strtoul
c01c0690 simple_strtoull
c01f1460 system_utsname
c01f3664 uts_sem
c01f1660 sys_call_table
c0105294 machine_restart
c0105314 machine_halt
c0105318 machine_power_off
c0200858 _ctype
c015f6ac secure_tcp_sequence_number
c015ea88 get_random_bytes
c01f2680 securebits
c01f35c4 cap_bset
c010f04c reparent_to_init
c010f174 daemonize
c01bff20 csum_partial
c013fd90 seq_escape
c013fe2c seq_printf
c013f7f0 seq_open
c013fd70 seq_release
c013f854 seq_read
c013fc64 seq_lseek
c013155c setup_arg_pages
c01314a4 copy_strings_kernel
c0131f54 do_execve
c01318e0 flush_old_exec
c0131768 kernel_read
c0131698 open_exec
c010d654 si_meminfo
c023e480 sys_tz
c012bcbc file_fsync
c012c2f8 fsync_inode_buffers
c012c41c fsync_inode_data_buffers
c013c568 clear_inode
c025dacc ___strtok
c012b4d8 init_special_inode
c024d540 read_ahead
c012bf7c get_hash_table
c013ca34 get_empty_inode
c013cdb8 insert_inode_hash
c013cdfc remove_inode_hash
c012c00c buffer_insert_inode_queue
c013d5a4 make_bad_inode
c013d5d4 is_bad_inode
c023e840 event
c012dfcc brw_page
c01f3634 overflowuid
c01f3638 overflowgid
c01f363c fs_overflowuid
c01f3640 fs_overflowgid
c0136cb8 fasync_helper
c0136de8 kill_fasync
c0148350 disk_name
c013311c get_write_access
c01c03f0 strnicmp
c01c045c strspn
c01c0534 strsep
c02365a0 tasklet_hi_vec
c0236580 tasklet_vec
c023e4c0 bh_task_vec
c0114778 init_bh
c0114790 remove_bh
c01146ac tasklet_init
c01146d4 tasklet_kill
c01147bc __run_task_queue
c0114420 do_softirq
c01144cc raise_softirq
c01148bc cpu_raise_softirq
c0114524 __tasklet_schedule
c0114568 __tasklet_hi_schedule
c0202000 init_task_union
c0236520 tasklist_lock
c0238b40 pidhash
c01f3844 vm_max_readahead
c01f3848 vm_min_readahead
c011e828 fail_writepage
c012923c shmem_file_setup
c012a938 generic_file_open
c012c794 set_buffer_flushtime
c012c93c put_unused_buffer_head
c012c94c get_unused_buffer_head
c012c9c4 set_bh_page
c012cc20 create_empty_buffers
c012da08 writeout_one_page
c012da74 waitfor_one_page
c012e4ec try_to_free_buffers
c0241ac4 bh_cachep
c01f48a8 nfsd_linkage
c0241dd4 proc_sys_root
c0145d4c proc_symlink
c0145dc4 proc_mknod
c0145e04 proc_mkdir
c0145e44 create_proc_entry
c0145f20 remove_proc_entry
c01f4be0 proc_root
c0241dc4 proc_root_fs
c0241dc8 proc_net
c0241dcc proc_bus
c0241dd0 proc_root_driver
c014ec8c devfs_put
c014f7f4 devfs_register
c014fbd8 devfs_unregister
c014fd7c devfs_mk_symlink
c014fde8 devfs_mk_dir
c014fefc devfs_get_handle
c014ff34 devfs_find_handle
c014ff6c devfs_get_flags
c014ffd0 devfs_set_flags
c0150034 devfs_get_maj_min
c0150090 devfs_get_handle_from_inode
c01500bc devfs_generate_path
c0150168 devfs_get_ops
c0150240 devfs_set_file_size
c0150288 devfs_get_info
c0150298 devfs_set_info
c01502b8 devfs_get_parent
c01502c8 devfs_get_first_child
c01502ec devfs_get_next_sibling
c01502fc devfs_auto_unregister
c015036c devfs_get_unregister_slave
c015037c devfs_get_name
c01503a0 devfs_register_chrdev
c01503c4 devfs_register_blkdev
c01503e8 devfs_unregister_chrdev
c0150408 devfs_unregister_blkdev
c0151c90 devfs_register_tape
c0151d48 devfs_register_series
c0151dd0 devfs_alloc_major
c0151e24 devfs_dealloc_major
c0151e58 devfs_alloc_devnum
c0151ffc devfs_dealloc_devnum
c01520b8 devfs_alloc_unique_number
c0152248 devfs_dealloc_unique_number
c01524c4 register_nls
c0152518 unregister_nls
c0152608 unload_nls
c0152598 load_nls
c0152698 load_nls_default
c0152320 utf8_mbtowc
c015238c utf8_mbstowcs
c01523e4 utf8_wctomb
c0152468 utf8_wcstombs
c01576dc tty_register_ldisc
c0159dc0 tty_register_devfs
c0159e7c tty_unregister_devfs
c015cc24 n_tty_ioctl
c015df3c misc_register
c015e06c misc_deregister
c015e590 add_keyboard_randomness
c015e5b8 add_mouse_randomness
c015e5cc add_interrupt_randomness
c015e5f4 add_blkdev_randomness
c015e384 batch_entropy_store
c015f12c generate_random_uuid
c01f7b3c color_table
c01f7b4c default_red
c01f7b8c default_grn
c01f7bcc default_blu
c024adfc video_font_height
c024ae04 video_scan_lines
c0163f70 vc_resize
c024af30 fg_console
c024b470 console_blank_hook
c024ad00 vt_cons
c0167430 take_over_console
c01675b4 give_up_console
c016806c set_selection
c01685c0 paste_selection
c016c3a8 register_serial
c016c5f8 unregister_serial
c016c960 handle_scancode
c024d45c kbd_ledfunc
c01faecc keyboard_tasklet
c016e05c handle_sysrq
c016e08c __handle_sysrq_nolock
c016dff0 __sysrq_lock_table
c016dff4 __sysrq_unlock_table
c016dff8 __sysrq_get_key_op
c016e028 __sysrq_put_key_op
c01fc588 io_request_lock
c0170108 end_that_request_first
c01701c8 end_that_request_last
c016f408 blk_init_queue
c017023c blk_get_queue
c016f1c0 blk_cleanup_queue
c016f200 blk_queue_headactive
c016f20c blk_queue_make_request
c016fd80 generic_make_request
c0170274 blkdev_release_request
c016f324 generic_unplug_device
c0170720 blk_ioctl
c02590c0 gendisk_head
c0170bc0 add_gendisk
c0170bf8 del_gendisk
c0170c34 get_gendisk
c0171268 init_etherdev
c0171288 alloc_etherdev
c0171308 ether_setup
c0171394 register_netdev
c0171404 unregister_netdev
c0171500 autoirq_setup
c017150c autoirq_report
c0259540 ide_hwifs
c0175b4c ide_register_module
c0175b88 ide_unregister_module
c01745dc ide_spin_wait_hwgroup
c0259520 ide_probe
c01718dc drive_is_flashcard
c0173240 ide_timer_expiry
c01734a0 ide_intr
c01fd2a0 ide_fops
c0173168 ide_get_queue
c01747ec ide_add_generic_settings
c025b3e0 ide_devfs_handle
c01731a0 do_ide_request
c0175924 ide_scan_devices
c01759e4 ide_register_subdriver
c0175adc ide_unregister_subdriver
c0173a94 ide_replace_subdriver
c0171a6c ide_input_data
c0171b30 ide_output_data
c0171be0 atapi_input_bytes
c0171c48 atapi_output_bytes
c0171d44 ide_set_handler
c01723a0 ide_dump_status
c01726cc ide_error
c0175768 ide_fixstring
c0172a04 ide_wait_stat
c0172288 ide_do_reset
c0172e50 restart_request
c0173654 ide_init_drive_cmd
c0173670 ide_do_drive_cmd
c0172298 ide_end_drive_cmd
c0171cb0 ide_end_request
c017378c ide_revalidate_disk
c0172848 ide_cmd
c01749e8 ide_wait_cmd
c0174a64 ide_wait_cmd_task
c0174a9c ide_delay_50ms
c0172e84 ide_stall_queue
c0178978 ide_add_proc_entries
c01789d0 ide_remove_proc_entries
c0178710 proc_ide_read_geometry
c0178b7c create_proc_ide_interfaces
c0174380 ide_add_setting
c017449c ide_remove_setting
c01741a4 ide_register_hw
c0174320 ide_register
c0173c50 ide_unregister
c0174140 ide_setup_ports
c0173b2c hwif_unregister
c01735ec get_info_ptr
c0171da4 current_capacity
c0174ab8 system_bus_clock
c0175d5c ide_auto_reduce_xfer
c0175e64 ide_driveid_update
c0175ff4 ide_ata66_check
c0176054 set_transfer
c0176094 eighty_ninty_three
c01760c8 ide_config_drive_speed
c0182be0 cdrom_get_disc_info
c0182b34 cdrom_get_track_info
c0182da0 cdrom_get_next_writable
c0182c70 cdrom_get_last_written
c017ffdc cdrom_count_tracks
c017f310 register_cdrom
c017f58c unregister_cdrom
c017f664 cdrom_open
c017fb6c cdrom_release
c0180e34 cdrom_ioctl
c017ffa0 cdrom_media_changed
c017fd58 cdrom_number_of_slots
c017fe58 cdrom_select_disc
c0180bb8 cdrom_mode_select
c0180b54 cdrom_mode_sense
c01801dc init_cdrom_command
c017f648 cdrom_find_device
c0183f68 pci_read_config_byte
c0183f90 pci_read_config_word
c0183fc8 pci_read_config_dword
c0183ffc pci_write_config_byte
c018402c pci_write_config_word
c018406c pci_write_config_dword
c01fd788 pci_devices
c01fd780 pci_root_buses
c0183a50 pci_enable_device
c0183a70 pci_disable_device
c0183764 pci_find_capability
c0183be8 pci_release_regions
c0183c60 pci_request_regions
c0183734 pci_find_class
c0183718 pci_find_device
c0183660 pci_find_slot
c01836a0 pci_find_subsys
c01840a4 pci_set_master
c01840f0 pci_set_dma_mask
c0184120 pci_dac_set_dma_mask
c0185844 pci_assign_resource
c0183e8c pci_register_driver
c0183eec pci_unregister_driver
c0183f38 pci_dev_driver
c0183db8 pci_match_device
c018381c pci_find_parent_resource
c0183890 pci_set_power_state
c01839a4 pci_save_state
c01839d8 pci_restore_state
c0183ab4 pci_enable_wake
c0184ad0 pcibios_present
c0184b9c pcibios_read_config_byte
c0184bdc pcibios_read_config_word
c0184c1c pcibios_read_config_dword
c0184c5c pcibios_write_config_byte
c0184ca8 pcibios_write_config_word
c0184cf8 pcibios_write_config_dword
c0184ae4 pcibios_find_class
c0184b3c pcibios_find_device
c025b824 isa_dma_bridge_buggy
c025b820 pci_pci_problems
c0184520 pci_pool_create
c018473c pci_pool_destroy
c01847d0 pci_pool_alloc
c0184970 pci_pool_free
c0189af0 skb_over_panic
c0189b30 skb_under_panic
c0188538 sock_register
c018857c sock_unregister
c0189428 __lock_sock
c01894d8 __release_sock
c018b520 memcpy_fromiovec
c018b4cc memcpy_tokerneliovec
c01875f8 sock_create
c0186e04 sock_alloc
c0186ebc sock_release
c0188704 sock_setsockopt
c0188c3c sock_getsockopt
c0186f0c sock_sendmsg
c0186f94 sock_recvmsg
c0188f70 sk_alloc
c0188fc8 sk_free
c018757c sock_wake_async
c0189404 sock_alloc_send_skb
c018924c sock_alloc_send_pskb
c0189950 sock_init_data
c01896a8 sock_no_release
c01896ac sock_no_bind
c01896b4 sock_no_connect
c01896bc sock_no_socketpair
c01896c4 sock_no_accept
c01896cc sock_no_getname
c01896d4 sock_no_poll
c01896d8 sock_no_ioctl
c01896e0 sock_no_listen
c01896e8 sock_no_shutdown
c01896f8 sock_no_getsockopt
c01896f0 sock_no_setsockopt
c0189768 sock_no_sendmsg
c0189770 sock_no_recvmsg
c0189778 sock_no_mmap
c0189780 sock_no_sendpage
c0189070 sock_rfree
c0189038 sock_wfree
c0189080 sock_wmalloc
c01890d4 sock_rmalloc
c018a2c4 skb_linearize
c018ae14 skb_checksum
c018d2ec skb_checksum_help
c018b940 skb_recv_datagram
c018ba04 skb_free_datagram
c018ba24 skb_copy_datagram
c018ba54 skb_copy_datagram_iovec
c018bef4 skb_copy_and_csum_datagram_iovec
c018ac2c skb_copy_bits
c018b034 skb_copy_and_csum_bits
c018b27c skb_copy_and_csum_dev
c018a710 skb_copy_expand
c018a7d8 ___pskb_trim
c018a944 __pskb_pull_tail
c018a560 pskb_expand_head
c018a3f0 pskb_copy
c018a690 skb_realloc_headroom
c018bfcc datagram_poll
c018c310 put_cmsg
c018911c sock_kmalloc
c0189158 sock_kfree_s
c018c684 sk_run_filter
c018ca84 sk_chk_filter
c0190de0 neigh_table_init
c0190ed4 neigh_table_clear
c0190850 neigh_resolve_output
c01909f8 neigh_connected_output
c0190320 neigh_update
c018f90c neigh_create
c018f898 neigh_lookup
c019016c __neigh_event_send
c0190654 neigh_event_ns
c018f634 neigh_ifdown
c019165c neigh_sysctl_register
c018fa7c pneigh_lookup
c0190bcc pneigh_enqueue
c018fcfc neigh_destroy
c0190ca8 neigh_parms_alloc
c0190d5c neigh_parms_release
c018f4a8 neigh_rand_reach_time
c01907c0 neigh_compat_output
c018f1d0 dst_alloc
c018f24c __dst_free
c018f2e4 dst_destroy
c0192640 net_ratelimit
c0192600 net_random
c0192630 net_srandom
c018c148 __scm_destroy
c018c180 __scm_send
c018c5f4 scm_fp_dup
c01f41c8 files_stat
c018b464 memcpy_toiovec
c01895c4 sklist_destroy_socket
c018957c sklist_insert_socket
c018c3dc scm_detach_fds
c01ff538 inetdev_lock
c01990c0 inet_add_protocol
c0199138 inet_del_protocol
c01b9780 inet_register_protosw
c01b982c inet_unregister_protosw
c0197ca8 ip_route_output_key
c0197584 ip_route_input
c01b618c icmp_send
c019a9cc ip_options_compile
c019af88 ip_options_undo
c01b4f04 arp_send
c01ff0e0 arp_broken_ops
c01961bc __ip_select_ident
c019c768 ip_send_check
c019c238 ip_fragment
c01ffae4 inet_family_ops
c01956a4 in_aton
c01ba094 ip_mc_inc_group
c01ba190 ip_mc_dec_group
c019c7b0 ip_finish_output
c01ffa40 inet_stream_ops
c01ffaa0 inet_dgram_ops
c019cc28 ip_cmsg_recv
c01babdc inet_addr_type
c01b7cb0 inet_select_addr
c01bab5c ip_dev_find
c01b724c inetdev_by_index
c01b6c0c in_dev_finish_destroy
c019a11c ip_defrag
c01bae78 ip_rt_ioctl
c01b756c devinet_ioctl
c01b7d64 register_inetaddr_notifier
c01b7d78 unregister_inetaddr_notifier
c025c820 ip_statistics
c0194bf0 netlink_set_err
c0194a08 netlink_broadcast
c0194740 netlink_unicast
c0194ff4 netlink_kernel_create
c019522c netlink_dump_start
c019530c netlink_ack
c0195410 netlink_attach
c019546c netlink_detach
c01954ac netlink_post
c0191a04 rtattr_parse
c025bc00 rtnetlink_links
c0191a90 __rta_fill
c0192040 rtnetlink_dump_ifinfo
c0191b88 rtnetlink_put_metrics
c025bbe0 rtnl
c0190f68 neigh_delete
c0191080 neigh_add
c01915c4 neigh_dump_info
c018df68 dev_set_allmulti
c018df0c dev_set_promiscuity
c0189520 sklist_remove_socket
c01fe460 rtnl_sem
c01919c0 rtnl_lock
c01919d4 rtnl_unlock
c0186ac0 move_addr_to_kernel
c0186af8 move_addr_to_user
c025d684 ipv4_config
c018d108 dev_open
c0195670 in_ntoa
c01b5efc xrlim_allow
c019938c ip_rcv
c01b5108 arp_rcv
c01ff100 arp_tbl
c01b4d38 arp_find
c018d218 register_netdevice_notifier
c018d22c unregister_netdevice_notifier
c01fcfa0 loopback_dev
c018e74c register_netdevice
c018e8f8 unregister_netdevice
c018d068 netdev_state_change
c018e714 dev_new_index
c018ced4 dev_get_by_index
c018ceb8 __dev_get_by_index
c018ce88 dev_get_by_name
c018ce2c __dev_get_by_name
c018e858 netdev_finish_unregister
c018de48 netdev_set_master
c0193664 eth_type_trans
c0189b70 alloc_skb
c0189e34 __kfree_skb
c0189f6c skb_clone
c018a1e0 skb_copy
c018d65c netif_rx
c018cc30 dev_add_pack
c018cc8c dev_remove_pack
c018cea0 dev_get
c018d000 dev_alloc
c018cf68 dev_alloc_name
c01939f4 __netdev_watchdog_up
c018d090 dev_load
c018e42c dev_ioctl
c018d3a0 dev_queue_xmit
c01fd0d8 dev_base
c01fd0dc dev_base_lock
c018d1ac dev_close
c018ed3c dev_mc_add
c018ec24 dev_mc_delete
c018ebf8 dev_mc_upload
c0136d88 __kill_fasync
c01fdf68 if_port_text
c01fdce0 sysctl_wmem_max
c01fdce4 sysctl_rmem_max
c01fed00 sysctl_ip_default_ttl
c0193da0 qdisc_destroy
c0193d88 qdisc_reset
c0193850 qdisc_restart
c0193ccc qdisc_create_dflt
c01fe680 noop_qdisc
c01fe620 qdisc_tree_lock
c01926d0 nf_register_hook
c019273c nf_unregister_hook
c0192768 nf_register_sockopt
c01928bc nf_unregister_sockopt
c0193100 nf_reinject
c0192dc8 nf_register_queue_handler
c0192e24 nf_unregister_queue_handler
c0192f78 nf_hook_slow
c025bca0 nf_hooks
c0192ce8 nf_setsockopt
c0192d10 nf_getsockopt
c025c4a0 ip_ct_attach
c0193278 ip_route_me_harder
c018daa8 register_gifconf
c018d874 net_call_rx_atomic
c02366e0 softnet_data
c01c14c4 memparse
c01c1430 get_option
c01c147c get_options
c01c18b0 rwsem_down_read_failed
c01c19c8 rwsem_down_write_failed
c01c1ae8 rwsem_wake
+ End of Information gathered

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_PPRO_FENCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=m
CONFIG_ISAPNP=m

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=4
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_SCSI_IZIP_EPP16=y
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=m
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
# CONFIG_LANCE is not set
CONFIG_NET_VENDOR_SMC=y
# CONFIG_WD80x3 is not set
# CONFIG_ULTRAMCA is not set
CONFIG_ULTRA=m
# CONFIG_ULTRA32 is not set
# CONFIG_SMC9194 is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
# CONFIG_SERIAL_MANY_PORTS is not set
# CONFIG_SERIAL_SHARE_IRQ is not set
CONFIG_SERIAL_DETECT_IRQ=y
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
CONFIG_MWAVE=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=m
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=m
CONFIG_ZLIB_FS_INFLATE=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
CONFIG_SOUND_ES1371=m
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
CONFIG_SOUND_ADLIB=m
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
CONFIG_SOUND_VMIDI=m
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
CONFIG_SOUND_MPU401=m
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
# CONFIG_USB is not set

#
# USB Controllers
#
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#

#
#   Input core support is needed for USB HID
#

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_BUGVERBOSE=y

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=log

Mar 28 09:18:01 nightmaster kernel: ATAPI device hdb: 
Mar 28 09:18:01 nightmaster kernel:   Error: Not ready -- (Sense key=0x02) 
Mar 28 09:18:01 nightmaster kernel:   Media load or eject failed -- (asc=0x53, ascq=0x00) 
Mar 28 09:18:01 nightmaster kernel:   The failed "Start/Stop Unit" packet command was:  
Mar 28 09:18:01 nightmaster kernel:   "1b 00 00 00 03 00 00 00 00 00 00 00 " 
Mar 28 09:18:01 nightmaster kernel: cdrom: open failed. 
Mar 28 09:18:01 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 09:18:40 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 09:18:50 nightmaster kernel: hdb: irq timeout: status=0xd0 { Busy } 
Mar 28 09:18:50 nightmaster kernel: hdb: DMA disabled 
Mar 28 09:18:51 nightmaster kernel: hdb: ATAPI reset complete 
Mar 28 09:19:33 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 09:19:38 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 09:19:38 nightmaster kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error } 
Mar 28 09:19:38 nightmaster kernel: hdb: drive_cmd: error=0x04 
Mar 28 09:19:43 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 09:19:43 nightmaster kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error } 
Mar 28 09:19:43 nightmaster kernel: hdb: drive_cmd: error=0x04 
Mar 28 09:19:45 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 09:25:37 nightmaster kernel: ATAPI device hdb: 
Mar 28 09:25:37 nightmaster kernel:   Error: Not ready -- (Sense key=0x02) 
Mar 28 09:25:37 nightmaster kernel:   Media load or eject failed -- (asc=0x53, ascq=0x00) 
Mar 28 09:25:37 nightmaster kernel:   The failed "Start/Stop Unit" packet command was:  
Mar 28 09:25:37 nightmaster kernel:   "1b 00 00 00 03 00 00 00 00 00 00 00 " 
Mar 28 09:25:37 nightmaster kernel: cdrom: open failed. 
Mar 28 09:25:37 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 11:17:54 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 13:24:06 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 13:25:20 nightmaster last message repeated 3 times
Mar 28 13:25:30 nightmaster kernel: hdb: irq timeout: status=0xd0 { Busy } 
Mar 28 13:25:30 nightmaster kernel: hdb: ATAPI reset complete 
Mar 28 13:25:40 nightmaster kernel: hdb: irq timeout: status=0xc0 { Busy } 
Mar 28 13:25:40 nightmaster kernel: hdb: ATAPI reset complete 
Mar 28 13:25:43 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 13:25:53 nightmaster kernel: hdb: irq timeout: status=0xd0 { Busy } 
Mar 28 13:25:53 nightmaster kernel: hdb: ATAPI reset complete 
Mar 28 13:28:22 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 13:29:58 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 
Mar 28 13:29:58 nightmaster kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error } 
Mar 28 13:29:58 nightmaster kernel: hdb: drive_cmd: error=0x04 
Mar 28 13:29:58 nightmaster kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error } 
Mar 28 13:29:58 nightmaster kernel: hdb: drive_cmd: error=0x04 
Mar 28 13:30:06 nightmaster kernel: VFS: Disk change detected on device ide0(3,64) 

--liOOAslEiF7prFVr--
