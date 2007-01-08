Return-Path: <linux-kernel-owner+w=401wt.eu-S965271AbXAHAZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965271AbXAHAZx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 19:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbXAHAZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 19:25:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2909 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965271AbXAHAZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 19:25:51 -0500
Date: Mon, 8 Jan 2007 01:25:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
       bluez-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       Michael Reske <micha@gmx.com>, Ayaz Abdulla <aabdulla@nvidia.com>,
       jgarzik@pobox.com, Brice Goglin <brice@myri.com>,
       Robert Hancock <hancockr@shaw.ca>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: 2.6.20-rc4: known regressions with patches available
Message-ID: <20070108002555.GP20714@stusta.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc4 compared to 2.6.19
with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : bluetooth oopses because of multiple kobject_add()
References : http://lkml.org/lkml/2007/1/2/101
Submitter  : Pavel Machek <pavel@ucw.cz>
Handled-By : Marcel Holtmann <marcel@holtmann.org>
Patch      : http://lkml.org/lkml/2007/1/2/147
Status     : patch available


Subject    : forcedeth.c 0.59: problem with sideband managment
References : http://bugzilla.kernel.org/show_bug.cgi?id=7684
Submitter  : Michael Reske <micha@gmx.com>
Handled-By : Ayaz Abdulla <aabdulla@nvidia.com>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7684
Status     : patch available


Subject    : nVidia CK804 chipset: not detecting HT MSI capabilities
References : http://lkml.org/lkml/2007/1/5/215
Submitter  : Brice Goglin <brice@myri.com>
             Robert Hancock <hancockr@shaw.ca>
Handled-By : Brice Goglin <brice@myri.com>
Patch      : http://lkml.org/lkml/2007/1/5/215
Status     : patch available
