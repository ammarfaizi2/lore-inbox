Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbUAFRup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUAFRup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:50:45 -0500
Received: from cicero2.cybercity.dk ([212.242.40.53]:34577 "EHLO
	cicero2.cybercity.dk") by vger.kernel.org with ESMTP
	id S264568AbUAFRuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:50:17 -0500
Subject: SCSI CD-detection!
From: Mads Christensen <mfc@krycek.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: krycek.org
Message-Id: <1073411416.2731.4.camel@krycek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 18:50:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey!

I Have a problem with the 2.6.0 kernel - it seems that the aic7xx-old
driver (which i also ran under 2.4) doesn't detect my normal cd-drive
but only my cdr! 

dmesg output: 
(scsi0) <Adaptec AIC-7850 SCSI host adapter> found at PCI 1/4/0
(scsi0) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi0) Downloading sequencer code... 415 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.6/5.2.0
       <Adaptec AIC-7850 SCSI host adapter>
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:0:1:0) Synchronous at 10.0 Mbyte/sec, offset 8.
sr0: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 1, lun 0,  type 5

- any fixes to make it detect the other drive: UltraPlex 32x

Thx
-- 
===================================================
| Mads F. Christensen     ||                      |
| Email:                  || mfc@krycek.org       |
| Webdesign Development   || www.krycek.org       |
===================================================


