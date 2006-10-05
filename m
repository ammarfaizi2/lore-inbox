Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWJEE2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWJEE2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWJEE2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:28:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:785 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750785AbWJEE2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:28:19 -0400
Date: Thu, 5 Oct 2006 06:28:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Klaus Knopper <knopper@knopper.net>, Andi Kleen <ak@suse.de>,
       Luca Tettamanti <kronos.it@gmail.com>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org,
       Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       len.brown@intel.com, linux-acpi@vger.kernel.org,
       Olaf Hering <olaf@aepfle.de>, Jens Axboe <axboe@suse.de>
Subject: 2.6.19-rc1: known regressions
Message-ID: <20061005042816.GD16812@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to popular belief, there are people who test -rc kernels
and report bugs.

And there are even people who test -git kernels.

This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you was declared guilty for a breakage or I'm considering you in any
other way possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : CONFIG_M386=y rwsem compile error
References : http://lkml.org/lkml/2006/10/3/240
Submitter  : Klaus Knopper <knopper@knopper.net>
Guilty     : Andi Kleen <ak@suse.de>
             commit add659bf8aa92f8b3f01a8c0220557c959507fb1
Status     : unknown


Subject    : Lost all PCI devices
References : http://lkml.org/lkml/2006/9/30/128
Submitter  : Luca Tettamanti <kronos.it@gmail.com>
Guilty     : Andi Kleen <ak@suse.de>
             commit 5e544d618f0fb21011f36f28d5e3952b9dc109d2
Handled-By : Andi Kleen <ak@suse.de>
Status     : patch available (might not completely fix the problem?)


Subject    : SMP x86_64 boot problem
References : http://lkml.org/lkml/2006/9/28/330
Submitter  : art@usfltd.com
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : T60 stops triggering any ACPI events
References : http://lkml.org/lkml/2006/10/4/425
Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
Status     : unknown


Subject    : DVD drive lost DVD capabilities
References : http://lkml.org/lkml/2006/10/1/45
Submitter  : Olaf Hering <olaf@aepfle.de>
Guilty     : Jens Axboe <axboe@suse.de>
             commit 4aff5e2333c9a1609662f2091f55c3f6fffdad36
Handled-By : Jens Axboe <axboe@suse.de>
Status     : Jens is working on a fix

