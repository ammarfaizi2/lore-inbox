Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWEWGUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWEWGUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 02:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWEWGUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 02:20:09 -0400
Received: from main.gmane.org ([80.91.229.2]:41698 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932099AbWEWGUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 02:20:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Aaron Gyes <floam@sh.nu>
Subject: Re: ASUS A8V Deluxe, =?utf-8?b?eDg2XzY0?=
Date: Tue, 23 May 2006 06:10:15 +0000 (UTC)
Message-ID: <loom.20060523T080432-839@post.gmane.org>
References: <8E8F647D7835334B985D069AE964A4F7028FDBE8@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 71.193.190.213 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.3) Gecko/20060513 Ubuntu/dapper Epiphany/2.14 Firefox/1.5.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have the latest libata stuff from git as of a couple days ago and all
appeared to be working, my Plextor PX716-SA appeared to be detected, and I could
read from it fine. But if I burn CDs, no matter what I do, burnfree on, burnfree
off, 4x, I get corruption, with either total coasters or readable filesystems
with md5s that are all off. I'm not sure what I could possibly be doing wrong, I
know it shouldn't be this difficult to write a CD. I also have a Asus A8V.

Here's some cdrecord output, I do notice some things which may or may not be as
bad as they look:

cdrecord stderr: cdrecord: Warning: Running on Linux-2.6.17-rc4-floam1
cdrecord stderr: cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord stderr: cdrecord: If you have unexpected problems, please try Linux-2.4
 or Solaris.
