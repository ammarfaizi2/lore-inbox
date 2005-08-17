Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVHQDGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVHQDGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 23:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVHQDGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 23:06:31 -0400
Received: from siaag1ak.mx.compuserve.com ([149.174.40.26]:59168 "EHLO
	siaag1ak.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750804AbVHQDGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 23:06:30 -0400
Date: Tue, 16 Aug 2005 23:01:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [2.6.13-rc6-latest] SCSI disk registration msgs repeat
  themselves
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "linux-usb-devel@lists.sourceforge.net" 
	<linux-usb-devel@lists.sourceforge.net>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Message-ID: <200508162304_MC3-1-A768-3F2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I just added some usb-storage devices to my system and got the below.
Why do the first four lines repeat for each device?  (Not sure if
this is a SCSI or USB problem.)

[   23.433725] SCSI device sda: 63424 512-byte hdwr sectors (32 MB)
[   23.560564] sda: Write Protect is off
[   23.560581] sda: Mode Sense: 02 00 00 00
[   23.560593] sda: assuming drive cache: write through
[   23.572525] SCSI device sda: 63424 512-byte hdwr sectors (32 MB)
[   23.576504] sda: Write Protect is off
[   23.576519] sda: Mode Sense: 02 00 00 00
[   23.576530] sda: assuming drive cache: write through
[   23.576545]  sda: sda1
[   23.583752] Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
[   23.583847] Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
[   23.584701] usb-storage: device scan complete
[   32.116248] SCSI device sdb: 196608 512-byte hdwr sectors (101 MB)
[   32.141310] sdb: Write Protect is off
[   32.153477] sdb: Mode Sense: 45 00 00 08
[   32.153490] sdb: assuming drive cache: write through
[   32.178386] SCSI device sdb: 196608 512-byte hdwr sectors (101 MB)
[   32.204473] sdb: Write Protect is off
[   32.216654] sdb: Mode Sense: 45 00 00 08
[   32.216735] sdb: assuming drive cache: write through
[   32.233259]  sdb: sdb4
[   32.246595] Attached scsi removable disk sdb at scsi2, channel 0, id 0, lun 0
[   32.270348] Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
[   32.295843] usb-storage: device scan complete


__
Chuck
