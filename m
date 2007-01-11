Return-Path: <linux-kernel-owner+w=401wt.eu-S965237AbXAKFKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbXAKFKW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 00:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbXAKFKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 00:10:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3442 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965237AbXAKFKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 00:10:20 -0500
Date: Thu, 11 Jan 2007 06:10:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@gmail.com>, Damien Wyart <damien.wyart@free.fr>,
       Aaron Sethman <androsyn@ratbox.org>, alan@lxorguk.ukuu.org.uk,
       linux-ide@vger.kernel.org, Uwe Bugla <uwe.bugla@gmx.de>,
       Berthold Cogel <cogel@rrz.uni-koeln.de>,
       Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       Florin Iucha <florin@iucha.net>, Jiri Kosina <jkosina@suse.cz>,
       Alan Stern <stern@rowland.harvard.edu>, dmitry.torokhov@gmail.com,
       linux-input@atrey.karlin.mff.cuni.cz,
       Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>,
       John McCutchan <john@johnmccutchan.com>, rml@novell.com
Subject: 2.6.20-rc4: known unfixed regressions (v3)
Message-ID: <20070111051022.GA21724@stusta.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc4 compared to 2.6.19
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : BUG: scheduling while atomic: hald-addon-stor/...
             cdrom_{open,release,ioctl} in trace
References : http://lkml.org/lkml/2006/12/26/105
             http://lkml.org/lkml/2006/12/29/22
             http://lkml.org/lkml/2006/12/31/133
Submitter  : Jon Smirl <jonsmirl@gmail.com>
             Damien Wyart <damien.wyart@free.fr>
             Aaron Sethman <androsyn@ratbox.org>
Status     : unknown


Subject    : problems with CD burning
References : http://www.spinics.net/lists/linux-ide/msg06545.html
Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
Status     : unknown


Subject    : 'shutdown -h now' reboots the system  (CONFIG_USB_SUSPEND)
References : http://lkml.org/lkml/2006/12/25/40
Submitter  : Berthold Cogel <cogel@rrz.uni-koeln.de>
Handled-By : Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Status     : problem is being debugged


Subject    : USB keyboard unresponsive after some time
References : http://lkml.org/lkml/2006/12/25/35
             http://lkml.org/lkml/2006/12/26/106
Submitter  : Florin Iucha <florin@iucha.net>
Handled-By : Jiri Kosina <jkosina@suse.cz>
             Alan Stern <stern@rowland.harvard.edu>
Status     : problem is being debugged


Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
Handled-By : John McCutchan <john@johnmccutchan.com>
Status     : problem is being debugged