cdrecord stderr: scsidev: '/dev/scd0'
cdrecord stderr: devname: '/dev/scd0'
cdrecord stderr: scsibus: -2 target: -2 lun: -2
cdrecord stderr: Warning: Open by 'devname' is unintentional and not supported.
cdrecord stderr: Linux sg driver version: 3.5.27
cdrecord stderr: cdrecord: Warning: using inofficial version of libscg (debian-0
.8debian2 '@(#)scsitransp.c     1.91 04/06/17 Copyright 1988,1995,2000-2004 J. S
chilling').
cdrecord stderr: SCSI buffer size: 64512
cdrecord stderr: cdrecord: This version of cdrecord does not include DVD-R/DVD-R
W support code.
cdrecord stderr: cdrecord: See /usr/share/doc/cdrecord/README.DVD.Debian for det
ails on DVD support.
cdrecord stdout: Cdrecord-Clone 2.01.01a01 (i686-pc-linux-gnu) Copyright (C) 199
5-2004 Joerg Schilling
cdrecord stdout: NOTE: this version of cdrecord is an inofficial (modified) rele
ase of cdrecord
cdrecord stdout:       and thus may have bugs that are not present in the origin
al version.
cdrecord stdout:       Please send bug reports and support requests to <cdrtools
@packages.debian.org>.
cdrecord stdout:       The original author should not be bothered with problems
of this version.
cdrecord stdout:
cdrecord stdout: TOC Type: 1 = CD-ROM
cdrecord stdout: Using libscg version 'debian-0.8debian2'.
cdrecord stdout: Driveropts: 'burnfree'
cdrecord stdout: atapi: 1
cdrecord stdout: Device type    : Removable CD-ROM
cdrecord stdout: Version        : 5
cdrecord stdout: Response Format: 2
cdrecord stdout: Capabilities   :
cdrecord stdout: Vendor_info    : 'PLEXTOR '
cdrecord stdout: Identifikation : 'DVDR   PX-716A  '
cdrecord stdout: Revision       : '1.08'
cdrecord stdout: Device seems to be: Generic mmc2 DVD-R/DVD-RW.
cdrecord stdout: Current: 0x0009
cdrecord stdout: Profile: 0x002B
cdrecord stdout: Profile: 0x001B
cdrecord stdout: Profile: 0x001A
cdrecord stdout: Profile: 0x0015
cdrecord stdout: Profile: 0x0014
cdrecord stdout: Profile: 0x0013
cdrecord stdout: Profile: 0x0011
cdrecord stdout: Profile: 0x0010
cdrecord stdout: Profile: 0x000A
cdrecord stdout: Profile: 0x0009 (current)
cdrecord stdout: Profile: 0x0008
cdrecord stdout: Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
cdrecord stdout: Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC GIGAREC FORCE
SPEED SPEEDREAD SINGLESESSION HIDECDR
cdrecord stdout: Supported modes: TAO SAO SAO/R96P SAO/R96R RAW/R96R
cdrecord stdout: Drive buf size : 4802784 = 4690 KB
cdrecord stdout: Drive DMA Speed: 22958 kB/s 130x CD 16x DVD
cdrecord stdout: FIFO size      : 16777216 = 16384 KB
cdrecord stdout: Track 01: data   100 MB
cdrecord stdout: Total size:      115 MB (11:25.48) = 51411 sectors
cdrecord stdout: Lout start:      115 MB (11:27/36) = 51411 sectors
cdrecord stdout: Current Secsize: 2048
cdrecord stdout: ATIP info from disk:
cdrecord stdout:   Indicated writing power: 4
cdrecord stdout:   Is not unrestricted
cdrecord stdout:   Is not erasable
cdrecord stdout:   Disk sub type: Medium Type A, low Beta category (A-) (2)
cdrecord stdout:   ATIP start of lead in:  -12508 (97:15/17)
cdrecord stdout:   ATIP start of lead out: 359845 (79:59/70)
cdrecord stdout: Disk type:    Short strategy type (Phthalocyanine or similar)
cdrecord stdout: Manuf. index: 22
cdrecord stdout: Manufacturer: Ritek Co.
cdrecord stdout: Single session is OFF.
cdrecord stdout: Hide CDR is OFF.
cdrecord stdout: Speed-Read is OFF.
cdrecord stdout: GigaRec is off.
cdrecord stdout: Blocks total: 359845 Blocks current: 359845 Blocks remaining: 3
08434
cdrecord stdout: Forcespeed is OFF.
cdrecord stdout: Power-Rec is ON.
cdrecord stdout: Power-Rec write speed:     48x (recommended)
cdrecord stdout: Starting to write CD/DVD at speed 16 in real SAO mode for singl
e session.
cdrecord stdout: Last chance to quit, starting real write    0 seconds.
Operation starts.
cdrecord stderr: cdrecord: Input/output error. mode select g1: scsi sendcmd: no
error
cdrecord stdout: Waiting for reader process to fill input buffer ... input
buffer ready.
cdrecord stderr: CDB:  55 10 00 00 00 00 00 00 3C 00
cdrecord stdout: BURN-Free is ON.
cdrecord stderr: status: 0x2 (CHECK CONDITION)
cdrecord stdout: Performing OPC...
cdrecord stderr: Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 26 00 00 00
cdrecord stderr: Sense Key: 0x5 Illegal Request, Segment 0
cdrecord stderr: Sense Code: 0x26 Qual 0x00 (invalid field in parameter list)
Fru 0x0
cdrecord stderr: Sense flags: Blk 0 (not valid)
cdrecord stderr: resid: 60
cdrecord stderr: cmd finished after 0.000s timeout 200s
cdrecord stderr: cdrecord: Warning: using default CD write parameter data.
cdrecord stderr: Mode Select Data 00 10 00 00 05 32 41 04 08 10 00 00 00 00 00
00 00 00 00 96 00 00 00 00  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cdrecord stderr: cdrecord: Cannot set up 2nd set of driver options.
cdrecord stdout: Sending CUE sheet...
cdrecord stdout: Writing pregap for track 1 at -150
cdrecord stdout: Starting new track at sector: 0
cdrecord stdout: Track 01:  100 of  100 MB written (fifo 100%) [buf  99%]  16.9x.
cdrecord stdout: Track 01: Total bytes read/written: 105289728/105289728 (51411
sectors).
cdrecord stdout: Writing  time:   64.725s
cdrecord stdout: Average write speed  12.7x.
cdrecord stdout: Min drive buffer fill was 99%
cdrecord stdout: Fixating...
cdrecord stdout: Fixating time:    7.316s
cdrecord stdout: Last selected write speed: 16x
cdrecord stderr: cdrecord: fifo had 1659 puts and 1659 gets.
cdrecord stdout: Max media write speed:     48x
cdrecord stderr: cdrecord: fifo was 0 times empty and 1403 times full, min fill
was 99%.
cdrecord stdout: Last actual write speed:   16x


