Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbTEKMUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTEKMUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:20:48 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:22914
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261231AbTEKMUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:20:47 -0400
Date: Sun, 11 May 2003 08:24:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Gregoire Favre <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 and ide-floppy errors
In-Reply-To: <20030511122503.GA10013@ulima.unil.ch>
Message-ID: <Pine.LNX.4.50.0305110822360.15337-100000@montezuma.mastecende.com>
References: <20030511122503.GA10013@ulima.unil.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, Gregoire Favre wrote:

> May 11 14:19:18 localhost kernel: ide_tcq_intr_timeout: timeout waiting for completion interrupt
> May 11 14:19:18 localhost kernel: hda: invalidating tag queue (0 commands)
> May 11 14:19:18 localhost kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> May 11 14:19:18 localhost kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> May 11 14:19:18 localhost kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> May 11 14:19:18 localhost kernel: hdb: drive not ready for command
> 
> ???
> That with my ZIP 250 on a MSI Max2-BLR mother board...
> Otherwise, it seems to works pretty good ;-)

ide_tcq_intr_timeout with a ZIP disk? Oh my.

CONFIG_BLK_DEV_IDE_TCQ ?

-- 
function.linuxpower.ca
