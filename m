Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292605AbSBUBkZ>; Wed, 20 Feb 2002 20:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292307AbSBUBkO>; Wed, 20 Feb 2002 20:40:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:784 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292306AbSBUBj7>; Wed, 20 Feb 2002 20:39:59 -0500
Subject: Re: ide cd-recording not working in 2.4.18-rc2-ac1
To: ed.sweetman@wmich.edu (Ed Sweetman)
Date: Thu, 21 Feb 2002 01:54:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1014237877.441.7.camel@psuedomode> from "Ed Sweetman" at Feb 20, 2002 03:44:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16diR7-0005RF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get this on every cd I try and I've tried more than I'd have liked to.
> 
> Performing OPC...
> /usr/bin/cdrecord: Input/output error. write_g1: scsi sendcmd: no error
> CDB:  2A 00 00 00 00 1F 00 00 1F 00
> status: 0x2 (CHECK CONDITION)
> Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 21 00 00 00
> Sense Key: 0x5 Illegal Request, Segment 0
> Sense Code: 0x21 Qual 0x00 (logical block address out of range) Fru 0x0

Thats saying that cdrecord sent the drive a bogus command.

> Now I know every cd isn't bad because they used to work in older
> 2.4.17ish kernels.  I have scsi-generic support compiled as a module as

Does it still work with them ?

> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices

Right same as I am using

> not sure what else I can get informationwize about what the drive is
> doing.  

What type of IDE controller ?
