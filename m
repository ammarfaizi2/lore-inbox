Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbTASMvs>; Sun, 19 Jan 2003 07:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbTASMvs>; Sun, 19 Jan 2003 07:51:48 -0500
Received: from ulima.unil.ch ([130.223.144.143]:61375 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S267458AbTASMvr>;
	Sun, 19 Jan 2003 07:51:47 -0500
Date: Sun, 19 Jan 2003 14:00:49 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Status of ide-cdrom writing?
Message-ID: <20030119130049.GA15941@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I sent this email to the cdwrite ml a while ago, and the conclusion was
that it was a kernel bug... so I forward here ;-)

I got the same result with 2.5.58 (I need to compil a 2.5.59...).

Thank you very much ;-)

----- Forwarded message from Gregoire Favre <greg@ulima.unil.ch> -----

Date: Sun, 12 Jan 2003 22:58:50 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: cdwrite@other.debian.org
Subject: Status of ide writing?

Hello,

is it possible to burn without idescsi under 2.5.56?

I got:

Cdrecord-ProDVD-Clone 2.0 (i586-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Unlocked features: ProDVD Clone 
Limited  features: speed 
This copy of cdrecord is licensed for: private/research/educational_non-commercial_use
TOC Type: 1 = CD-ROM
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Driveropts: 'burnfree'
atapi: 1
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'SONY    '
Identifikation : 'DVD RW DRU-500A '
Revision       : '1.0f'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
Driver flags   : DVD SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96R RAW/R96R
Drive buf size : 8126464 = 7936 KB
FIFO size      : 67108864 = 65536 KB
Track 01: data  3502 MB        
Total size:     3502 MB = 1793056 sectors
Current Secsize: 2048
Blocks total: 2298496 Blocks current: 2298496 Blocks remaining: 505440
Starting to write CD/DVD at speed 1 in real SAO mode for single session.
Last chance to quit, starting real write in 9 seconds.  0.28% done, estimate finish Sun Jan 12 22:32:14 2003
  0.56% done, estimate finish Sun Jan 12 22:29:15 2003
  0.84% done, estimate finish Sun Jan 12 22:28:15 2003
  1.12% done, estimate finish Sun Jan 12 22:27:45 2003
   8 seconds.  1.39% done, estimate finish Sun Jan 12 22:28:39 2003
  1.67% done, estimate finish Sun Jan 12 22:28:15 2003
   0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is ON.
Starting new track at sector: 0
Track 01:    4 of 3502 MB written (fifo  99%)  13.1x.cdrecord-prodvd: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 08 B8 00 00 1F 00
status: 0x1 (GOOD STATUS)
resid: 63488
cmd finished after 0.011s timeout 100s

write track data: error after 4571136 bytes
Sense Bytes: 70 00 00 00 00 00 00 12 00 00 00 00 00 00 00 00 00 00
Writing  time:    5.315s
Average write speed 501.9x.
Fixating...
Fixating time:   84.976s
cdrecord-prodvd: fifo had 1095 puts and 73 gets.
cdrecord-prodvd: fifo was 0 times empty and 7 times full, min fill was 99%.
Exit 254

Should I compil again with ide-scsi?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
