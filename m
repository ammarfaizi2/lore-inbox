Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTL1WPU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 17:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTL1WPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 17:15:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:61322 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262114AbTL1WPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 17:15:15 -0500
X-Authenticated: #552865
Date: Sun, 28 Dec 2003 23:22:00 +0100
From: Florian Schuele <schuele@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 IDE drive_cmd error=0x04 - results in heavy freeze
Message-ID: <20031228222200.GA2225@spacken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-KeyID: 0xBBCE086E
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 i have a problem with the final release of kernel 2.6.0.
 After a few minutes running and having a little traffic
 on my harddisk, i get the following errors in my messages
 log:

 kernel: hdc: drive_cmd: status=0x51 { DriveReady\
 SeekComplete Error }

 kernel: hdc: drive_cmd: error=0x04 { DriveStatusError }

 I get a few of these messages and then my machine freezes.
 Nothing works anymore. The only thing i can do is switching off the
 machine or pressing the reset switch...

 Since i installed my machine with a
 2.4.20-gentoo-r6 kernel SMP (i686), the 2.4.20 runs
 without any problems!

 Now i have the two kernels installed. The 2.4.20 from above and the
 2.6.0 (gentoo development-sources).

 - This error occurs with both 2 IDE disks in my machine.
 - "Use multi-mode by default" is enabled in both kernels.
 - A "fsck.ext3 -f" on my root partition (hdc3) had no errors.
 - A drive fitness test from IBM (hitachi) didnt report any errors.
 - Distribution is gentoo 1.4

 Thanks a lot for hints...

Florian Schuele

