Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSD0IqD>; Sat, 27 Apr 2002 04:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSD0IqC>; Sat, 27 Apr 2002 04:46:02 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:58634 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S290797AbSD0IqC>;
	Sat, 27 Apr 2002 04:46:02 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.2 is available 
In-Reply-To: Your message of "Fri, 26 Apr 2002 14:42:28 +1000."
             <10571.1019796148@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 27 Apr 2002 18:45:48 +1000
Message-ID: <21140.1019897148@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Release 2.2 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
>release 2.2.

IA64 support for 2.5.10-ia64-020426 is now available.

Sebastian Droege spotted an error in the common patch, common-2
corrects zlib de/inflate options.

Because ia64 has a pathological case of recursive includes (you cannot
calculate the value of IA64_TASK_SIZE unless you already have a value
for IA64_TASK_SIZE), I had to kludge the calculation of asm-offsets.h
for ia64.  That required a small change to the core code to support the
kludge.

New files.

   kbuild-2.5-ia64-2.5.10-020426-1.bz2
   kbuild-2.5-common-2.5.10-2.bz2
   kbuild-2.5-core-8.bz2

