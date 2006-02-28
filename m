Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbWB1XGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWB1XGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWB1XGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:06:42 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:32713 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S932702AbWB1XGl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:06:41 -0500
From: Francesco Biscani <biscani@pd.astro.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA patch for 2.6.16-rc5
Date: Wed, 1 Mar 2006 00:06:38 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1141054370.3089.0.camel@localhost.localdomain>
In-Reply-To: <1141054370.3089.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603010006.38366.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this is to be expected, but blanking of a cdrw fails here. 
Output of cdrecord is:

Cdrecord-Clone 2.01 (i686-pc-linux-gnu) Copyright (C) 1995-2004 J�g Schilling
cdrecord: Warning: Running on Linux-2.6.16-rc5-morph1
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.
scsidev: '/dev/sr0'
devname: '/dev/sr0'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   :
Vendor_info    : 'HL-DT-ST'
Identifikation : 'RW/DVD GCC-4241N'
Revision       : '0C29'
Device seems to be: Generic mmc2 DVD-ROM.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
cdrecord: Input/output error. test unit ready: scsi sendcmd: no error
CDB:  00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 3A 00 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x3A Qual 0x00 (medium not present) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.008s timeout 40s
cdrecord: No disk / Wrong disk

Regards,

  Francesco

-- 
Dr. Francesco Biscani
Dipartimento di Astronomia
Università di Padova
biscani@pd.astro.it
