Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318897AbSICSUC>; Tue, 3 Sep 2002 14:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318898AbSICSUB>; Tue, 3 Sep 2002 14:20:01 -0400
Received: from adsl-63-196-213-243.dsl.snfc21.pacbell.net ([63.196.213.243]:35503
	"HELO homer.d-oh.org") by vger.kernel.org with SMTP
	id <S318897AbSICST4>; Tue, 3 Sep 2002 14:19:56 -0400
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: SCSI disk error
Date: Tue, 3 Sep 2002 11:24:27 -0700
Message-ID: <JIEIIHMANOCFHDAAHBHOOEOECOAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I got the following error message last night on one of my SCSI disks:

SCSI disk error : host 0 channel 0 id 6 lun 0 return code = 100ff
 I/O error: dev 08:11, sector 38584
raid1: Disk failure on scsi/host0/bus0/target6/lun0/part1, disabling device.
        Operation continuing on 1 devices

Is there any way to look up what the return code means?  By the way,
badblocks doesn't seem to return any bad blocks, and I can still access the
disk (including the first partition) just fine.  I found documentation for
my hard drive at
http://www.fcpa.fujitsu.com/download/download/hard-drives/man10krpm-scsi-man
ual.pdf where it has sense data information on page 115, but I'm not sure if
that's the right place to look.

I'm running kernel 2.4.19, and have a Tekram DC-390U3W (SYM53C8XX_2 driver)
SCSI controller with two Fujitsu MAN3367MP drives.

Thanks in advance.

Best regards,

Alex

