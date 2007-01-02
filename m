Return-Path: <linux-kernel-owner+w=401wt.eu-S1754929AbXABTQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbXABTQI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbXABTQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:16:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2349 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754929AbXABTQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:16:04 -0500
Date: Tue, 2 Jan 2007 20:16:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Steve Youngs <steve@youngs.au.com>,
       Berthold Cogel <cogel@rrz.uni-koeln.de>, len.brown@intel.com,
       linux-acpi@vger.kernel.org, Florin Iucha <florin@iucha.net>,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz,
       Jon Smirl <jonsmirl@gmail.com>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, davem@davemloft.net,
       sparclinux@vger.kernel.org, Komuro <komurojun-mbn@nifty.com>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
       Michael Reske <micha@gmx.com>, Ayaz Abdulla <aabdulla@nvidia.com>,
       Jeff Garzik <jeff@garzik.org>,
       Tobias Diedrich <ranma+kernel@tdiedrich.de>, Andi Kleen <ak@suse.de>,
       Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, discuss@x86-64.org
Subject: 2.6.20-rc3: known unfixed regressions
Message-ID: <20070102191606.GU20714@stusta.de>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc3 compared to 2.6.19
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : kernel immediately reboots
References : http://lkml.org/lkml/2007/1/2/15
Submitter  : Steve Youngs <steve@youngs.au.com>
Status     : unknown


Subject    : Acer Extensa 3002 WLMi: 'shutdown -h now' reboots the system
References : http://lkml.org/lkml/2006/12/25/40
Submitter  : Berthold Cogel <cogel@rrz.uni-koeln.de>
Status     : unknown


Subject    : USB keyboard unresponsive after some time
References : http://lkml.org/lkml/2006/12/25/35
             http://lkml.org/lkml/2006/12/26/106
Submitter  : Florin Iucha <florin@iucha.net>
Status     : unknown


Subject    : BUG: scheduling while atomic
References : http://lkml.org/lkml/2006/12/26/105
Submitter  : Jon Smirl <jonsmirl@gmail.com>
Status     : unknown


Subject    : SPARC64: Can't mount /
References : http://lkml.org/lkml/2006/12/13/181
Submitter  : Horst H. von Brand <vonbrand@inf.utfsm.cl>
Status     : unknown


Subject    : ftp: get or put stops during file-transfer
References : http://lkml.org/lkml/2006/12/16/174
Submitter  : Komuro <komurojun-mbn@nifty.com>
Caused-By  : YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
             commit cfb6eeb4c860592edd123fdea908d23c6ad1c7dc
Handled-By : YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Status     : problem is being debugged


Subject    : forcedeth.c 0.59: problem with sideband managment
References : http://bugzilla.kernel.org/show_bug.cgi?id=7684
Submitter  : Michael Reske <micha@gmx.com>
Handled-By : Ayaz Abdulla <aabdulla@nvidia.com>
Status     : problem is being debugged


Subject    : x86_64 boot failure: "IO-APIC + timer doesn't work"
References : http://lkml.org/lkml/2006/12/16/101
Submitter  : Tobias Diedrich <ranma+kernel@tdiedrich.de>
Caused-By  : Andi Kleen <ak@suse.de>
             commit b026872601976f666bae77b609dc490d1834bf77
Handled-By : Yinghai Lu <yinghai.lu@amd.com>
             Eric W. Biederman <ebiederm@xmission.com>
Status     : problem is being debugged


