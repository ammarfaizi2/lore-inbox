Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945931AbWJaT47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945931AbWJaT47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945934AbWJaT47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:56:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35856 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945931AbWJaT45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:56:57 -0500
Date: Tue, 31 Oct 2006 20:56:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Chua <jeff.chua.linux@gmail.com>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net, ak@suse.de, discuss@x86-64.org,
       Martin Lorenz <martin@lorenz.eu.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Hugh Dickins <hugh@veritas.com>, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org,
       Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>, Christian <christiand59@web.de>,
       davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk,
       Komuro <komurojun-mbn@nifty.com>, Thomas Gleixner <tglx@linutronix.de>,
       Randy Dunlap <randy.dunlap@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
       David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.6.19-rc4: known unfixed regressions
Message-ID: <20061031195654.GV27968@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : PCI: MMCONFIG breakage
References : http://lkml.org/lkml/2006/10/27/251
Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
Status     : unknown, both BIOS and Direct work


Subject    : x86_64: oprofile doesn't work
References : http://lkml.org/lkml/2006/10/27/3
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : unknown


Subject    : T43p/T60/X60s: lose ACPI events after suspend/resume
References : http://lkml.org/lkml/2006/10/10/39
             http://lkml.org/lkml/2006/10/4/425
             http://lkml.org/lkml/2006/10/16/262
             http://bugzilla.kernel.org/show_bug.cgi?id=7408
             http://lkml.org/lkml/2006/10/30/251
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
             "Michael S. Tsirkin" <mst@mellanox.co.il>
             Hugh Dickins <hugh@veritas.com>
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : unable to rip cd
References : http://lkml.org/lkml/2006/10/13/100
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Status     : unknown


Subject    : cpufreq not working on AMD K8
References : http://lkml.org/lkml/2006/10/10/114
Submitter  : Christian <christiand59@web.de>
Status     : unknown


Subject    : SMP kernel can not generate ISA irq properly
References : http://lkml.org/lkml/2006/10/22/15
Submitter  : Komuro <komurojun-mbn@nifty.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : Thomas will investigate


Subject    : USB net drivers: missing MII select's
References : http://lkml.org/lkml/2006/10/25/209
Submitter  : Randy Dunlap <randy.dunlap@oracle.com>
Caused-By  : Arnd Bergmann <arnd@arndb.de>
             commit c41286fd42f3545513f8de9f61028120b6d38e89
Handled-By : Randy Dunlap <randy.dunlap@oracle.com>
             David Brownell <david-b@pacbell.net>
Status     : patches are being discussed


