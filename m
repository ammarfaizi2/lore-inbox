Return-Path: <linux-kernel-owner+w=401wt.eu-S1161300AbXAMHOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161300AbXAMHOK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 02:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161301AbXAMHOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 02:14:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2940 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161300AbXAMHOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 02:14:07 -0500
Date: Sat, 13 Jan 2007 08:14:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Miles Lane <miles.lane@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       avi@qumranet.com, kvm-devel@lists.sourceforge.net,
       Roland Dreier <rdreier@cisco.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, vojtech@suse.cz,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net
Subject: 2.6.20-rc5: known regressions with patches
Message-ID: <20070113071412.GH7469@stusta.de>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19
with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


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


