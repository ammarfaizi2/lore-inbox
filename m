Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVHYP1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVHYP1Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVHYP1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:27:24 -0400
Received: from bay14-f14.bay14.hotmail.com ([64.4.49.14]:53023 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932146AbVHYP1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:27:23 -0400
Message-ID: <BAY14-F14EAD811D62D43C1A2CE2FBAAB0@phx.gbl>
X-Originating-IP: [65.202.146.101]
X-Originating-Email: [duquesnay@hotmail.com]
From: "Chris du Quesnay" <duquesnay@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Building the kernel with Cygwin
Date: Thu, 25 Aug 2005 15:27:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 25 Aug 2005 15:27:20.0919 (UTC) FILETIME=[7C31F670:01C5A989]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I am newbie at GNU/linux.

I am trying to build a kernel (2.6.12)  for a powerpc target using cygwin on 
my i686 machine.  I have
Windows 2000 as my operating system.

I have recent versions of cygwin (with GNU make 3.80), binutils for the 
powerpc (gcc v 3.3.1, ld v 2.14)

I set
ARCH=ppc
CROSS_COMPILE= powerpc-ibm-eabi-

and I add the cross compiler/build directory to my path.

After untaring the kernel, I issue the
make mrproper, which appears to work.

Then I issue
make menuconfig

and I get the following error, which I can't seem to get around:

HOSTCC   scripts/basic/fixdep
fixdep: no such file or directory
make[1]:*** [scripts/basic/fixdep] Error 2
make[1] Leaving directory /cygdrive/c/Linux_amcc/linux-2.6.12



Can you suggest what the problem might be?  Should I be able to build the 
kernel
with cygwin?

_________________________________________________________________
Don't just Search. Find! http://search.sympatico.msn.ca/default.aspx The new 
MSN Search! Check it out!

