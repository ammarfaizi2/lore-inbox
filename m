Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTEKMMX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTEKMMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:12:23 -0400
Received: from ulima.unil.ch ([130.223.144.143]:2737 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id S261159AbTEKMMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:12:22 -0400
Date: Sun, 11 May 2003 14:25:03 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69 and ide-floppy errors
Message-ID: <20030511122503.GA10013@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got those in syslog:

May 11 14:19:18 localhost kernel: ide_tcq_intr_timeout: timeout waiting for completion interrupt
May 11 14:19:18 localhost kernel: hda: invalidating tag queue (0 commands)
May 11 14:19:18 localhost kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 11 14:19:18 localhost kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
May 11 14:19:18 localhost kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May 11 14:19:18 localhost kernel: hdb: drive not ready for command
May 11 14:20:37 localhost kernel: ide_tcq_intr_timeout: timeout waiting for completion interrupt
May 11 14:20:37 localhost kernel: hda: invalidating tag queue (0 commands)
May 11 14:20:37 localhost kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 11 14:20:37 localhost kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
May 11 14:20:37 localhost kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May 11 14:20:37 localhost kernel: hdb: drive not ready for command
May 11 14:22:05 localhost kernel: ide_tcq_intr_timeout: timeout waiting for completion interrupt
May 11 14:22:05 localhost kernel: hda: invalidating tag queue (0 commands)
May 11 14:22:05 localhost kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 11 14:22:05 localhost kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
May 11 14:22:05 localhost kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May 11 14:22:05 localhost kernel: hdb: drive not ready for command

???
That with my ZIP 250 on a MSI Max2-BLR mother board...
Otherwise, it seems to works pretty good ;-)

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
