Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316163AbSEOM5P>; Wed, 15 May 2002 08:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316178AbSEOM5O>; Wed, 15 May 2002 08:57:14 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:42359 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316163AbSEOM5N>; Wed, 15 May 2002 08:57:13 -0400
Date: Wed, 15 May 2002 07:57:13 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205151257.HAA75582@tomcat.admin.navo.hpc.mil>
To: ashokr2@attbi.com, <linux-kernel@vger.kernel.org>
Subject: Re: Address space limits in IA32 linux
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ashok Raj" <ashokr2@attbi.com>:
> 
> Hello
> 
> what is the maximum addressible virtual address in a IA32 Linux system (4G?)
> 
> typically since Database requires a larger address space, does linux kernel
> has any config to limit this space for kernel, so that the user process has
> more address to play with?
> 
> thanks
> ashok

Of course - use IA64, Sparc, or PPC.

IA32 is by definition limited to 4G. Just because the Kernel may, under
extreem duress, access more by memory management shenanigans access more,
user processes are ALWAYS limited to a 32 bit virtual address. Even this
is more restricted, since shared libraries and other access limits it even
more. Usually you can stretch it to 3G, but not over that.

search the archives - the details are available.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
