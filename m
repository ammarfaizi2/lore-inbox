Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbTFMSdS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbTFMSdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:33:18 -0400
Received: from the-penguin.otak.com ([65.37.126.18]:4993 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S265488AbTFMSdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:33:09 -0400
Date: Fri, 13 Jun 2003 11:46:49 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: CD-ROM not showing up in /dev with devfs
Message-ID: <20030613184649.GA12113@the-penguin.otak.com>
Mail-Followup-To: Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.5.70-mm9 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI CD-ROM not showing up in /dev with devfs
Compiled in or as a module no cdrom device is shown.

lawrence@the-penguin:~$ cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
Vendor: IBM      Model: DCAS-34330W      Rev: S65A
Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
Vendor: IBM      Model: DCAS-34330W      Rev: S65A
Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
Vendor: IBM      Model: DNES-318350W     Rev: SA30
Type:   Direct-Access                    ANSI SCSI revision:
03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
Vendor: HP       Model: CD-Writer+ 9600  Rev: 1.0a
Type:   CD-ROM                           ANSI SCSI
revision: 04
Host: scsi0 Channel: 00 Id: 06 Lun: 00
Vendor: IBM      Model: IC35L018UWD210-0 Rev: S5CQ
Type:   Direct-Access                    ANSI SCSI
revision: 03


lawrence@the-penguin:~$ ls /dev/scsi/host0/bus0/target4/lun0/
generic

This seems to be true in all of the 70-mm series.


-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


