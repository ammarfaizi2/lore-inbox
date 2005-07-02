Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVGBWjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVGBWjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 18:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVGBWjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 18:39:39 -0400
Received: from [202.136.32.45] ([202.136.32.45]:35752 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261316AbVGBWjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 18:39:36 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: CyberOptic <mail@cyberoptic.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppa / parport zip-drive / kernel 2.6.12.2
Date: Sun, 03 Jul 2005 08:39:20 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <4g5ec1pftrkmejqs3rdl8lms2j49a7duhp@4ax.com>
References: <42C6FD00.2060408@cyberoptic.de> <1a3ec1t4evi7dcops742493hv7vd9aijb5@4ax.com> <42C71353.3000802@cyberoptic.de>
In-Reply-To: <42C71353.3000802@cyberoptic.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jul 2005 00:21:07 +0200, CyberOptic <mail@cyberoptic.de> wrote:
>Can you post your dmesg-output after loading the ppa module, please?
>Maybe this might help me.
>
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Found device at ID 6, Attempting to use PS/2
ppa: Communication established with ID 6 using PS/2
scsi0 : Iomega VPI0 (ppa) interface
  Vendor: IOMEGA    Model: ZIP 100           Rev: D.17
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0
grant@pooh:~$ uname -r
2.6.12.2a

After mount:
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
 sda: sda4

--Grant.

