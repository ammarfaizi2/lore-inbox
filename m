Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263803AbVBDTpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbVBDTpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbVBDTpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:45:11 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:52490 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S266473AbVBDTn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:43:56 -0500
Date: Fri, 4 Feb 2005 20:43:45 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Gary Smith <linuxkernel@adndrealm.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Post install 2.4.29 causes many apps to seg fault.
Message-ID: <20050204194345.GB5935@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <1107544219.4203c89bdfa6a@www.adndrealm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107544219.4203c89bdfa6a@www.adndrealm.net>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gary Smith <linuxkernel@adndrealm.net>
Date: Fri, Feb 04, 2005 at 11:10:19AM -0800
> Hello, 
> 
> I have been running RHEL3 update 3 for some time and need to patch netfilter 
> for PPTP.  After doing so and installing the kernel I found that certain 
> applications (such as MySQL, nslook, etc) began to segfault.  Rolling the 
> kernel back fixed the problem.
> 
> I have since then gone back and recompiled the vanilla 2.4.29 kernel (without 
> additing any patches this time - clean from tarball) and installed it and all 
> of the the applications that failed on the custom kernel (with the PPTP 
> patches) continue to fail (clean box as well).
> 
> Is there something more that I need to compile besides the kernel for 
> compatability or is this a sign of some type of bug.  I do realize that RHEL3 
> itself has some proprietary items added to their kernel but replacing it 
> shouldn't make other applications fails.
> 
> Any assistance would be greatly appreciated.
> 
If lots of things fail in strange places, I would wonder if your glibc
is compatible with your kernel. I suggest you take it up on a redhat
mailinglist.

Good luck,
Jurriaan
-- 
Maybe I shall start calling my tricorder Sally
	DS9 - Miles O'Brien
Debian (Unstable) GNU/Linux 2.6.10-mm1 2x6078 bogomips load 0.45
