Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVC2CjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVC2CjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVC2CjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:39:07 -0500
Received: from everest.2mbit.com ([24.123.221.2]:42424 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S262157AbVC2CjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:39:00 -0500
Message-ID: <4248BF80.7090805@lovecn.org>
Date: Tue, 29 Mar 2005 10:37:52 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Greg KH <greg@kroah.com>, Mark Fortescue <mark@mtfhpc.demon.co.uk>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>	 <20050326182828.GA8540@kroah.com> <1111869274.32641.0.camel@mindpipe>
In-Reply-To: <1111869274.32641.0.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Broken-Reverse-DNS: no host name for for IP address 218.24.178.157
X-Scan-Signature: 2ecaae6c9cc520cc6f18c499896ec795
X-SA-Exim-Connect-IP: 218.24.178.157
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  4.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.178.157 listed in cnkrbl.ahbl.org]
	*  0.7 PLING_PLING Subject has lots of exclamation marks
X-SA-Exim-Version: 4.2 (built Sun, 13 Feb 2005 18:23:43 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2005-03-26 at 10:28 -0800, Greg KH wrote:
> 
>>On Sat, Mar 26, 2005 at 05:52:20PM +0000, Mark Fortescue wrote:
>>
>>>I am writing a "Proprietry" driver module for a "Proprietry" PCI card and
>>>I have found that I can't use SYSFS on Linux-2.6.10.
>>>
>>>Why ?. 
>>
>>What ever gave you the impression that it was legal to create a
>>"Proprietry" kernel driver for Linux in the first place.
> 
> 
> The fact that Nvidia and ATI get away with it?

I have the nvidia GeForce4 driver: NVIDIA-Linux-x86-1.0-6629-pkg1.

$ ls NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/
Makefile@            makedevices.sh*  nv-vm.c  nv_compiler.h  os-agp.c        os-registry.c
Makefile.kbuild      makefile         nv-vm.h  nvidia.ko      os-agp.h        os-registry.o
Makefile.nvidia      nv-kernel.o      nv-vm.o  nvidia.mod.c   os-agp.o        pat.h
README               nv-linux.h       nv.c     nvidia.mod.o   os-interface.c  precompiled/
conftest.sh          nv-memdbg.h      nv.h     nvidia.o       os-interface.h  rmretval.h
gcc-version-check.c  nv-misc.h        nv.o     nvtypes.h      os-interface.o


So it seems nvidia has their kernel module `open'. Is it?


	Coywolf
