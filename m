Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbRLIEYZ>; Sat, 8 Dec 2001 23:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282968AbRLIEYJ>; Sat, 8 Dec 2001 23:24:09 -0500
Received: from DIRTY-BASTARD.MIT.EDU ([18.241.0.136]:2052 "EHLO
	dirty-bastard.pthbb.org") by vger.kernel.org with ESMTP
	id <S282967AbRLIEXz>; Sat, 8 Dec 2001 23:23:55 -0500
Message-Id: <200112090419.fB94Jtc00580@dirty-bastard.pthbb.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14/16 load reboots 
In-Reply-To: Your message of "Sat, 08 Dec 2001 20:47:30 GMT."
             <E16CoNe-0002bu-00@the-village.bc.nu> 
Date: Sat, 08 Dec 2001 23:19:55 -0500
From: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> CONFIG_PCI_BIOS=y
> CONFIG_PM=y
> CONFIG_PNP=y
> CONFIG_ISAPNP=y
>Let me know if that helps at all.
I already had it built with these enabled and thought I'd try it
before rebuilding (since that is slow on a P120). And it booted fine.
however neither my 3C509 nor NetGear cards would work. I rebuilt with
these settings and the same thing occured.

>Whats the last kernel that did work on it?
2.2.5-15 stably. I tried 2.2.20 (after these problems with 2.4.x)
but it seemed to slow down markedly after a week of uptime.

Enc. boot.log
Enc.     .config

--begin boot.log
Dec  8 22:03:21 dirty-bastard sshd: sshd shutdown succeeded
Dec  8 22:03:23 dirty-bastard sendmail: sendmail shutdown succeeded
Dec  8 22:03:24 dirty-bastard crond: crond shutdown succeeded
Dec  8 22:03:24 dirty-bastard dd: 1+0 records in
Dec  8 22:03:24 dirty-bastard dd: 1+0 records out
Dec  8 22:03:24 dirty-bastard random: Saving random seed succeeded
Dec  8 22:03:25 dirty-bastard network: Shutting down interface eth0 succeeded
Dec  8 22:03:26 dirty-bastard network: Disabling IPv4 packet forwarding succeeded
Dec  8 22:03:28 dirty-bastard syslog: klogd shutdown succeeded
Dec  8 22:03:53 dirty-bastard syslog: syslogd startup succeeded
Dec  8 22:03:53 dirty-bastard syslog: klogd startup succeeded
Dec  8 22:04:30 dirty-bastard rc.sysinit: Loading default keymap succeeded 
Dec  8 22:04:31 dirty-bastard rc.sysinit: Setting default font succeeded 
Dec  8 22:04:31 dirty-bastard rc.sysinit: Activating swap partitions succeeded 
Dec  8 22:04:31 dirty-bastard rc.sysinit: Setting hostname dirty-bastard.pthbb.org succeeded 
Dec  8 22:04:31 dirty-bastard fsck: /dev/hda1: clean, 35742/196608 files, 623146/786208 blocks 
Dec  8 22:04:31 dirty-bastard rc.sysinit: Checking root filesystem succeeded 
Dec  8 22:04:31 dirty-bastard isapnp: Board 1 has Identity 43 10 00 59 bd 28 00 8c 0e:  CTL0028 Serial No 268458429 [checksum 43] 
Dec  8 22:04:31 dirty-bastard isapnp: CTL0028/268458429[0]{Audio               }: Ports 0x220 0x330 0x388; IRQ5 DMA1 DMA5 --- Enabled OK 
Dec  8 22:04:31 dirty-bastard isapnp: CTL0028/268458429[2]{Reserved            }: Port 0x110; --- Enabled OK 
Dec  8 22:04:31 dirty-bastard isapnp: CTL0028/268458429[3]{Game                }: Port 0x200; --- Enabled OK 
Dec  8 22:04:31 dirty-bastard rc.sysinit: Setting up ISA PNP devices succeeded 
Dec  8 22:04:31 dirty-bastard rc.sysinit: Remounting root filesystem in read-write mode succeeded 
Dec  8 22:04:33 dirty-bastard rc.sysinit: Finding module dependencies succeeded 
Dec  8 22:04:33 dirty-bastard fsck: /dev/hda2: clean, 38350/200704 files, 724899/800352 blocks 
Dec  8 22:04:33 dirty-bastard rc.sysinit: Checking filesystems succeeded 
Dec  8 22:04:33 dirty-bastard rc.sysinit: Mounting local filesystems succeeded 
Dec  8 22:04:33 dirty-bastard rc.sysinit: Turning on user and group quotas for local filesystems succeeded 
Dec  8 22:03:45 dirty-bastard date: Sat Dec  8 22:03:45 GMT 2001 
Dec  8 22:03:45 dirty-bastard rc.sysinit: Setting clock  (utc): Sat Dec  8 22:03:45 GMT 2001 succeeded 
Dec  8 22:03:45 dirty-bastard rc.sysinit: Enabling swap space succeeded 
Dec  8 22:03:46 dirty-bastard network: Enabling IPv4 packet forwarding succeeded 
Dec  8 22:03:47 dirty-bastard ifup: SIOCADDRT: Network is unreachable 
Dec  8 22:03:50 dirty-bastard network: Bringing up interface lo succeeded 
Dec  8 22:03:51 dirty-bastard network: Bringing up interface eth0 succeeded 
Dec  8 22:03:52 dirty-bastard random: Initializing random number generator succeeded 
Dec  8 22:03:54 dirty-bastard crond: crond startup succeeded
Dec  8 22:03:59 dirty-bastard sshd: sshd startup succeeded
Dec  8 22:04:00 dirty-bastard keytable: Loading keymap: 
Dec  8 22:04:01 dirty-bastard keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Dec  8 22:04:02 dirty-bastard keytable: Loading system font: 
Dec  8 22:04:02 dirty-bastard rc: Starting keytable succeeded
Dec  8 22:04:06 dirty-bastard sendmail: sendmail startup succeeded
Dec  8 22:04:07 dirty-bastard ftpd: proftpd startup succeeded
Dec  8 22:04:10 dirty-bastard httpd: httpd startup succeeded
Dec  8 22:04:25 dirty-bastard httpsd: httpsd startup succeeded
Dec  8 22:04:26 dirty-bastard linuxconf: Linuxconf final setup
Dec  8 22:04:27 dirty-bastard rc: Starting linuxconf succeeded
Dec  8 22:04:28 dirty-bastard local: 
Dec  8 22:04:28 dirty-bastard local: /dev/hda:
Dec  8 22:04:28 dirty-bastard local:  setting 32-bit I/O support flag to 3
Dec  8 22:04:28 dirty-bastard local:  setting multcount to 16
Dec  8 22:04:28 dirty-bastard local:  setting keep_settings to 1 (on)
Dec  8 22:04:28 dirty-bastard local:  setting xfermode to 34 (multiword DMA mode2)
Dec  8 22:04:28 dirty-bastard local:  multcount    = 16 (on)
Dec  8 22:04:28 dirty-bastard local:  I/O support  =  3 (32-bit w/sync)
Dec  8 22:04:28 dirty-bastard local:  keepsettings =  1 (on)
Dec  8 22:04:28 dirty-bastard local: 
Dec  8 22:04:28 dirty-bastard local: /dev/hdc:
Dec  8 22:04:28 dirty-bastard local:  setting 32-bit I/O support flag to 1
Dec  8 22:04:28 dirty-bastard local:  setting multcount to 16
Dec  8 22:04:28 dirty-bastard local:  setting keep_settings to 1 (on)
Dec  8 22:04:28 dirty-bastard local:  setting xfermode to 0 (default PIO mode)
Dec  8 22:04:28 dirty-bastard local:  multcount    = 16 (on)
Dec  8 22:04:28 dirty-bastard local:  I/O support  =  1 (32-bit)
Dec  8 22:04:29 dirty-bastard local:  keepsettings =  1 (on)
Dec  8 22:04:29 dirty-bastard local:  HDIO_DRIVE_CMD failed: Input/output error
Dec  8 22:04:29 dirty-bastard rc: Starting local succeeded
Dec  8 22:04:30 dirty-bastard webmin: Starting Webmin server in /home/net/admin
Dec  8 22:04:31 dirty-bastard rc: Starting webmin succeeded
Dec  8 17:21:29 dirty-bastard network: Shutting down interface eth0 succeeded
Dec  8 17:21:29 dirty-bastard ifdown: eth1: unknown interface: No such device
Dec  8 17:21:29 dirty-bastard network: Shutting down interface eth1 succeeded
Dec  8 17:21:30 dirty-bastard network: Disabling IPv4 packet forwarding succeeded
Dec  8 17:21:30 dirty-bastard network: Enabling IPv4 packet forwarding succeeded
Dec  8 17:21:31 dirty-bastard ifup: SIOCADDRT: Network is unreachable
Dec  8 17:21:32 dirty-bastard network: Bringing up interface lo succeeded
Dec  8 17:21:33 dirty-bastard network: Bringing up interface eth0 succeeded
Dec  8 17:21:34 dirty-bastard ifup: Delaying eth1 initialization.
Dec  8 17:21:34 dirty-bastard network: Bringing up interface eth1 failed
Dec  8 17:22:07 dirty-bastard network: Shutting down interface eth0 succeeded
Dec  8 17:22:08 dirty-bastard network: Disabling IPv4 packet forwarding succeeded
Dec  8 17:22:09 dirty-bastard network: Enabling IPv4 packet forwarding succeeded
Dec  8 17:22:09 dirty-bastard ifup: SIOCADDRT: Network is unreachable
Dec  8 17:22:10 dirty-bastard network: Bringing up interface lo succeeded
Dec  8 17:22:11 dirty-bastard network: Bringing up interface eth0 succeeded
Dec  8 22:22:59 dirty-bastard sshd: sshd shutdown succeeded
Dec  8 22:23:00 dirty-bastard sendmail: sendmail shutdown succeeded
Dec  8 22:23:01 dirty-bastard crond: crond shutdown succeeded
Dec  8 22:23:02 dirty-bastard network: Shutting down interface eth0 succeeded
Dec  8 22:23:03 dirty-bastard network: Disabling IPv4 packet forwarding succeeded
Dec  8 22:23:05 dirty-bastard syslog: klogd shutdown succeeded
Dec  8 22:23:30 dirty-bastard syslog: syslogd startup succeeded
Dec  8 22:23:30 dirty-bastard syslog: klogd startup succeeded
Dec  8 22:23:12 dirty-bastard random: Initializing random number generator succeeded 
Dec  8 22:23:26 dirty-bastard network: Enabling IPv4 packet forwarding succeeded 
Dec  8 22:23:27 dirty-bastard ifup: SIOCADDRT: Network is unreachable 
Dec  8 22:23:28 dirty-bastard network: Bringing up interface lo succeeded 
Dec  8 22:23:29 dirty-bastard network: Bringing up interface eth0 succeeded 
Dec  8 22:23:31 dirty-bastard crond: crond startup succeeded
Dec  8 22:23:32 dirty-bastard sshd: sshd startup succeeded
Dec  8 22:23:32 dirty-bastard keytable: Loading keymap: 
Dec  8 22:23:33 dirty-bastard keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Dec  8 22:23:33 dirty-bastard keytable: Loading system font: 
Dec  8 22:23:33 dirty-bastard rc: Starting keytable succeeded
Dec  8 22:23:36 dirty-bastard sendmail: sendmail startup succeeded
Dec  8 22:23:37 dirty-bastard ftpd: proftpd startup succeeded
Dec  8 22:23:40 dirty-bastard httpd: httpd startup succeeded
Dec  8 22:23:53 dirty-bastard httpsd: httpsd startup succeeded
Dec  8 22:23:53 dirty-bastard linuxconf: Linuxconf final setup
Dec  8 22:23:55 dirty-bastard rc: Starting linuxconf succeeded
Dec  8 22:23:55 dirty-bastard local: 
Dec  8 22:23:55 dirty-bastard local: /dev/hda:
Dec  8 22:23:55 dirty-bastard local:  setting 32-bit I/O support flag to 3
Dec  8 22:23:55 dirty-bastard local:  setting multcount to 16
Dec  8 22:23:55 dirty-bastard local:  setting keep_settings to 1 (on)
Dec  8 22:23:55 dirty-bastard local:  setting xfermode to 34 (multiword DMA mode2)
Dec  8 22:23:55 dirty-bastard local:  multcount    = 16 (on)
Dec  8 22:23:55 dirty-bastard local:  I/O support  =  3 (32-bit w/sync)
Dec  8 22:23:56 dirty-bastard local:  keepsettings =  1 (on)
Dec  8 22:23:56 dirty-bastard local: 
Dec  8 22:23:56 dirty-bastard local: /dev/hdc:
Dec  8 22:23:56 dirty-bastard local:  setting 32-bit I/O support flag to 1
Dec  8 22:23:56 dirty-bastard local:  setting multcount to 16
Dec  8 22:23:56 dirty-bastard local:  setting keep_settings to 1 (on)
Dec  8 22:23:56 dirty-bastard local:  setting xfermode to 0 (default PIO mode)
Dec  8 22:23:56 dirty-bastard local:  multcount    = 16 (on)
Dec  8 22:23:56 dirty-bastard local:  I/O support  =  1 (32-bit)
Dec  8 22:23:56 dirty-bastard local:  keepsettings =  1 (on)
Dec  8 22:23:56 dirty-bastard local:  HDIO_DRIVE_CMD failed: Input/output error
Dec  8 22:23:56 dirty-bastard rc: Starting local succeeded
Dec  8 22:23:56 dirty-bastard webmin: Starting Webmin server in /home/net/admin
Dec  8 22:23:57 dirty-bastard rc: Starting webmin succeeded
Dec  8 22:25:08 dirty-bastard sshd: sshd shutdown succeeded
Dec  8 22:25:09 dirty-bastard sendmail: sendmail shutdown succeeded
Dec  8 22:25:10 dirty-bastard crond: crond shutdown succeeded
Dec  8 22:25:10 dirty-bastard dd: 1+0 records in
Dec  8 22:25:10 dirty-bastard dd: 1+0 records out
Dec  8 22:25:10 dirty-bastard random: Saving random seed succeeded
Dec  8 22:25:11 dirty-bastard network: Shutting down interface eth0 succeeded
Dec  8 22:25:12 dirty-bastard network: Disabling IPv4 packet forwarding succeeded
Dec  8 22:25:14 dirty-bastard syslog: klogd shutdown succeeded
Dec  8 22:26:22 dirty-bastard syslog: syslogd startup succeeded
Dec  8 22:26:22 dirty-bastard syslog: klogd startup succeeded
Dec  8 22:25:55 dirty-bastard rc.sysinit: Loading default keymap succeeded 
Dec  8 22:25:56 dirty-bastard rc.sysinit: Setting default font succeeded 
Dec  8 22:25:56 dirty-bastard rc.sysinit: Activating swap partitions succeeded 
Dec  8 22:25:56 dirty-bastard rc.sysinit: Setting hostname dirty-bastard.pthbb.org succeeded 
Dec  8 22:25:56 dirty-bastard fsck: /dev/hda1: clean, 35743/196608 files, 623208/786208 blocks 
Dec  8 22:25:56 dirty-bastard rc.sysinit: Checking root filesystem succeeded 
Dec  8 22:25:56 dirty-bastard isapnp: Board 1 has Identity 43 10 00 59 bd 28 00 8c 0e:  CTL0028 Serial No 268458429 [checksum 43] 
Dec  8 22:25:56 dirty-bastard isapnp: CTL0028/268458429[0]{Audio               }: Ports 0x220 0x330 0x388; IRQ5 DMA1 DMA5 --- Enabled OK 
Dec  8 22:25:56 dirty-bastard isapnp: CTL0028/268458429[2]{Reserved            }: Port 0x110; --- Enabled OK 
Dec  8 22:25:56 dirty-bastard isapnp: CTL0028/268458429[3]{Game                }: Port 0x200; --- Enabled OK 
Dec  8 22:25:56 dirty-bastard rc.sysinit: Setting up ISA PNP devices succeeded 
Dec  8 22:25:56 dirty-bastard rc.sysinit: Remounting root filesystem in read-write mode succeeded 
Dec  8 22:26:08 dirty-bastard depmod: depmod:  
Dec  8 22:26:08 dirty-bastard depmod: *** Unresolved symbols in /lib/modules/2.2.5-15/misc/maui.o 
Dec  8 22:26:08 dirty-bastard rc.sysinit: Finding module dependencies succeeded 
Dec  8 22:26:09 dirty-bastard fsck: /dev/hda2: clean, 38352/200704 files, 724908/800352 blocks 
Dec  8 22:26:09 dirty-bastard rc.sysinit: Checking filesystems succeeded 
Dec  8 22:26:11 dirty-bastard rc.sysinit: Mounting local filesystems succeeded 
Dec  8 22:26:11 dirty-bastard rc.sysinit: Turning on user and group quotas for local filesystems succeeded 
Dec  8 22:26:14 dirty-bastard date: Sat Dec  8 22:26:14 GMT 2001 
Dec  8 22:26:14 dirty-bastard rc.sysinit: Setting clock  (utc): Sat Dec  8 22:26:14 GMT 2001 succeeded 
Dec  8 22:26:14 dirty-bastard rc.sysinit: Enabling swap space succeeded 
Dec  8 22:26:15 dirty-bastard network: Enabling IPv4 packet forwarding succeeded 
Dec  8 22:26:16 dirty-bastard ifup: SIOCADDRT: Network is unreachable 
Dec  8 22:26:19 dirty-bastard network: Bringing up interface lo succeeded 
Dec  8 22:26:20 dirty-bastard network: Bringing up interface eth0 succeeded 
Dec  8 22:26:21 dirty-bastard random: Initializing random number generator succeeded 
Dec  8 22:26:25 dirty-bastard crond: crond startup succeeded
Dec  8 22:26:29 dirty-bastard sshd: sshd startup succeeded
Dec  8 22:26:29 dirty-bastard keytable: Loading keymap: 
Dec  8 22:26:30 dirty-bastard keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Dec  8 22:26:30 dirty-bastard keytable: Loading system font: 
Dec  8 22:26:30 dirty-bastard rc: Starting keytable succeeded
Dec  8 22:26:34 dirty-bastard sendmail: sendmail startup succeeded
Dec  8 22:26:35 dirty-bastard ftpd: proftpd startup succeeded
Dec  8 22:26:38 dirty-bastard httpd: httpd startup succeeded
Dec  8 22:26:53 dirty-bastard httpsd: httpsd startup succeeded
Dec  8 22:26:54 dirty-bastard linuxconf: Linuxconf final setup
Dec  8 22:26:55 dirty-bastard rc: Starting linuxconf succeeded
Dec  8 22:26:56 dirty-bastard local: 
Dec  8 22:26:56 dirty-bastard local: /dev/hda:
Dec  8 22:26:56 dirty-bastard local:  setting 32-bit I/O support flag to 3
Dec  8 22:26:56 dirty-bastard local:  setting multcount to 16
Dec  8 22:26:56 dirty-bastard local:  setting keep_settings to 1 (on)
Dec  8 22:26:56 dirty-bastard local:  setting xfermode to 34 (multiword DMA mode2)
Dec  8 22:26:56 dirty-bastard local:  multcount    = 16 (on)
Dec  8 22:26:56 dirty-bastard local:  I/O support  =  3 (32-bit w/sync)
Dec  8 22:26:56 dirty-bastard local:  keepsettings =  1 (on)
Dec  8 22:26:56 dirty-bastard local:  HDIO_DRIVE_CMD failed: Input/output error
Dec  8 22:26:56 dirty-bastard local: 
Dec  8 22:26:56 dirty-bastard local: /dev/hdc:
Dec  8 22:26:57 dirty-bastard local:  setting 32-bit I/O support flag to 1
Dec  8 22:26:57 dirty-bastard local:  setting multcount to 16
Dec  8 22:26:57 dirty-bastard local:  setting keep_settings to 1 (on)
Dec  8 22:26:57 dirty-bastard local:  setting xfermode to 0 (default PIO mode)
Dec  8 22:26:57 dirty-bastard local:  multcount    = 16 (on)
Dec  8 22:26:57 dirty-bastard local:  I/O support  =  1 (32-bit)
Dec  8 22:26:57 dirty-bastard local:  keepsettings =  1 (on)
Dec  8 22:26:57 dirty-bastard rc: Starting local succeeded
Dec  8 22:26:58 dirty-bastard webmin: Starting Webmin server in /home/net/admin
Dec  8 22:26:59 dirty-bastard rc: Starting webmin succeeded
Dec  9 03:51:58 dirty-bastard sshd: sshd shutdown succeeded
Dec  9 03:51:59 dirty-bastard sendmail: sendmail shutdown succeeded
Dec  9 03:52:00 dirty-bastard crond: crond shutdown succeeded
Dec  9 03:52:00 dirty-bastard dd: 1+0 records in
Dec  9 03:52:00 dirty-bastard dd: 1+0 records out
Dec  9 03:52:00 dirty-bastard random: Saving random seed succeeded
Dec  9 03:52:02 dirty-bastard network: Shutting down interface eth0 succeeded
Dec  9 03:52:02 dirty-bastard network: Disabling IPv4 packet forwarding succeeded
Dec  9 03:52:05 dirty-bastard syslog: klogd shutdown succeeded
Dec  9 03:52:56 dirty-bastard syslog: syslogd startup succeeded
Dec  9 03:52:56 dirty-bastard syslog: klogd startup succeeded
Dec  9 03:52:43 dirty-bastard rc.sysinit: Loading default keymap succeeded 
Dec  9 03:52:44 dirty-bastard rc.sysinit: Setting default font succeeded 
Dec  9 03:52:44 dirty-bastard rc.sysinit: Activating swap partitions succeeded 
Dec  9 03:52:44 dirty-bastard rc.sysinit: Setting hostname dirty-bastard.pthbb.org succeeded 
Dec  9 03:52:44 dirty-bastard fsck: /dev/hda1: clean, 35744/196608 files, 605131/786208 blocks 
Dec  9 03:52:44 dirty-bastard rc.sysinit: Checking root filesystem succeeded 
Dec  9 03:52:44 dirty-bastard isapnp: Board 1 has Identity 43 10 00 59 bd 28 00 8c 0e:  CTL0028 Serial No 268458429 [checksum 43] 
Dec  9 03:52:44 dirty-bastard isapnp: CTL0028/268458429[0]{Audio               }: Ports 0x220 0x330 0x388; IRQ5 DMA1 DMA5 --- Enabled OK 
Dec  9 03:52:44 dirty-bastard isapnp: CTL0028/268458429[2]{Reserved            }: Port 0x110; --- Enabled OK 
Dec  9 03:52:44 dirty-bastard isapnp: CTL0028/268458429[3]{Game                }: Port 0x200; --- Enabled OK 
Dec  9 03:52:44 dirty-bastard rc.sysinit: Setting up ISA PNP devices succeeded 
Dec  9 03:52:44 dirty-bastard rc.sysinit: Remounting root filesystem in read-write mode succeeded 
Dec  9 03:52:46 dirty-bastard depmod: depmod:  
Dec  9 03:52:46 dirty-bastard depmod: *** Unresolved symbols in /lib/modules/2.4.16/kernel/drivers/sound/sb.o 
Dec  9 03:52:46 dirty-bastard rc.sysinit: Finding module dependencies succeeded 
Dec  9 03:52:46 dirty-bastard fsck: /dev/hda2: clean, 38356/200704 files, 724909/800352 blocks 
Dec  9 03:52:46 dirty-bastard rc.sysinit: Checking filesystems succeeded 
Dec  9 03:52:46 dirty-bastard rc.sysinit: Mounting local filesystems succeeded 
Dec  9 03:52:46 dirty-bastard rc.sysinit: Turning on user and group quotas for local filesystems succeeded 
Dec  9 03:52:48 dirty-bastard date: Sun Dec  9 03:52:48 GMT 2001 
Dec  9 03:52:48 dirty-bastard rc.sysinit: Setting clock  (utc): Sun Dec  9 03:52:48 GMT 2001 succeeded 
Dec  9 03:52:48 dirty-bastard rc.sysinit: Enabling swap space succeeded 
Dec  9 03:52:49 dirty-bastard network: Enabling IPv4 packet forwarding succeeded 
Dec  9 03:52:50 dirty-bastard ifup: SIOCADDRT: Network is unreachable 
Dec  9 03:52:53 dirty-bastard network: Bringing up interface lo succeeded 
Dec  9 03:52:54 dirty-bastard network: Bringing up interface eth0 succeeded 
Dec  9 03:52:55 dirty-bastard random: Initializing random number generator succeeded 
Dec  9 03:52:57 dirty-bastard crond: crond startup succeeded
Dec  9 03:53:02 dirty-bastard sshd: sshd startup succeeded
Dec  9 03:53:04 dirty-bastard keytable: Loading keymap: 
Dec  9 03:53:04 dirty-bastard keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Dec  9 03:53:05 dirty-bastard keytable: Loading system font: 
Dec  9 03:53:05 dirty-bastard rc: Starting keytable succeeded
Dec  9 03:53:09 dirty-bastard sendmail: sendmail startup succeeded
Dec  9 03:53:09 dirty-bastard ftpd: proftpd startup succeeded
Dec  9 03:53:13 dirty-bastard httpd: httpd startup succeeded
Dec  9 03:53:29 dirty-bastard httpsd: httpsd startup succeeded
Dec  9 03:53:29 dirty-bastard linuxconf: Linuxconf final setup
Dec  9 03:53:31 dirty-bastard rc: Starting linuxconf succeeded
Dec  9 03:53:32 dirty-bastard local: 
Dec  9 03:53:32 dirty-bastard local: /dev/hda:
Dec  9 03:53:32 dirty-bastard local:  setting 32-bit I/O support flag to 3
Dec  9 03:53:32 dirty-bastard local:  setting multcount to 16
Dec  9 03:53:32 dirty-bastard local:  setting keep_settings to 1 (on)
Dec  9 03:53:32 dirty-bastard local:  setting xfermode to 34 (multiword DMA mode2)
Dec  9 03:53:32 dirty-bastard local:  multcount    = 16 (on)
Dec  9 03:53:32 dirty-bastard local:  I/O support  =  3 (32-bit w/sync)
Dec  9 03:53:32 dirty-bastard local:  keepsettings =  1 (on)
Dec  9 03:53:32 dirty-bastard local: 
Dec  9 03:53:32 dirty-bastard local: /dev/hdc:
Dec  9 03:53:32 dirty-bastard local:  setting 32-bit I/O support flag to 1
Dec  9 03:53:32 dirty-bastard local:  setting multcount to 16
Dec  9 03:53:32 dirty-bastard local:  setting keep_settings to 1 (on)
Dec  9 03:53:32 dirty-bastard local:  setting xfermode to 0 (default PIO mode)
Dec  9 03:53:32 dirty-bastard local:  multcount    = 16 (on)
Dec  9 03:53:32 dirty-bastard local:  I/O support  =  1 (32-bit)
Dec  9 03:53:32 dirty-bastard local:  keepsettings =  1 (on)
Dec  9 03:53:32 dirty-bastard local:  HDIO_DRIVE_CMD failed: Input/output error
Dec  9 03:53:32 dirty-bastard rc: Starting local succeeded
Dec  9 03:53:34 dirty-bastard webmin: Starting Webmin server in /home/net/admin
Dec  9 03:53:34 dirty-bastard rc: Starting webmin succeeded
Dec  9 03:55:56 dirty-bastard sshd: sshd shutdown succeeded
Dec  9 03:55:57 dirty-bastard sendmail: sendmail shutdown succeeded
Dec  9 03:55:58 dirty-bastard crond: crond shutdown succeeded
Dec  9 03:55:58 dirty-bastard dd: 1+0 records in
Dec  9 03:55:58 dirty-bastard dd: 1+0 records out
Dec  9 03:55:58 dirty-bastard random: Saving random seed succeeded
Dec  9 03:55:59 dirty-bastard network: Shutting down interface eth0 succeeded
Dec  9 03:56:00 dirty-bastard network: Disabling IPv4 packet forwarding succeeded
Dec  9 03:56:02 dirty-bastard syslog: klogd shutdown succeeded
Dec  9 03:57:10 dirty-bastard syslog: syslogd startup succeeded
Dec  9 03:57:10 dirty-bastard syslog: klogd startup succeeded
Dec  9 03:56:44 dirty-bastard rc.sysinit: Loading default keymap succeeded 
Dec  9 03:56:44 dirty-bastard rc.sysinit: Setting default font succeeded 
Dec  9 03:56:44 dirty-bastard rc.sysinit: Activating swap partitions succeeded 
Dec  9 03:56:44 dirty-bastard rc.sysinit: Setting hostname dirty-bastard.pthbb.org succeeded 
Dec  9 03:56:44 dirty-bastard fsck: /dev/hda1: clean, 35744/196608 files, 605168/786208 blocks 
Dec  9 03:56:44 dirty-bastard rc.sysinit: Checking root filesystem succeeded 
Dec  9 03:56:44 dirty-bastard isapnp: Board 1 has Identity 43 10 00 59 bd 28 00 8c 0e:  CTL0028 Serial No 268458429 [checksum 43] 
Dec  9 03:56:44 dirty-bastard isapnp: CTL0028/268458429[0]{Audio               }: Ports 0x220 0x330 0x388; IRQ5 DMA1 DMA5 --- Enabled OK 
Dec  9 03:56:44 dirty-bastard isapnp: CTL0028/268458429[2]{Reserved            }: Port 0x110; --- Enabled OK 
Dec  9 03:56:44 dirty-bastard isapnp: CTL0028/268458429[3]{Game                }: Port 0x200; --- Enabled OK 
Dec  9 03:56:44 dirty-bastard rc.sysinit: Setting up ISA PNP devices succeeded 
Dec  9 03:56:44 dirty-bastard rc.sysinit: Remounting root filesystem in read-write mode succeeded 
Dec  9 03:56:56 dirty-bastard depmod: depmod:  
Dec  9 03:56:56 dirty-bastard depmod: *** Unresolved symbols in /lib/modules/2.2.5-15/misc/maui.o 
Dec  9 03:56:56 dirty-bastard rc.sysinit: Finding module dependencies succeeded 
Dec  9 03:56:57 dirty-bastard fsck: /dev/hda2: clean, 38356/200704 files, 724911/800352 blocks 
Dec  9 03:56:57 dirty-bastard rc.sysinit: Checking filesystems succeeded 
Dec  9 03:56:59 dirty-bastard rc.sysinit: Mounting local filesystems succeeded 
Dec  9 03:56:59 dirty-bastard rc.sysinit: Turning on user and group quotas for local filesystems succeeded 
Dec  9 03:57:02 dirty-bastard date: Sun Dec  9 03:57:02 GMT 2001 
Dec  9 03:57:02 dirty-bastard rc.sysinit: Setting clock  (utc): Sun Dec  9 03:57:02 GMT 2001 succeeded 
Dec  9 03:57:02 dirty-bastard rc.sysinit: Enabling swap space succeeded 
Dec  9 03:57:03 dirty-bastard network: Enabling IPv4 packet forwarding succeeded 
Dec  9 03:57:04 dirty-bastard ifup: SIOCADDRT: Network is unreachable 
Dec  9 03:57:07 dirty-bastard network: Bringing up interface lo succeeded 
Dec  9 03:57:08 dirty-bastard network: Bringing up interface eth0 succeeded 
Dec  9 03:57:09 dirty-bastard random: Initializing random number generator succeeded 
Dec  9 03:57:13 dirty-bastard crond: crond startup succeeded
Dec  9 03:57:17 dirty-bastard sshd: sshd startup succeeded
Dec  9 03:57:17 dirty-bastard keytable: Loading keymap: 
Dec  9 03:57:18 dirty-bastard keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Dec  9 03:57:19 dirty-bastard keytable: Loading system font: 
Dec  9 03:57:19 dirty-bastard rc: Starting keytable succeeded
Dec  9 03:57:22 dirty-bastard sendmail: sendmail startup succeeded
Dec  9 03:57:23 dirty-bastard ftpd: proftpd startup succeeded
Dec  9 03:57:26 dirty-bastard httpd: httpd startup succeeded
Dec  9 03:57:42 dirty-bastard httpsd: httpsd startup succeeded
Dec  9 03:57:43 dirty-bastard linuxconf: Linuxconf final setup
Dec  9 03:57:44 dirty-bastard rc: Starting linuxconf succeeded
Dec  9 03:57:45 dirty-bastard local: 
Dec  9 03:57:45 dirty-bastard local: /dev/hda:
Dec  9 03:57:45 dirty-bastard local:  setting 32-bit I/O support flag to 3
Dec  9 03:57:45 dirty-bastard local:  setting multcount to 16
Dec  9 03:57:45 dirty-bastard local:  setting keep_settings to 1 (on)
Dec  9 03:57:45 dirty-bastard local:  setting xfermode to 34 (multiword DMA mode2)
Dec  9 03:57:45 dirty-bastard local:  multcount    = 16 (on)
Dec  9 03:57:45 dirty-bastard local:  I/O support  =  3 (32-bit w/sync)
Dec  9 03:57:45 dirty-bastard local:  keepsettings =  1 (on)
Dec  9 03:57:46 dirty-bastard local: 
Dec  9 03:57:46 dirty-bastard local: /dev/hdc:
Dec  9 03:57:46 dirty-bastard local:  setting 32-bit I/O support flag to 1
Dec  9 03:57:46 dirty-bastard local:  setting multcount to 16
Dec  9 03:57:46 dirty-bastard local:  setting keep_settings to 1 (on)
Dec  9 03:57:46 dirty-bastard local:  setting xfermode to 0 (default PIO mode)
Dec  9 03:57:46 dirty-bastard local:  multcount    = 16 (on)
Dec  9 03:57:46 dirty-bastard local:  I/O support  =  1 (32-bit)
Dec  9 03:57:46 dirty-bastard local:  keepsettings =  1 (on)
Dec  9 03:57:47 dirty-bastard local:  HDIO_DRIVE_CMD failed: Input/output error
Dec  9 03:57:47 dirty-bastard rc: Starting local succeeded
--end boot.log


--begin .config
#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
CONFIG_M586=y
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
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
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
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
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
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
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_PM is not set
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
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
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
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set

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
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
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
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
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
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
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
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
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
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
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

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

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
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
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
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
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
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
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
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set

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
# CONFIG_SOUND_ES1371 is not set
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
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
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
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
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
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
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
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
--end .config
