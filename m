Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289844AbSBUDmy>; Wed, 20 Feb 2002 22:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292316AbSBUDmo>; Wed, 20 Feb 2002 22:42:44 -0500
Received: from gw.wmich.edu ([141.218.1.100]:33413 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S289844AbSBUDm3>;
	Wed, 20 Feb 2002 22:42:29 -0500
Subject: Re: ide cd-recording not working in 2.4.18-rc2-ac1
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16diR7-0005RF-00@the-village.bc.nu>
In-Reply-To: <E16diR7-0005RF-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 22:42:30 -0500
Message-Id: <1014262955.799.27.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-20 at 20:54, Alan Cox wrote:
> > I get this on every cd I try and I've tried more than I'd have liked to.
> > 
> > Performing OPC...
> > 
> /usr/bin/cdrecord: Input/output error. write_g1: scsi sendcmd: no error
> > CDB:  2A 00 00 00 00 1F 00 00 1F 00
> > status: 0x2 (CHECK CONDITION)
> > Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 21 00 00 00
> > Sense Key: 0x5 Illegal Request, Segment 0
> > Sense Code: 0x21 Qual 0x00 (logical block address out of range) Fru 0x0
> 
> Thats saying that cdrecord sent the drive a bogus command.
> 
> > Now I know every cd isn't bad because they used to work in older
> > 2.4.17ish kernels.  I have scsi-generic support compiled as a module as
> 
> Does it still work with them ?
> 
> > SCSI subsystem driver Revision: 1.00
> > scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> 
> Right same as I am using
> 
> > not sure what else I can get informationwize about what the drive is
> > doing.  
> 
> What type of IDE controller ?

VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1


If i retry over and over sometimes it will eventually work.  (same cd)  



