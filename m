Return-Path: <linux-kernel-owner+w=401wt.eu-S932915AbXABTYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915AbXABTYs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932919AbXABTYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:24:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2401 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932915AbXABTYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:24:47 -0500
Date: Tue, 2 Jan 2007 20:24:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Robert Hancock <hancockr@shaw.ca>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@osdl.org,
       Jean Delvare <khali@linux-fr.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Marcel Holtmann <marcel@holtmann.org>,
       bluez-devel@lists.sourceforge.net, Rene Herman <rene.herman@gmail.com>,
       Mark Lord <lkml@rtr.ca>, Jens Axboe <jens.axboe@oracle.com>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Christoph Hellwig <hch@lst.de>, petero2@telia.com
Subject: 2.6.20-rc3: known regressions with patches available (part 1)
Message-ID: <20070102192449.GV20714@stusta.de>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc3 compared to 2.6.19
with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : suspend to disk no longer works
References : http://lkml.org/lkml/2007/1/1/72
             http://lkml.org/lkml/2006/12/31/13
Submitter  : Andrey Borzenkov <arvidjaar@mail.ru>
             Robert Hancock <hancockr@shaw.ca>
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
Patch      : http://lkml.org/lkml/2007/1/1/117
Status     : patch available


Subject    : "i386: Relocatable kernel support" causes instant reboot
References : http://lkml.org/lkml/2006/12/20/114
Submitter  : Jean Delvare <khali@linux-fr.org>
Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
             commit 968de4f02621db35b8ae5239c8cfc6664fb872d8
Handled-By : Vivek Goyal <vgoyal@in.ibm.com>
Patch      : http://lkml.org/lkml/2007/1/2/9
Status     : patch available


Subject    : bluetooth oopses because of multiple kobject_add()
References : http://lkml.org/lkml/2007/1/2/101
Submitter  : Pavel Machek <pavel@ucw.cz>
Handled-By : Marcel Holtmann <marcel@holtmann.org>
Patch      : http://lkml.org/lkml/2007/1/2/147
Status     : patch available


Subject    : CFQ disk throughput halved
References : http://lkml.org/lkml/2007/01/1/104
Submitter  : Rene Herman <rene.herman@gmail.com>
             Mark Lord <lkml@rtr.ca>
Caused-By  : Jens Axboe <jens.axboe@oracle.com>
             commit 719d34027e1a186e46a3952e8a24bf91ecc33837
Handled-By : Jens Axboe <jens.axboe@oracle.com>
Patch      : http://lkml.org/lkml/2007/1/2/75
Status     : patch available


Subject    : BUG at drivers/scsi/scsi_lib.c:1118 by "pktsetup dvd /dev/sr0"
References : http://bugzilla.kernel.org/show_bug.cgi?id=7667
Submitter  : Laurent Riffard <laurent.riffard@free.fr>
Caused-By  : Christoph Hellwig <hch@lst.de>
             commit 3b00315799d78f76531b71435fbc2643cd71ae4c
Handled-By : Christoph Hellwig <hch@lst.de>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7667
Status     : patch available
