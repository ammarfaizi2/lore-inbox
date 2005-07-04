Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVGDMVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVGDMVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVGDMVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:21:41 -0400
Received: from mail.norkart.no ([217.68.101.85]:14252 "HELO mail.norkart.no")
	by vger.kernel.org with SMTP id S261645AbVGDMVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:21:38 -0400
Message-ID: <42C929CE.90904@linux-user.net>
Date: Mon, 04 Jul 2005 14:21:34 +0200
From: Daniel Andersen <anddan@linux-user.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel panic when booting without acpi=off as of 2.6.12-rc1 and above
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of error:

insmod error inserting '/lib/ata_piix.ko': -1 Unknown symbol in module
ERROR: /bin/insmod exited abnormally!
Mounting root filesystem
mount: error 19 mounting ext3
mount: error 2 mounting none
Switching to new root
switchroot: mount failed: 22
umount /initrd/dev failed: 2
Kernel panic - not syncing: Attempted to kill init!

I'm not able to figure out what is causing this panic. I'm running 
Fedora Core 3 on a Dell Optiplex GX280 with 2 sata disks in Raid0.

All Fedora kernels and vanilla up to 2.6.11 is working fine without 
using acpi=off. 2.6.12-rc1 and up to 2.6.13-rc1-mm1 won't boot unless I 
use acpi=off. I haven't been able to do much troubleshooting yet so I 
may be overlooking something trivial. Any kind of help appreciated.


Daniel Andersen
-- 
