Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313661AbSDJTkh>; Wed, 10 Apr 2002 15:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313673AbSDJTkg>; Wed, 10 Apr 2002 15:40:36 -0400
Received: from matav-4.matav.hu ([145.236.252.35]:2072 "EHLO
	Forman.fw.matav.hu") by vger.kernel.org with ESMTP
	id <S313661AbSDJTke>; Wed, 10 Apr 2002 15:40:34 -0400
Date: Wed, 10 Apr 2002 21:37:43 +0200 (CEST)
From: Narancs v1 <narancs@narancs.tii.matav.hu>
X-X-Sender: narancs@helka
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre6,too re: ide-scsi hanging on modprobe, 2.4.18-ac1 (fwd)
Message-ID: <Pine.LNX.4.44.0204102136340.6563-100000@helka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so it does with the latest stable-pre

bad hardware?

now, ide-cd can't mount it neither saying bad superblock.

-------------------------
Narancs v1
IT Security Administrator
Warning: This is a really short .sig! Vigyazat: ez egy nagyon rovid szig!


---------- Forwarded message ----------
Date: Wed, 10 Apr 2002 20:16:57 +0200 (CEST)
From: Narancs v1 <narancs@narancs.tii.matav.hu>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi hanging on modprobe, 2.4.18-ac1

Hi!

everything is working fine with this kernel, but this

modprobe ide-scsi

hdd: ATAPI reset complete
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
scsi : aborting command due to timeout : pid 221340, scsi1, channel 0, id
0, lun 0 Inquiry 00 00 00 ff 00
SCSI host 1 abort (pid 221340) timed out - resetting
SCSI bus is being reset for host 1 channel 0.
hdd: ATAPI reset complete
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdd: ATAPI reset complete

forever it does.

is it because of AC's stuff?

which version is recommended for daily use?

thanks

-------------------------
Narancs v1
IT Security Administrator
Warning: This is a really short .sig! Vigyazat: ez egy nagyon rovid szig!



