Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266611AbRGLVXR>; Thu, 12 Jul 2001 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRGLVXG>; Thu, 12 Jul 2001 17:23:06 -0400
Received: from merlin.giref.ulaval.ca ([132.203.7.100]:21386 "HELO
	merlin.giref.ulaval.ca") by vger.kernel.org with SMTP
	id <S266603AbRGLVW4>; Thu, 12 Jul 2001 17:22:56 -0400
Message-ID: <3B4E14E4.BF0497@giref.ulaval.ca>
Date: Thu, 12 Jul 2001 17:21:40 -0400
From: Luc Lalonde <llalonde@giref.ulaval.ca>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Adaptec SCSI driver lockups
Content-Type: multipart/mixed;
 boundary="------------84575FBDAF6CD0EFFB3615C0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------84575FBDAF6CD0EFFB3615C0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello folks,

I'm having trouble identifying wether I'm having hardware or software(
OS ) problems.  For the past couple of Months I've been having system
lockups every 10 days or so.

I suspect that it is a problem with the Adaptec 39160 SCSI controller
that is on my system (aic799).  The lockups always occur when I'm
backing up to my HP DAT40 that is connected to channel A of this SCSI
controller.  The strange thing is that I backup every night most of the
time without problems to this tape.  

Here is some info on my system:

Kernel: 2.4.6pre3 ( I've been getting the same problem since 2.4.2 )

Here is all the SCSI controller info (the first two are on the
motherboard):

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/255 SCBs

scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi3 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/255 SCBs

This is a PowerEdge 2400 Dual 866Mhz PentiumIII:

Motherboard: ServerWorks Entry ServerSet III LE64 Chipset
HardDrives: Four 36Gig Ultra160 connected to scsi0 (aic7890/91)
TapeDrive: HP DAT40 connected to scsi2

I've checked the termination on the 39160 and everything seems fine.

Would anyone have any pointers?  Please CC:llalonde@giref.ulaval.ca

Thanks.

-- 
Luc Lalonde, Responsable du reseau GIREF

Telephone: (418) 656-2131 poste 6623
Courriel: llalonde@giref.ulaval.ca
--------------84575FBDAF6CD0EFFB3615C0
Content-Type: text/x-vcard; charset=us-ascii;
 name="llalonde.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Luc Lalonde
Content-Disposition: attachment;
 filename="llalonde.vcf"

begin:vcard 
n:Lalonde;Luc
x-mozilla-html:FALSE
org:Universite Laval;GIREF
adr:;;;;;;
version:2.1
email;internet:llalonde@giref.ulaval.ca
title:Administateur de reseau
x-mozilla-cpt:;0
fn:Luc Lalonde
end:vcard

--------------84575FBDAF6CD0EFFB3615C0--

