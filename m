Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313476AbSDJST7>; Wed, 10 Apr 2002 14:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313409AbSDJST6>; Wed, 10 Apr 2002 14:19:58 -0400
Received: from matav-4.matav.hu ([145.236.252.35]:22590 "EHLO
	Forman.fw.matav.hu") by vger.kernel.org with ESMTP
	id <S313476AbSDJST5>; Wed, 10 Apr 2002 14:19:57 -0400
Date: Wed, 10 Apr 2002 20:16:57 +0200 (CEST)
From: Narancs v1 <narancs@narancs.tii.matav.hu>
X-X-Sender: narancs@helka
To: linux-kernel@vger.kernel.org
Subject: ide-scsi hanging on modprobe, 2.4.18-ac1
Message-ID: <Pine.LNX.4.44.0204102015100.6563-100000@helka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


