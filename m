Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVHHVFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVHHVFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVHHVFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:05:14 -0400
Received: from palrel13.hp.com ([156.153.255.238]:2716 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S932230AbVHHVFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:05:13 -0400
Date: Mon, 8 Aug 2005 14:02:31 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfctr-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: new perfmon2 kernel patch available
Message-ID: <20050808210230.GA13092@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released a new version of the perfmon2  kernel patch
along with a new version of the libpfm user library.

The kernel patch is relative to 2.6.13-rc4-mm1. You need to
apply Andrew Morton's -mm1 to rc4.

This new release includes:
	- update to newer kernel
	- code  reformatting to fit kernel coding style
	- switch from single system call to multi syscalls
	- some more cleanups of macros vs. inline

The patch has been tested on IA-64, Pentium M (with Local APIC)
and X86-64. I have updated the PPC64 but could not test it.

The new version of libpfm is required to exploit the new multi
system call interface. Older versions (incl. 3.2-050701) will
not work. Note that on IA-64, older applications using the
single syscall interface are still supported. At this point,
I have not yet updated the specification document to reflect
the switch to multiple system calls.


You can download the two packages from our new SourceForget.net
project site (still under construction). The new kernel
patch and libpfm are dated 050805.

		http://www.sf.net/projects/perfmon2

Comments welcome.

-- 
-Stephane
