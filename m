Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318848AbSH1ONO>; Wed, 28 Aug 2002 10:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318850AbSH1ONO>; Wed, 28 Aug 2002 10:13:14 -0400
Received: from smtp-out.voila.wanadooportails.com ([193.252.117.74]:2851 "EHLO
	smtp-out.voila.wanadooportails.com") by vger.kernel.org with ESMTP
	id <S318848AbSH1ONM> convert rfc822-to-8bit; Wed, 28 Aug 2002 10:13:12 -0400
Date: Wed, 28 Aug 2002 16:16:59 +0200
Message-Id: <H1K50B$AC854D30BB224167685C29984508D6D1@voila.fr>
Subject: =?iso-8859-1?Q?devfs_cdrom_mount_pb?=
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "=?iso-8859-1?Q?qwerty314?=" <qwerty314@voila.fr>
To: "=?utf-8?Q?linux-kernel?=" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 3.2 (B27)
X-type: 0
X-SenderIP: 134.214.65.155
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
My linux box was runing fine till I decide to try devfs on RH7.3 with 2.4.18-3 kernel
after some adjustments everything is nearly OK with the new /dev concepts but when I
try to mount a cdrom it says that the device is not a block device.
cat /proc/scsi/scsi gives :

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1610A Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SAMSUNG  Model: CD-ROM SC-152C   Rev: CS05
  Type:   CD-ROM                           ANSI SCSI revision: 02

and ls -l /dev/scsi/host0/bus0/target1/lun0/* gives
crw-rw-rw-    1 root     root      21,   1 jan  1  1970
/dev/scsi/host0/bus0/target1/lun0/generic

quid?
why has my cdrom entry switched from a block to a character device and how to cure it ?

thanks                Denis

------------------------------------------

Faites un voeu et puis Voila ! www.voila.fr 

