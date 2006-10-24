Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbWJXUVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWJXUVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbWJXUVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:21:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49934 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030452AbWJXUVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:21:07 -0400
Date: Tue, 24 Oct 2006 22:21:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, art@usfltd.com,
       teunis@wintersgift.com, Jiri Slaby <jirislaby@gmail.com>, pavel@suse.cz,
       linux-pm@osdl.org, ak@suse.de, Martin Lorenz <martin@lorenz.eu.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>, Komuro <komurojun-mbn@nifty.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net, Christian <christiand59@web.de>,
       Mark Langsdorf <mark.langsdorf@amd.com>, davej@codemonkey.org.uk,
       cpufreq@lists.linux.org.uk, Stephen Hemminger <shemminger@osdl.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: 2.6.19-rc3: known unfixed regressions
Message-ID: <20061024202104.GF27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known unfixed regressions in 2.6.19-rc3 compared 
to 2.6.18.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : shutdown problem
References : http://lkml.org/lkml/2006/10/22/140
Submitter  : art@usfltd.com
             teunis@wintersgift.com
             Jiri Slaby <jirislaby@gmail.com>
Status     : unknown


Subject    : X60s: BUG()s, lose ACPI events after suspend/resume
References : http://lkml.org/lkml/2006/10/10/39
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : unknown


Subject    : T60 stops triggering any ACPI events
References : http://lkml.org/lkml/2006/10/4/425
             http://lkml.org/lkml/2006/10/16/262
             http://bugzilla.kernel.org/show_bug.cgi?id=7408
Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : unable to rip cd
References : http://lkml.org/lkml/2006/10/13/100
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Status     : unknown


Subject    : SMP kernel can not generate ISA irq properly
References : http://lkml.org/lkml/2006/10/22/15
Submitter  : Komuro <komurojun-mbn@nifty.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : Thomas will investigate


Subject    : ohci1394 on PPC_PMAC:
             pci_set_power_state() failure and breaking suspend
References : http://lkml.org/lkml/2006/10/24/13
Submitter  : Benjamin Herrenschmidt <benh@kernel.crashing.org>
Caused-By  : Stefan Richter <stefanr@s5r6.in-berlin.de>
             commit ea6104c22468239083857fa07425c312b1ecb424
Handled-By : Stefan Richter <stefanr@s5r6.in-berlin.de>
Status     : Stefan Richter: looking for an answer when to ignore
             the return code of pci_set_power_state


Subject    : cpufreq not working on AMD K8
References : http://lkml.org/lkml/2006/10/10/114
Submitter  : Christian <christiand59@web.de>
Handled-By : Mark Langsdorf <mark.langsdorf@amd.com>
Status     : Mark is investigating


Subject    : MSI errors during boot (CONFIG_PCI_MULTITHREAD_PROBE)
References : http://lkml.org/lkml/2006/10/16/291
Submitter  : Stephen Hemminger <shemminger@osdl.org>
Handled-By : Greg KH <greg@kroah.com>
Status     : Greg is working on a fix


