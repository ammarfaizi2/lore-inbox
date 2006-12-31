Return-Path: <linux-kernel-owner+w=401wt.eu-S932309AbWLaArU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWLaArU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 19:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWLaArU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 19:47:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1441 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932309AbWLaArR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 19:47:17 -0500
Date: Sun, 31 Dec 2006 01:47:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florin Iucha <florin@iucha.net>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com,
       linux-input@atrey.karlin.mff.cuni.cz, Jon Smirl <jonsmirl@gmail.com>,
       Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>, perex@suse.cz,
       alsa-devel@alsa-project.org,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, davem@davemloft.net,
       sparclinux@vger.kernel.org, Komuro <komurojun-mbn@nifty.com>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
       Michael Reske <micha@gmx.com>, Ayaz Abdulla <aabdulla@nvidia.com>,
       Tobias Diedrich <ranma+kernel@tdiedrich.de>, Andi Kleen <ak@suse.de>,
       Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, mingo@redhat.com,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       Berthold Cogel <cogel@rrz.uni-koeln.de>
Subject: 2.6.20-rc2: known unfixed regressions (v2)
Message-ID: <20061231004719.GG20714@stusta.de>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc2 compared to 2.6.19
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : USB keyboard unresponsive after some time
References : http://lkml.org/lkml/2006/12/25/35
             http://lkml.org/lkml/2006/12/26/106
Submitter  : Florin Iucha <florin@iucha.net>
Status     : unknown


Subject    : BUG: scheduling while atomic
References : http://lkml.org/lkml/2006/12/26/105
Submitter  : Jon Smirl <jonsmirl@gmail.com>
Status     : unknown


Subject    : ALSA: No sound in KDE with intel hda
References : http://lkml.org/lkml/2006/12/30/73
Submitter  : Ismail Dönmez <ismail@pardus.org.tr>
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


Subject    : kernel panics on boot (libata-sff)
References : http://lkml.org/lkml/2006/12/3/99
             http://lkml.org/lkml/2006/12/14/153
             http://lkml.org/lkml/2006/12/24/33
Submitter  : Alessandro Suardi <alessandro.suardi@gmail.com>
Caused-By  : Alan Cox <alan@lxorguk.ukuu.org.uk>
             commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
Handled-By : Alan Cox <alan@lxorguk.ukuu.org.uk>
Status     : people are working on a fix


Subject    : Acer Extensa 3002 WLMi: 'shutdown -h now' reboots the system
References : http://lkml.org/lkml/2006/12/25/40
Submitter  : Berthold Cogel <cogel@rrz.uni-koeln.de>
Status     : submitter was asked for more information


