Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVL2SeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVL2SeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 13:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVL2SeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 13:34:15 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:19351 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S1750811AbVL2SeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 13:34:14 -0500
Date: Thu, 29 Dec 2005 13:34:11 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: software raid 5 broken on 2.6.14.4 sparc
Message-ID: <Pine.LNX.4.64.0512291328210.21059@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had one of 5 drives fail in my raid 5 setup and now many files are 
unreadable..  Isn't raid 5 supposed to compensate for exactly this 
happening?

Dec 25 16:29:21 localhost kernel: nfsd: last server has exited
Dec 25 16:29:21 localhost kernel: nfsd: unexporting all filesystems
Dec 25 16:29:21 localhost kernel: RPC: failed to contact portmap (errno -5).
Dec 25 16:29:22 localhost kernel: NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Dec 25 16:29:22 localhost kernel: NFSD: starting 90-second grace period
Dec 25 16:29:31 localhost kernel: nfsd: last server has exited
Dec 25 16:29:31 localhost kernel: nfsd: unexporting all filesystems
Dec 25 16:29:31 localhost kernel: RPC: failed to contact portmap (errno -5).
Dec 25 16:29:32 localhost kernel: NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Dec 25 16:29:32 localhost kernel: NFSD: starting 90-second grace period
Dec 25 16:29:48 localhost kernel: nfsd: last server has exited
Dec 25 16:29:48 localhost kernel: nfsd: unexporting all filesystems
Dec 25 16:29:48 localhost kernel: RPC: failed to contact portmap (errno -5).
Dec 25 16:29:49 localhost kernel: NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Dec 25 16:29:49 localhost kernel: NFSD: starting 90-second grace period
Dec 25 16:43:43 localhost kernel: nfsd: last server has exited
Dec 25 16:43:43 localhost kernel: nfsd: unexporting all filesystems
Dec 25 16:43:43 localhost kernel: RPC: failed to contact portmap (errno -5).
Dec 25 16:43:45 localhost kernel: NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Dec 25 16:43:45 localhost kernel: NFSD: starting 90-second grace period
Dec 25 16:48:05 localhost kernel: nfsd: last server has exited
Dec 25 16:48:05 localhost kernel: nfsd: unexporting all filesystems
Dec 25 16:48:05 localhost kernel: RPC: failed to contact portmap (errno -5).
Dec 25 16:48:06 localhost kernel: NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Dec 25 16:48:06 localhost kernel: NFSD: starting 90-second grace period
Dec 25 18:17:30 localhost kernel: udp v4 hw csum failure.
Dec 25 18:23:50 localhost kernel: udp v4 hw csum failure.
Dec 25 18:36:27 localhost kernel: sde: Current: sense key: Recovered Error
Dec 25 18:36:27 localhost kernel:     Additional sense: Recovered data - recommend reassignment
Dec 25 18:36:27 localhost kernel: Info fld=0x5ccf6d
Dec 25 19:52:05 localhost kernel: sde: Current: sense key: Recovered Error
Dec 25 19:52:05 localhost kernel:     Additional sense: Recovered data with error corr. & retries applied
Dec 25 19:52:05 localhost kernel: Info fld=0xd77a
Dec 25 21:38:40 localhost kernel: udp v4 hw csum failure.
Dec 25 22:50:34 localhost kernel: udp v4 hw csum failure.
Dec 25 22:53:51 localhost kernel: udp v4 hw csum failure.
Dec 25 23:00:22 localhost kernel: udp v4 hw csum failure.
Dec 25 23:00:24 localhost kernel: udp v4 hw csum failure.
Dec 26 11:25:56 localhost kernel: sdb: Current: sense key: Recovered Error
Dec 26 11:25:56 localhost kernel:     Additional sense: Warning - specified temperature exceeded
Dec 27 14:50:33 localhost kernel: udp v4 hw csum failure.
Dec 27 14:50:33 localhost kernel: UDP: bad checksum. From 204.83.232.135:24638 to 64.235.218.35:57999 ulen 39
Dec 27 21:31:57 localhost kernel: sdb: Current: sense key: Recovered Error
Dec 27 21:31:57 localhost kernel:     Additional sense: Warning - specified temperature exceeded
Dec 28 12:36:06 localhost kernel: hw tcp v4 csum failed
Dec 28 14:33:36 localhost kernel: hw tcp v4 csum failed
Dec 28 16:21:56 localhost kernel: hw tcp v4 csum failed
Dec 28 17:18:22 localhost kernel: hw tcp v4 csum failed
Dec 28 17:18:41 localhost kernel: hw tcp v4 csum failed
Dec 28 17:33:26 localhost kernel: hw tcp v4 csum failed
Dec 28 17:51:38 localhost kernel: hw tcp v4 csum failed
Dec 28 18:03:54 localhost kernel: hw tcp v4 csum failed
Dec 28 18:05:04 localhost kernel: hw tcp v4 csum failed
Dec 28 18:12:34 localhost kernel: hw tcp v4 csum failed
Dec 28 18:13:37 localhost last message repeated 8 times
Dec 28 18:13:51 localhost last message repeated 7 times
Dec 28 18:15:32 localhost kernel: hw tcp v4 csum failed
Dec 28 18:16:55 localhost kernel: sde: Current: sense key: Recovered Error
Dec 28 18:16:55 localhost kernel:     Additional sense: Recovered data - recommend reassignment
Dec 28 18:16:55 localhost kernel: Info fld=0x4455d87
Dec 28 18:19:31 localhost kernel: hw tcp v4 csum failed
Dec 28 18:23:44 localhost kernel: hw tcp v4 csum failed
Dec 28 18:24:04 localhost last message repeated 13 times
Dec 28 18:25:13 localhost kernel: hw tcp v4 csum failed
Dec 28 18:26:57 localhost kernel: hw tcp v4 csum failed
Dec 28 18:27:34 localhost last message repeated 16 times
Dec 28 18:27:42 localhost kernel: printk: 9 messages suppressed.
Dec 28 18:27:42 localhost kernel: hw tcp v4 csum failed
Dec 28 18:28:05 localhost last message repeated 4 times
Dec 28 18:28:30 localhost kernel: hw tcp v4 csum failed
Dec 28 18:34:49 localhost kernel: hw tcp v4 csum failed
Dec 28 18:35:54 localhost last message repeated 17 times
Dec 28 18:36:15 localhost kernel: hw tcp v4 csum failed
Dec 28 19:50:30 localhost kernel: hw tcp v4 csum failed
Dec 29 02:54:51 localhost kernel: hw tcp v4 csum failed
Dec 29 06:26:07 localhost kernel: sd 0:0:12:0: SCSI error: return code = 0x8000002
Dec 29 06:26:07 localhost kernel: sdf: Current: sense key: Hardware Error
Dec 29 06:26:07 localhost kernel:     Additional sense: Mechanical positioning error
Dec 29 06:26:07 localhost kernel: end_request: I/O error, dev sdf, sector 9664
Dec 29 06:26:07 localhost kernel: raid5: Disk failure on sdf, disabling device. Operation continuing on 4 devices
Dec 29 06:26:07 localhost kernel: RAID5 conf printout:
Dec 29 06:26:07 localhost kernel:  --- rd:6 wd:4 fd:2
Dec 29 06:26:07 localhost kernel:  disk 0, o:1, dev:sdc
Dec 29 06:26:07 localhost kernel:  disk 1, o:1, dev:sdd
Dec 29 06:26:07 localhost kernel:  disk 2, o:1, dev:sde
Dec 29 06:26:07 localhost kernel:  disk 3, o:0, dev:sdf
Dec 29 06:26:07 localhost kernel:  disk 4, o:1, dev:sdg
Dec 29 06:26:07 localhost kernel: RAID5 conf printout:
Dec 29 06:26:07 localhost kernel:  --- rd:6 wd:4 fd:2
Dec 29 06:26:07 localhost kernel:  disk 0, o:1, dev:sdc
Dec 29 06:26:07 localhost kernel:  disk 1, o:1, dev:sdd
Dec 29 06:26:07 localhost kernel:  disk 2, o:1, dev:sde
Dec 29 06:26:07 localhost kernel:  disk 4, o:1, dev:sdg
Dec 29 06:26:07 localhost kernel: Buffer I/O error on device md0, logical block 6040
Dec 29 06:26:07 localhost kernel: lost page write due to I/O error on md0
Dec 29 06:26:07 localhost kernel: REISERFS: abort (device md0): Journal write error in flush_commit_list
Dec 29 06:26:07 localhost kernel: REISERFS: Aborting journal for filesystem on md0
Dec 29 07:16:56 localhost kernel: ReiserFS: md0: warning: clm-6006: writing inode 2996 on readonly FS
Dec 29 07:16:56 localhost kernel: ReiserFS: md0: warning: clm-6006: writing inode 2996 on readonly FS
Dec 29 07:17:28 localhost kernel: Buffer I/O error on device md0, logical block 5052984
Dec 29 07:17:28 localhost kernel: lost page write due to I/O error on md0



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
