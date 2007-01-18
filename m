Return-Path: <linux-kernel-owner+w=401wt.eu-S932446AbXART7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbXART7N (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 14:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXART7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 14:59:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3368 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932446AbXART7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 14:59:10 -0500
Date: Thu, 18 Jan 2007 20:59:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Gernoth <gernoth@informatik.uni-erlangen.de>,
       Daniel Drake <dsd@gentoo.org>, David L Stevens <dlstevens@us.ibm.com>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       len.brown@intel.com, linux-acpi@vger.kernel.org,
       cpufreq@lists.linux.org.uk, Russell King <rmk+lkml@arm.linux.org.uk>,
       Al Viro <viro@zeniv.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
       Miles Lane <miles.lane@gmail.com>, avi@qumranet.com,
       kvm-devel@lists.sourceforge.net, Roland Dreier <rdreier@cisco.com>,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net
Subject: 2.6.20-rc5: known regressions with patches (v2)
Message-ID: <20070118195915.GC9093@stusta.de>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19
with patches available

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : does not pickup ipv6 addresses
References : http://bugzilla.kernel.org/show_bug.cgi?id=7817
             http://lkml.org/lkml/2007/1/14/146
Submitter  : Michael Gernoth <gernoth@informatik.uni-erlangen.de>
             Daniel Drake <dsd@gentoo.org>
Caused-By  : David L Stevens <dlstevens@us.ibm.com>
             commit 30c4cf577fb5b68c16e5750d6bdbd7072e42b279
Handled-By : YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7817
Status     : patch available


Subject    : ACPI: fix cpufreq regression
References : http://lkml.org/lkml/2007/1/16/120
Submitter  : Ingo Molnar <mingo@elte.hu>
Caused-By  : Dave Jones <davej@redhat.com>
             commit 0916bd3ebb7cefdd0f432e8491abe24f4b5a101e
Handled-By : Ingo Molnar <mingo@elte.hu>
Patch      : http://lkml.org/lkml/2007/1/16/120
Status     : patch available


Subject    : CONFIG_JFFS2_FS_DEBUG=2 compile error
References : http://lkml.org/lkml/2007/1/12/161
Submitter  : Russell King <rmk+lkml@arm.linux.org.uk>
Caused-By  : Al Viro <viro@zeniv.linux.org.uk>
             commit 914e26379decf1fd984b22e51fd2e4209b7a7f1b
Handled-By : David Woodhouse <dwmw2@infradead.org>
Status     : patch available


Subject    : WARNING: "profile_hits" [drivers/kvm/kvm-intel.ko] undefined!
References : http://lkml.org/lkml/2007/1/12/16
Submitter  : Miles Lane <miles.lane@gmail.com>
Caused-By  : Ingo Molnar <mingo@elte.hu>
             commit 07031e14c1127fc7e1a5b98dfcc59f434e025104
Handled-By : Andrew Morton <akpm@osdl.org>
Patch      : http://lkml.org/lkml/2007/1/12/18
Status     : patch available


Subject    : KVM: guest crash
References : http://lkml.org/lkml/2007/1/8/163
Submitter  : Roland Dreier <rdreier@cisco.com>
Handled-By : Avi Kivity <avi@qumranet.com>
Patch      : http://lkml.org/lkml/2007/1/9/280
Status     : patch available


Subject    : compile error: USB_HID must depend on INPUT
References : http://lkml.org/lkml/2007/1/12/157
Submitter  : Russell King <rmk+lkml@arm.linux.org.uk>
Handled-By : Russell King <rmk+lkml@arm.linux.org.uk>
Patch      : http://lkml.org/lkml/2007/1/12/177
Status     : patch available
