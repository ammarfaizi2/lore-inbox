Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265271AbUENNJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUENNJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265272AbUENNJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:09:35 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:59661 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S265271AbUENNJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:09:29 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: mdharm-usb@one-eyed-alien.net
Subject: VMAX USB-STORAGE - kernel deadlock
Date: Fri, 14 May 2004 15:09:25 +0200
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200405141509.25967.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my friend bought usb flash disk VMAX/USB2.0/0404 version.
Under WinXP it works, but not under Linux.
There is 1 vfat filesystem, but linux reports 4 and when I try mount one, 
kernel goes to deadlock. System reports bad size too.

Tested 2.4.26, 2.6.6

Here is output:

SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: VMAX      Model: 128MB             Rev: 2.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
USB Mass Storage device found at 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
sda: Unit Not Ready, sense:
Current : sense key Unit Attention
Additional sense: Not ready to ready change, medium may have changed
SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3 sda4

Michal
