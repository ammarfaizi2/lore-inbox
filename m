Return-Path: <linux-kernel-owner+w=401wt.eu-S932545AbXARTr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbXARTr4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 14:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbXARTrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 14:47:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3275 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932545AbXARTrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 14:47:53 -0500
Date: Thu, 18 Jan 2007 20:47:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Randy Dunlap <rdunlap@xenotime.net>, sct@redhat.com,
       adilger@clusterfs.com, linux-ext4@vger.kernel.org,
       Berthold Cogel <cogel@rrz.uni-koeln.de>,
       =?iso-8859-1?Q?Fran=E7ois?= Valenduc 
	<francois.valenduc@skynet.be>,
       Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       Prakash Punnoor <prakash@punnoor.de>, Oliver Neukum <oliver@neukum.org>,
       Duncan <1i5t5.duncan@cox.net>, mingo@redhat.com, neilb@cse.unsw.edu.au,
       linux-raid@vger.kernel.org, gd@spherenet.de, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, petero2@telia.com,
       Uwe Bugla <uwe.bugla@gmx.de>, B.Zolnierkiewicz@elka.pw.edu.pl,
       =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Robert Hancock <hancockr@shaw.ca>
Subject: 2.6.20-rc5: knwon unfixed regressions (v2) (part1)
Message-ID: <20070118194756.GA9093@stusta.de>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : ext3 with data=journal hangs when running fsx-linux since -rc2
References : http://bugzilla.kernel.org/show_bug.cgi?id=7844
Submitter  : Randy Dunlap <rdunlap@xenotime.net>
Status     : unknown


Subject    : reboot instead of powerdown  (CONFIG_USB_SUSPEND)
References : http://lkml.org/lkml/2006/12/25/40
             http://bugzilla.kernel.org/show_bug.cgi?id=7828
Submitter  : Berthold Cogel <cogel@rrz.uni-koeln.de>
             François Valenduc <francois.valenduc@skynet.be>
Handled-By : Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Status     : problem is being debugged


Subject    : usb somehow broken  (CONFIG_USB_SUSPEND)
References : http://lkml.org/lkml/2007/1/11/146
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Handled-By : Oliver Neukum <oliver@neukum.org>
Status     : problem is being debugged


Subject    : RAID-6 chunk_aligned_read problem
References : http://bugzilla.kernel.org/show_bug.cgi?id=7835
Submitter  : Duncan <1i5t5.duncan@cox.net>
Status     : unknown


Subject    : pktcdvd fails with pata_amd
References : http://bugzilla.kernel.org/show_bug.cgi?id=7810
Submitter  : gd@spherenet.de
Status     : unknown


Subject    : problems with CD burning
References : http://www.spinics.net/lists/linux-ide/msg06545.html
Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
Status     : unknown


Subject    : sata_nv: SATA exceptions
References : http://lkml.org/lkml/2007/1/14/108
Submitter  : Björn Steinbrink <B.Steinbrink@gmx.de>
Caused-By  : Robert Hancock <hancockr@shaw.ca>
             commit 2dec7555e6bf2772749113ea0ad454fcdb8cf861
Handled-By : Robert Hancock <hancockr@shaw.ca>
Status     : problem is being debugged


