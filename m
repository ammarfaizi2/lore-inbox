Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbSJ3X2C>; Wed, 30 Oct 2002 18:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSJ3X2C>; Wed, 30 Oct 2002 18:28:02 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:8452 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S265008AbSJ3X14>; Wed, 30 Oct 2002 18:27:56 -0500
Date: Wed, 30 Oct 2002 18:34:16 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44-mm6 issues
Message-ID: <Pine.LNX.4.44.0210301830500.1451-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile with netfilter enabled:

Sep 24 17:06:29 oddball xinetd[911]: Error parsing attribute server - DISABLING SERVICE [line=14]
Sep 24 17:06:29 oddball xinetd[911]: Server internal is not executable [line=14]
Sep 24 17:06:29 oddball xinetd[911]: Error parsing attribute server - DISABLING SERVICE [line=14]
Sep 24 17:06:29 oddball xinetd[911]: id not unique: ntalk [line=14]
Sep 24 17:06:30 oddball xinetd[911]: xinetd Version 2002.03.28 started with libwrap options compiled in.
Sep 24 17:06:30 oddball xinetd[911]: Started working: 1 available service
Sep 24 17:06:32 oddball xinetd: xinetd startup succeeded
Sep 24 17:06:34 oddball sendmail: sendmail startup succeeded
Sep 24 17:06:34 oddball touchpad: 
Sep 24 17:06:34 oddball touchpad: Turning off Touch-Pad 'tapping' 
Sep 24 17:06:34 oddball touchpad: fatal: 
Sep 24 17:06:34 oddball touchpad: 
Sep 24 17:06:34 oddball touchpad: No Synaptics or ALPS touchpad device found
Sep 24 17:06:34 oddball touchpad: 
Sep 24 17:06:34 oddball last message repeated 2 times
Sep 24 17:06:34 oddball touchpad: ========================================================================
Sep 24 17:06:34 oddball touchpad: =                                                                      =
Sep 24 17:06:34 oddball touchpad: =                tpconfig   version: 3.1.3                             =
Sep 24 17:06:34 oddball touchpad: =                                                                      =
Sep 24 17:06:34 oddball touchpad: = Synaptics Touchpad and ALPS GlidePad/Stickpointer configuration tool =
Sep 24 17:06:34 oddball touchpad: =                                                                      =
Sep 24 17:06:34 oddball touchpad: = Copyright (C) 1997 C. Scott Ananian<cananian@alumni.princeton.edu>   =
Sep 24 17:06:34 oddball touchpad: = Copyright (C) 1998-2001 Bruce Kall <kall@compass.com>                =
Sep 24 17:06:34 oddball touchpad: = Last Modified (Version 3.1.3) by Bruce Kall, 2/22/2002              =
Sep 24 17:06:34 oddball touchpad: =                                                                      =
Sep 24 17:06:34 oddball touchpad: = tpconfig comes with ABSOLUTELY NO WARRANTY.  This is free software,  =
Sep 24 17:06:34 oddball touchpad: = and you are welcome to redistribute it under the terms of the GPL.   =
Sep 24 17:06:34 oddball touchpad: =                                                                      =
Sep 24 17:06:34 oddball touchpad: ========================================================================
Sep 24 17:06:34 oddball touchpad: 
Sep 24 17:06:34 oddball touchpad: ^[[60G[  ^[[1;32mOK^[[0;39m
Sep 24 17:06:34 oddball rc: Starting touchpad:  succeeded
Sep 24 17:06:35 oddball gpm: gpm startup succeeded
Sep 24 17:06:35 oddball wwwoffled: Starting wwwoffled: 
Sep 24 17:06:35 oddball wwwoffled: Starting wwwoffled:  succeeded
Sep 24 17:06:35 oddball wwwoffled: ^[[60G
Sep 24 17:06:35 oddball wwwoffled: 
Sep 24 17:06:35 oddball rc: Starting wwwoffled:  succeeded
Sep 24 17:06:36 oddball crond: crond startup succeeded
Sep 24 17:06:37 oddball xfs: xfs startup succeeded
Sep 24 17:06:37 oddball xfs: listening on port 7100 
Sep 24 17:06:37 oddball anacron: anacron startup succeeded
Sep 24 17:06:37 oddball atd: atd startup succeeded
Sep 24 17:06:37 oddball xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/cyrillic (unreadable) 
Sep 24 17:06:37 oddball xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/CID (unreadable) 
Sep 24 17:06:37 oddball xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/local (unreadable) 
Sep 24 17:06:37 oddball xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/latin2/Type1 (unreadable) 
Sep 24 17:06:37 oddball linuxconf-setup: Linuxconf final setup
Sep 24 17:06:38 oddball linuxconf-setup:   Setting firewalling
Sep 24 17:06:38 oddball linuxconf-setup:   Checking kernel configuration
Sep 24 17:06:38 oddball rc: Starting linuxconf-setup:  succeeded
Sep 24 17:06:37 oddball ntpd[1142]: ntpd 4.1.1@1.786 Mon Apr  8 06:30:52 EDT 2002 (1)
Sep 24 17:06:37 oddball ntpd: ntpd startup succeeded
Sep 24 17:06:37 oddball ntpd[1142]: precision = 13 usec
Sep 24 17:06:37 oddball ntpd[1142]: kernel time discipline status 0040
Sep 24 17:06:37 oddball ntpd[1142]: frequency initialized -18.936 from /etc/ntp/drift
Sep 24 17:06:39 oddball modprobe: modprobe: Can't locate module char-major-10-134
Sep 24 17:06:39 oddball kernel: Sleeping function called from illegal context at slab.c:1378
Sep 24 17:06:39 oddball kernel: c3d79f5c c0112a86 c02a29a0 c02a4842 00000562 c40fc300 c012c9a5 c02a4842 
Sep 24 17:06:39 oddball kernel:        00000562 c012745e c4aef200 c3d97d40 c3d97e00 00000000 00000400 00000001 
Sep 24 17:06:39 oddball kernel:        c3ff9c00 c010cd93 00000080 000001d0 00000000 c3d78000 08080410 00000018 
Sep 24 17:06:39 oddball kernel: Call Trace: [<c0112a86>] [<c012c9a5>] [<c012745e>] [<c010cd93>] [<c0108d2f>] 
Sep 24 17:06:51 oddball gdm(pam_unix)[1160]: authentication failure; logname= uid=0 euid=0 tty=:0 ruser= rhost=  user=bill
Sep 24 17:06:54 oddball gdm[1160]: Couldn't authenticate user
Sep 24 17:06:59 oddball gdm(pam_unix)[1160]: session opened for user bill by (uid=0)
Sep 24 17:07:04 oddball modprobe: modprobe: Can't locate module sound-slot-0
Sep 24 17:07:04 oddball modprobe: modprobe: Can't locate module sound-service-0-0
Sep 24 17:07:10 oddball gnome-name-server[1288]: starting
Sep 24 17:07:10 oddball gnome-name-server[1288]: name server starting
Sep 24 17:07:10 oddball gnome-name-server[1289]: starting
Sep 24 17:07:10 oddball gnome-name-server[1289]: name server was running on display, exiting
Sep 24 17:07:10 oddball gconfd (bill-1291): starting (version 1.0.9), pid 1291 user 'bill'
Sep 24 17:07:10 oddball gconfd (bill-1291): Unable to open saved state file '/home/bill/.gconfd/saved_state': No such file or directory
Sep 24 17:07:16 oddball kernel: cdrom: This disc doesn't have any tracks I recognize!
Sep 24 17:08:49 oddball gdm(pam_unix)[1160]: session closed for user bill
Sep 24 17:08:49 oddball gnome-name-server[1288]: input condition is: 0x11, exiting
Sep 24 17:08:49 oddball modprobe: modprobe: Can't locate module char-major-10-134
Sep 24 17:08:56 oddball gdm(pam_unix)[1160]: session opened for user bill by (uid=0)
Sep 24 17:08:59 oddball modprobe: modprobe: Can't locate module sound-slot-0
Sep 24 17:08:59 oddball modprobe: modprobe: Can't locate module sound-service-0-0
Sep 24 17:09:02 oddball gnome-name-server[1604]: starting
Sep 24 17:09:02 oddball gnome-name-server[1604]: name server starting
Sep 24 17:09:02 oddball gnome-name-server[1605]: starting
Sep 24 17:09:02 oddball gnome-name-server[1605]: name server was running on display, exiting
Sep 24 17:09:02 oddball gnome-name-server[1606]: starting
Sep 24 17:09:02 oddball gnome-name-server[1606]: name server was running on display, exiting
Sep 24 17:09:06 oddball kernel: cdrom: This disc doesn't have any tracks I recognize!
Sep 24 17:09:52 oddball ntpd[1142]: kernel time discipline status change 41
Sep 24 17:50:00 oddball shutdown: shutting down for system halt
Sep 24 17:50:00 oddball init: Switching to runlevel: 0
Sep 24 17:50:07 oddball atd: atd shutdown succeeded
Sep 24 17:50:07 oddball Font Server[1075]: terminating 
Sep 24 17:50:07 oddball xfs: xfs shutdown succeeded
Sep 24 17:50:07 oddball gpm: gpm shutdown succeeded
Sep 24 17:50:08 oddball wwwoffled: wwwoffled shutdown succeeded
Sep 24 17:50:08 oddball sshd: sshd -TERM succeeded
Sep 24 17:50:08 oddball sendmail: sendmail shutdown succeeded
Sep 24 17:50:08 oddball xinetd[911]: Exiting...
Sep 24 17:50:08 oddball xinetd: xinetd shutdown succeeded
Sep 24 17:50:09 oddball crond: crond shutdown succeeded
Sep 24 17:50:09 oddball ntpd[1142]: ntpd exiting on signal 15
Sep 24 17:50:09 oddball ntpd: ntpd shutdown succeeded
Sep 24 17:50:09 oddball dd: 1+0 records in
Sep 24 17:50:09 oddball dd: 1+0 records out
Sep 24 17:50:09 oddball random: Saving random seed:  succeeded
Sep 24 17:50:09 oddball rpc.statd[729]: Caught signal 15, un-registering and exiting.
Sep 24 17:50:09 oddball nfslock: rpc.statd shutdown succeeded
Sep 24 17:50:10 oddball vpnd: Stopping vpnd: 
Sep 24 17:50:10 oddball vpnd:  failed
Sep 24 17:50:10 oddball vpnd: ^[[60G
Sep 24 17:50:10 oddball vpnd: 
Sep 24 17:50:10 oddball vpnd: Failed to find PID of running vpnd process!
Sep 24 17:50:10 oddball rc: Stopping vpnd:  failed
Sep 24 17:50:10 oddball portmap: portmap shutdown succeeded
Sep 24 17:50:10 oddball kernel: Kernel logging (proc) stopped.
Sep 24 17:50:10 oddball kernel: Kernel log daemon terminating.
Sep 24 17:50:10 oddball gdm(pam_unix)[1160]: session closed for user bill
Sep 24 17:50:10 oddball gnome-name-server[1604]: input condition is: 0x11, exiting
Sep 24 17:50:11 oddball syslog: klogd shutdown succeeded
Sep 24 17:50:11 oddball exiting on signal 15
Sep 24 17:56:21 oddball syslogd 1.4.1: restart.
Sep 24 17:56:21 oddball syslog: syslogd startup succeeded
Sep 24 17:56:21 oddball syslog: klogd startup succeeded
Sep 24 17:56:21 oddball kernel: klogd 1.4.1, log source = /proc/kmsg started.
Sep 24 17:56:21 oddball kernel: Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep 24 17:56:21 oddball kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 24 17:56:21 oddball kernel: PIIX4: IDE controller at PCI slot 00:07.1
Sep 24 17:56:21 oddball kernel: PIIX4: chipset revision 1
Sep 24 17:56:21 oddball kernel: PIIX4: not 100%% native mode: will probe irqs later
Sep 24 17:56:21 oddball kernel:     ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:pio
Sep 24 17:56:21 oddball kernel:     ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:DMA, hdd:pio
Sep 24 17:56:21 oddball kernel: hda: Maxtor 90845D4, ATA DISK drive
Sep 24 17:56:21 oddball kernel: blk: queue c038f8fc, I/O limit 4095Mb (mask 0xffffffff)
Sep 24 17:56:21 oddball kernel: Sleeping function called from illegal context at slab.c:1378
Sep 24 17:56:21 oddball kernel: c409fec4 c0112a86 c02a29a0 c02a4842 00000562 c40fc0c0 c012c9a5 c02a4842 
Sep 24 17:56:21 oddball kernel:        00000562 ffffffff 00000000 00000fff c038f8ec c4042380 c01f3600 04000000 
Sep 24 17:56:21 oddball portmap: portmap startup succeeded
Sep 24 17:56:21 oddball kernel:        c038f850 c010a6cf 00000018 000001d0 c4042380 c038f840 0000000e 00000008 
Sep 24 17:56:21 oddball kernel: Call Trace: [<c0112a86>] [<c012c9a5>] [<c01f3600>] [<c010a6cf>] [<c01ecdad>] 
Sep 24 17:56:22 oddball kernel:    [<c01f3600>] [<c01ed20c>] [<c01eca8d>] [<c01fd35b>] [<c0105093>] [<c0105060>] 
Sep 24 17:56:22 oddball kernel:    [<c0107055>] 
Sep 24 17:56:22 oddball vpnd: Starting vpnd: 
Sep 24 17:56:22 oddball kernel: blk: queue c038f8fc, I/O limit 4095Mb (mask 0xffffffff)
Sep 24 17:56:22 oddball vpnd: ls: 
Sep 24 17:56:22 oddball vpnd:  succeeded
Sep 24 17:56:22 oddball kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 24 17:56:22 oddball vpnd: /etc/vpnd/oddball*.conf: No such file or directory
Sep 24 17:56:22 oddball kernel: hdc: NEC CD-ROM DRIVE:28C, ATAPI CD/DVD-ROM drive
Sep 24 17:56:22 oddball vpnd: 
Sep 24 17:56:22 oddball kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 24 17:56:22 oddball rc: Starting vpnd:  succeeded
Sep 24 17:56:22 oddball kernel: hda: host protected area => 1
Sep 24 17:56:22 oddball kernel: hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63, UDMA(33)
Sep 24 17:56:22 oddball kernel:  hda: hda1 hda2 hda3 hda4 < hda5 >
Sep 24 17:56:22 oddball kernel: hdc: ATAPI 32X CD-ROM drive, 128kB Cache, UDMA(33)
Sep 24 17:56:22 oddball nfslock: rpc.statd startup succeeded
Sep 24 17:56:22 oddball rpc.statd[727]: Version 0.3.3 Starting
Sep 24 17:56:22 oddball kernel: Uniform CD-ROM driver Revision: 3.12
Sep 24 17:56:22 oddball kernel: mice: PS/2 mouse device common for all mice
Sep 24 17:56:22 oddball kernel: input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
Sep 24 17:56:22 oddball keytable: Loading keymap:  succeeded
Sep 24 17:56:22 oddball kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 24 17:56:22 oddball keytable: Loading system font:  succeeded
Sep 24 17:56:22 oddball kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep 24 17:56:22 oddball kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 24 17:56:22 oddball kernel: Advanced Linux Sound Architecture Driver Version 0.9.0rc2 (Wed Jun 19 08:56:25 2002 UTC).
Sep 24 17:56:22 oddball kernel: request_module[snd-card-0]: not ready
Sep 24 17:56:22 oddball random: Initializing random number generator:  succeeded
Sep 24 17:56:22 oddball kernel: request_module[snd-card-1]: not ready
Sep 24 17:56:22 oddball kernel: request_module[snd-card-2]: not ready
Sep 24 17:56:22 oddball kernel: request_module[snd-card-3]: not ready
Sep 24 17:56:22 oddball kernel: request_module[snd-card-4]: not ready
Sep 24 17:56:23 oddball kernel: request_module[snd-card-5]: not ready
Sep 24 17:56:23 oddball netfs: Mounting other filesystems:  succeeded
Sep 24 17:56:23 oddball kernel: request_module[snd-card-6]: not ready
Sep 24 17:56:18 oddball sysctl: kernel.core_uses_pid = 1 
Sep 24 17:56:23 oddball kernel: request_module[snd-card-7]: not ready
Sep 24 17:56:18 oddball network: Setting network parameters:  succeeded 
Sep 24 17:56:23 oddball kernel: ALSA device list:
Sep 24 17:56:18 oddball network: Bringing up loopback interface:  succeeded 
Sep 24 17:56:23 oddball kernel:   No soundcards found.
Sep 24 17:56:23 oddball autofs: automount startup succeeded
Sep 24 17:56:24 oddball kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep 24 17:56:24 oddball kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Sep 24 17:56:24 oddball kernel: IP: routing cache hash table of 512 buckets, 4Kbytes
Sep 24 17:56:24 oddball sshd: Starting sshd:
Sep 24 17:56:24 oddball kernel: TCP: Hash tables configured (established 8192 bind 8192)
Sep 24 17:56:24 oddball kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Sep 24 17:56:24 oddball kernel: kjournald starting.  Commit interval 5 seconds
Sep 24 17:56:24 oddball kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 24 17:56:24 oddball kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep 24 17:56:24 oddball kernel: Freeing unused kernel memory: 280k freed
Sep 24 17:56:24 oddball kernel: Adding 200804k swap on /dev/hda2.  Priority:-1 extents:1
Sep 24 17:56:24 oddball kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
Sep 24 17:56:24 oddball kernel: kjournald starting.  Commit interval 5 seconds
Sep 24 17:56:24 oddball sshd:  succeeded
Sep 24 17:56:24 oddball kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Sep 24 17:56:24 oddball sshd: 
Sep 24 17:56:24 oddball kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 24 17:56:24 oddball kernel: kjournald starting.  Commit interval 5 seconds
Sep 24 17:56:24 oddball rc: Starting sshd:  succeeded
Sep 24 17:56:24 oddball kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
Sep 24 17:56:24 oddball kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 24 17:56:25 oddball kernel: hdc: DMA disabled
Sep 24 17:56:25 oddball kernel: Sleeping function called from illegal context at slab.c:1378
Sep 24 17:56:25 oddball kernel: c5295e14 c0112a86 c02a29a0 c02a4842 00000562 c40fc0c0 c012c9a5 c02a4842 
Sep 24 17:56:25 oddball kernel:        00000562 c41d2160 c41d2000 c0249425 000006c0 c41d2160 c01e4810 04000000 
Sep 24 17:56:25 oddball kernel:        c41d2000 c010a6cf 00000018 000001d0 c41d2160 c41d2290 00000000 c41d2000 
Sep 24 17:56:25 oddball kernel: Call Trace: [<c0112a86>] [<c012c9a5>] [<c0249425>] [<c01e4810>] [<c010a6cf>] 
Sep 24 17:56:25 oddball kernel:    [<c01e39cc>] [<c01e4810>] [<c024c6cf>] [<c024da5f>] [<c027d8d8>] [<c027fe07>] 
Sep 24 17:56:25 oddball kernel:    [<c024665a>] [<c0148727>] [<c0108d2f>] 
Sep 24 17:56:25 oddball kernel: e100: eth0 NIC Link is Up 10 Mbps Half duplex
Sep 24 17:56:25 oddball xinetd[909]: Server internal is not executable [line=14]
Sep 24 17:56:25 oddball xinetd[909]: Error parsing attribute server - DISABLING SERVICE [line=14]
Sep 24 17:56:25 oddball xinetd[909]: Server internal is not executable [line=14]
Sep 24 17:56:25 oddball xinetd[909]: Error parsing attribute server - DISABLING SERVICE [line=14]
Sep 24 17:56:25 oddball xinetd[909]: id not unique: ntalk [line=14]
Sep 24 17:56:26 oddball xinetd[909]: xinetd Version 2002.03.28 started with libwrap options compiled in.
Sep 24 17:56:26 oddball xinetd[909]: Started working: 1 available service
Sep 24 17:56:28 oddball xinetd: xinetd startup succeeded
Sep 24 17:56:31 oddball sendmail: sendmail startup succeeded
Sep 24 17:56:31 oddball touchpad: 
Sep 24 17:56:31 oddball touchpad: Turning off Touch-Pad 'tapping' 
Sep 24 17:56:31 oddball touchpad: fatal: 
Sep 24 17:56:31 oddball touchpad: 
Sep 24 17:56:31 oddball touchpad: No Synaptics or ALPS touchpad device found
Sep 24 17:56:31 oddball touchpad: 
Sep 24 17:56:31 oddball last message repeated 2 times
Sep 24 17:56:31 oddball touchpad: ========================================================================
Sep 24 17:56:31 oddball touchpad: =                                                                      =
Sep 24 17:56:31 oddball touchpad: =                tpconfig   version: 3.1.3                             =
Sep 24 17:56:31 oddball touchpad: =                                                                      =
Sep 24 17:56:31 oddball touchpad: = Synaptics Touchpad and ALPS GlidePad/Stickpointer configuration tool =
Sep 24 17:56:31 oddball touchpad: =                                                                      =
Sep 24 17:56:31 oddball touchpad: = Copyright (C) 1997 C. Scott Ananian<cananian@alumni.princeton.edu>   =
Sep 24 17:56:31 oddball touchpad: = Copyright (C) 1998-2001 Bruce Kall <kall@compass.com>                =
Sep 24 17:56:31 oddball touchpad: = Last Modified (Version 3.1.3) by Bruce Kall, 2/22/2002              =
Sep 24 17:56:31 oddball touchpad: =                                                                      =
Sep 24 17:56:31 oddball touchpad: = tpconfig comes with ABSOLUTELY NO WARRANTY.  This is free software,  =
Sep 24 17:56:31 oddball touchpad: = and you are welcome to redistribute it under the terms of the GPL.   =
Sep 24 17:56:31 oddball touchpad: =                                                                      =
Sep 24 17:56:31 oddball touchpad: ========================================================================
Sep 24 17:56:31 oddball touchpad: 
Sep 24 17:56:31 oddball rc: Starting touchpad:  succeeded
Sep 24 17:56:31 oddball gpm: gpm startup succeeded
Sep 24 17:56:31 oddball wwwoffled: Starting wwwoffled: 
Sep 24 17:56:31 oddball wwwoffled: Starting wwwoffled:  succeeded
Sep 24 17:56:31 oddball wwwoffled: ^[[60G
Sep 24 17:56:31 oddball wwwoffled: 
Sep 24 17:56:31 oddball rc: Starting wwwoffled:  succeeded
Sep 24 17:56:32 oddball crond: crond startup succeeded
Sep 24 17:56:33 oddball xfs: listening on port 7100 
Sep 24 17:56:33 oddball xfs: xfs startup succeeded
Sep 24 17:56:33 oddball anacron: anacron startup succeeded
Sep 24 17:56:34 oddball atd: atd startup succeeded
Sep 24 17:56:34 oddball xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/cyrillic (unreadable) 
Sep 24 17:56:34 oddball xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/CID (unreadable) 
Sep 24 17:56:34 oddball xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/local (unreadable) 
Sep 24 17:56:34 oddball xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/latin2/Type1 (unreadable) 
Sep 24 17:56:34 oddball linuxconf-setup: Linuxconf final setup
Sep 24 17:56:34 oddball linuxconf-setup:   Setting firewalling
Sep 24 17:56:34 oddball linuxconf-setup:   Checking kernel configuration
Sep 24 17:56:34 oddball rc: Starting linuxconf-setup:  succeeded
Sep 24 17:56:35 oddball ntpd[1140]: ntpd 4.1.1@1.786 Mon Apr  8 06:30:52 EDT 2002 (1)
Sep 24 17:56:35 oddball ntpd: ntpd startup succeeded
Sep 24 17:56:35 oddball ntpd[1140]: precision = 11 usec
Sep 24 17:56:35 oddball ntpd[1140]: kernel time discipline status 0040
Sep 24 17:56:35 oddball ntpd[1140]: frequency initialized -18.936 from /etc/ntp/drift
Sep 24 17:56:36 oddball modprobe: modprobe: Can't locate module char-major-10-134
Sep 24 17:56:36 oddball kernel: Sleeping function called from illegal context at slab.c:1378
Sep 24 17:56:36 oddball kernel: c3d83f5c c0112a86 c02a29a0 c02a4842 00000562 c40fc300 c012c9a5 c02a4842 
Sep 24 17:56:36 oddball kernel:        00000562 c012745e c4aeb4a0 c3d9cd40 c3d9ce00 00000000 00000400 00000001 
Sep 24 17:56:36 oddball kernel:        c1137b80 c010cd93 00000080 000001d0 00000000 c3d82000 08080410 00000018 
Sep 24 17:56:36 oddball kernel: Call Trace: [<c0112a86>] [<c012c9a5>] [<c012745e>] [<c010cd93>] [<c0108d2f>] 
Sep 24 17:56:51 oddball login(pam_unix)[1144]: session opened for user root by LOGIN(uid=0)
Sep 24 17:56:51 oddball  -- root[1144]: ROOT LOGIN ON tty1
Sep 24 17:57:14 oddball kernel: SCSI subsystem driver Revision: 1.00
Sep 24 17:57:14 oddball kernel: kmem_cache_destroy: Can't free all objects c41a0360
Sep 24 17:57:14 oddball kernel: kmem_cache_destroy: Can't free all objects c41a03c0
Sep 24 17:57:14 oddball kernel: kmem_cache_destroy: Can't free all objects c41a0420
Sep 24 17:57:14 oddball kernel: kmem_cache_destroy: Can't free all objects c41a0480
Sep 24 17:57:14 oddball kernel: kmem_cache_destroy: Can't free all objects c41a04e0
Sep 24 17:57:57 oddball kernel: SCSI subsystem driver Revision: 1.00
Sep 24 17:57:57 oddball kernel: kmem_cache_create: duplicate cache sgpool-8
Sep 24 17:57:57 oddball kernel: kernel BUG at slab.c:861!
Sep 24 17:57:57 oddball kernel: invalid operand: 0000
Sep 24 17:57:57 oddball kernel: CPU:    0
Sep 24 17:57:57 oddball kernel: EIP:    0060:[<c012c34a>]    Not tainted
Sep 24 17:57:57 oddball kernel: EFLAGS: 00010202
Sep 24 17:57:57 oddball kernel: eax: c02a3fa0   ebx: c41a0540   ecx: c036c23c   edx: c6847bb7
Sep 24 17:57:57 oddball kernel: esi: c6847bc0   edi: c6847bc0   ebp: c41a03b8   esp: c28b3edc
Sep 24 17:57:57 oddball kernel: ds: 0068   es: 0068   ss: 0068
Sep 24 17:57:57 oddball kernel: Process modprobe (pid: 1218, threadinfo=c28b2000 task=c44f9840)
Sep 24 17:57:57 oddball kernel: Stack: c28b3ee4 c0000000 00000060 00000000 00000004 00000000 080b9930 c683a4a1 
Sep 24 17:57:57 oddball kernel:        c6847bb7 00000080 00000020 00002000 00000000 00000000 ffffffff 00000c68 
Sep 24 17:57:57 oddball kernel:        c6838000 00000000 c6838000 00000000 c0115d15 00000000 c28cf000 000129e0 
Sep 24 17:57:57 oddball kernel: Call Trace: [<c683a4a1>] [<c6847bb7>] [<c0115d15>] [<c6838060>] [<c0108d2f>] 
Sep 24 17:57:57 oddball kernel: 
Sep 24 17:57:57 oddball kernel: Code: 0f 0b 5d 03 42 48 2a c0 8b 6d 00 81 fd 58 ad 2e c0 75 93 8b 
Sep 24 17:57:57 oddball kernel:  <6>note: modprobe[1218] exited with preempt_count 1


Disabling netfilter gives a build which boots and oopses, is hung to the 
reset button stage, and which writes nothing anywhere.

I have all the netfilter options on, and it wouldn't build as a module 
with 2.5.44-mm2. With netfilter off 2.5.44-mm2 runs fine.

	-bill

