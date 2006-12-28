Return-Path: <linux-kernel-owner+w=401wt.eu-S965018AbWL1Wbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWL1Wbu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWL1Wbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:31:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1472 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965018AbWL1Wbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:31:49 -0500
Date: Thu, 28 Dec 2006 23:31:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, Paul Moore <paul.moore@hp.com>,
       Parag Warudkar <paragw@paragw.zapto.org>, sds@tycho.nsa.gov,
       jmorris@namei.org, Avi Kivity <avi@qumranet.com>,
       kvm-devel@lists.sourceforge.net, Andreas Schwab <schwab@suse.de>,
       Yu Luming <luming.yu@gmail.com>, benh@kernel.crashing.org,
       linuxppc-dev@ozlabs.org, Michael Bommarito <mjbommar@umich.edu>,
       Ben Collins <ben.collins@ubuntu.com>,
       Martin Pitt <martin.pitt@ubuntu.com>,
       Larry Finger <Larry.Finger@lwfinger.net>, linville@tuxdriver.com,
       netdev@vger.kernel.org, Laurent Riffard <laurent.riffard@free.fr>,
       Christoph Hellwig <hch@lst.de>, petero2@telia.com
Subject: 2.6.20-rc2: known regressions with patches available
Message-ID: <20061228223150.GJ20714@stusta.de>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc2 compared to 2.6.19
with patches available

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : selinux networking: sleeping function called from invalid context
References : http://lkml.org/lkml/2006/12/24/78
Submitter  : "Adam J. Richter" <adam@yggdrasil.com>
Caused-By  : Paul Moore <paul.moore@hp.com>
Handled-By : Parag Warudkar <paragw@paragw.zapto.org>
Patch      : http://lkml.org/lkml/2006/12/24/89
Status     : patch available


Subject    : KVM Oops
References : http://lkml.org/lkml/2006/12/27/171
Submitter  : Parag Warudkar <kernel-stuff@comcast.net>
Handled-By : Avi Kivity <avi@qumranet.com>
Status     : patch available


Subject    : drivers/macintosh/via-pmu-backlight.c compilation broken
References : http://lkml.org/lkml/2006/12/24/49
Submitter  : Andreas Schwab <schwab@suse.de>
Caused-By  : Yu Luming <luming.yu@gmail.com>
             commit 519ab5f2be65b72cf12ae99c89752bbe79b44df6
Handled-By : Andreas Schwab <schwab@suse.de>
Patch      : http://lkml.org/lkml/2006/12/24/49
Status     : patch available


Subject    : NULL dereference in ieee80211softmac_get_network_by_bssid_locked
             ieee80211softmac_wx.c typo: mutex_lock -> mutex_unlock
References : http://bugzilla.kernel.org/show_bug.cgi?id=7657
             http://lkml.org/lkml/2006/12/16/141
             http://lkml.org/lkml/2006/12/24/43
Submitter  : Michael Bommarito <mjbommar@umich.edu>
             Ben Collins <ben.collins@ubuntu.com>
             Martin Pitt <martin.pitt@ubuntu.com>
Handled-By : Michael Bommarito <mjbommar@umich.edu>
             Larry Finger <Larry.Finger@lwfinger.net
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7657
Status     : patches available


Subject    : BUG at drivers/scsi/scsi_lib.c:1118 by "pktsetup dvd /dev/sr0"
References : http://bugzilla.kernel.org/show_bug.cgi?id=7667
Submitter  : Laurent Riffard <laurent.riffard@free.fr>
Caused-By  : Christoph Hellwig <hch@lst.de>
             commit 3b00315799d78f76531b71435fbc2643cd71ae4c
Handled-By : Christoph Hellwig <hch@lst.de>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7667
Status     : patch available

