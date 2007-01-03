Return-Path: <linux-kernel-owner+w=401wt.eu-S932119AbXACVD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbXACVD7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbXACVD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:03:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4784 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932119AbXACVD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:03:58 -0500
Date: Wed, 3 Jan 2007 22:04:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Robert Hancock <hancockr@shaw.ca>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@osdl.org,
       Laurent Riffard <laurent.riffard@free.fr>,
       Christoph Hellwig <hch@lst.de>, petero2@telia.com,
       Michael Reske <micha@gmx.com>, Ayaz Abdulla <aabdulla@nvidia.com>,
       jgarzik@pobox.com, netdev@vger.kernel.org,
       Marcel Holtmann <marcel@holtmann.org>,
       bluez-devel@lists.sourceforge.net,
       Ben Castricum <mail0612@bencastricum.nl>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: 2.6.20-rc3: known regressions with patches (v2)
Message-ID: <20070103210400.GL20714@stusta.de>
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


Subject    : BUG at drivers/scsi/scsi_lib.c:1118 by "pktsetup dvd /dev/sr0"
References : http://bugzilla.kernel.org/show_bug.cgi?id=7667
Submitter  : Laurent Riffard <laurent.riffard@free.fr>
Caused-By  : Christoph Hellwig <hch@lst.de>
             commit 3b00315799d78f76531b71435fbc2643cd71ae4c
Handled-By : Christoph Hellwig <hch@lst.de>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7667
Status     : patch available


Subject    : forcedeth.c 0.59: problem with sideband managment
References : http://bugzilla.kernel.org/show_bug.cgi?id=7684
Submitter  : Michael Reske <micha@gmx.com>
Handled-By : Ayaz Abdulla <aabdulla@nvidia.com>
Status     : patch available


Subject    : bluetooth oopses because of multiple kobject_add()
References : http://lkml.org/lkml/2007/1/2/101
Submitter  : Pavel Machek <pavel@ucw.cz>
Handled-By : Marcel Holtmann <marcel@holtmann.org>
Patch      : http://lkml.org/lkml/2007/1/2/147
Status     : patch available


Subject    : PCI_MULTITHREAD_PROBE breakage
References : http://lkml.org/lkml/2006/12/12/21
Submitter  : Ben Castricum <mail0612@bencastricum.nl>
Caused-By  : Greg Kroah-Hartman <gregkh@suse.de>
             commit 009af1ff78bfc30b9a27807dd0207fc32848218a
Handled-By : Greg Kroah-Hartman <gregkh@suse.de>
Status     : patch available
