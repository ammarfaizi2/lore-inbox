Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTEKMXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTEKMXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:23:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42661 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261196AbTEKMXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:23:22 -0400
Date: Sun, 11 May 2003 14:35:48 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Gregoire Favre <greg@ulima.unil.ch>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69 and ide-floppy errors
In-Reply-To: <20030511122503.GA10013@ulima.unil.ch>
Message-ID: <Pine.SOL.4.30.0305111434500.4788-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Don't compile TCQ support in.
What do you have on hda and hdb?
--
Bartlomiej

On Sun, 11 May 2003, Gregoire Favre wrote:

> Hello,
>
> I got those in syslog:
>
> May 11 14:19:18 localhost kernel: ide_tcq_intr_timeout: timeout waiting for completion interrupt
> May 11 14:19:18 localhost kernel: hda: invalidating tag queue (0 commands)
> May 11 14:19:18 localhost kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> May 11 14:19:18 localhost kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> May 11 14:19:18 localhost kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 11 14:19:18 localhost kernel: hdb: drive not ready for command
> May 11 14:20:37 localhost kernel: ide_tcq_intr_timeout: timeout waiting for completion interrupt
> May 11 14:20:37 localhost kernel: hda: invalidating tag queue (0 commands)
> May 11 14:20:37 localhost kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> May 11 14:20:37 localhost kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> May 11 14:20:37 localhost kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 11 14:20:37 localhost kernel: hdb: drive not ready for command
> May 11 14:22:05 localhost kernel: ide_tcq_intr_timeout: timeout waiting for completion interrupt
> May 11 14:22:05 localhost kernel: hda: invalidating tag queue (0 commands)
> May 11 14:22:05 localhost kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> May 11 14:22:05 localhost kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> May 11 14:22:05 localhost kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 11 14:22:05 localhost kernel: hdb: drive not ready for command
>
> ???
> That with my ZIP 250 on a MSI Max2-BLR mother board...
> Otherwise, it seems to works pretty good ;-)
>
> 	Grégoire

