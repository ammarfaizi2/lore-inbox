Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132433AbRDHCPd>; Sat, 7 Apr 2001 22:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132462AbRDHCPX>; Sat, 7 Apr 2001 22:15:23 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:64783 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S132433AbRDHCPN>; Sat, 7 Apr 2001 22:15:13 -0400
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD1128E3D@cceexc19.americas.cpqcorp.net>
From: "Cagle, John" <John.Cagle@COMPAQ.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE:  Compaq proliant ML-350 - IDE & SCSI
Date: Sat, 7 Apr 2001 21:15:05 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2001 21:55:53, Alexandru Barloiu Nicolae wrote:
> I am trying to use the DMA on the ide drives. After the reboot Dma is
> enabled but if I don't disable it with hdparm the system freezes at heavy
> work (copy something from a drive to the other). The SCSI works ok.
Without
> the DMA the system barely moves
>
> <SNIP>
>
> Any ideas what's wrong?

Which kernel version are you using?  The OSB4 ide driver prior to version
2.4.2-ac27 causes problems on SMP servers.  You may want to try a more
recent kernel or remove the OSB4-specific driver and use the standard
IDE/ATA driver instead.

Regards,
John Cagle
Principal Member Technical Staff
ProLiant Servers, Compaq
