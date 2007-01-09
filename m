Return-Path: <linux-kernel-owner+w=401wt.eu-S1751089AbXAIFu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbXAIFu7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 00:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbXAIFu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 00:50:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4451 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751089AbXAIFu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 00:50:58 -0500
Date: Tue, 9 Jan 2007 06:51:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sami Farin <7atbggg02@sneakemail.com>, David Chinner <dgc@sgi.com>,
       xfs-masters@oss.sgi.com, Pavel Machek <pavel@ucw.cz>,
       Marcel Holtmann <marcel@holtmann.org>,
       bluez-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       Komuro <komurojun-mbn@nifty.com>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       Craig Schlenter <craig@codefountain.com>,
       Peter Osterlund <petero2@telia.com>, Patrick McHardy <kaber@trash.net>,
       netfilter-devel@lists.netfilter.org, Michael Reske <micha@gmx.com>,
       Ayaz Abdulla <aabdulla@nvidia.com>, jgarzik@pobox.com,
       Brice Goglin <brice@myri.com>, Robert Hancock <hancockr@shaw.ca>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: 2.6.20-rc4: known regressions with patches (v2)
Message-ID: <20070109055101.GH25007@stusta.de>
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


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
References : http://lkml.org/lkml/2007/1/5/308
Submitter  : Sami Farin <7atbggg02@sneakemail.com>
Handled-By : David Chinner <dgc@sgi.com>
Patch      : http://lkml.org/lkml/2007/1/7/201
Status     : patch available


Subject    : bluetooth oopses because of multiple kobject_add()
References : http://lkml.org/lkml/2007/1/2/101
Submitter  : Pavel Machek <pavel@ucw.cz>
Handled-By : Marcel Holtmann <marcel@holtmann.org>
Patch      : http://lkml.org/lkml/2007/1/2/147
Status     : patch available


Subject    : ftp: get or put stops during file-transfer
References : http://lkml.org/lkml/2006/12/16/174
Submitter  : Komuro <komurojun-mbn@nifty.com>
Caused-By  : YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
             commit cfb6eeb4c860592edd123fdea908d23c6ad1c7dc
Handled-By : Craig Schlenter <craig@codefountain.com>
             YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Patch      : http://lkml.org/lkml/2007/1/9/5
Status     : patch available


Subject    : nf_conntrack_netbios_ns.c causes Oops
References : http://lkml.org/lkml/2007/1/7/188
Submitter  : Peter Osterlund <petero2@telia.com>
Caused-By  : Patrick McHardy <kaber@trash.net>
             commit 92703eee4ccde3c55ee067a89c373e8a51a8adf9
Handled-By : Patrick McHardy <kaber@trash.net>
Patch      : http://lkml.org/lkml/2007/1/8/290
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
