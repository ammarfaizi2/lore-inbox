Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315608AbSECIwn>; Fri, 3 May 2002 04:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315609AbSECIwm>; Fri, 3 May 2002 04:52:42 -0400
Received: from zok.SGI.COM ([204.94.215.101]:36305 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315608AbSECIwm>;
	Fri, 3 May 2002 04:52:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Nick Sanders <sandersn@btinternet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.3 is available 
In-Reply-To: Your message of "Fri, 03 May 2002 18:38:05 +1000."
             <9549.1020415085@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 18:51:30 +1000
Message-ID: <9771.1020415890@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 May 2002 18:38:05 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>On Thu, 2 May 2002 17:45:19 +0100, 
>Nick Sanders <sandersn@btinternet.com> wrote:
>>I'm having problems installing a kernel built with kbuild-2.5 (Release 2.3), the kernel compiled fine its just the install step.
>
>Silly error in arch/i386/Makefile.defs.*config.
>
>cd $KBUILD_SRCTREE_000
>perl -i -ple 's/\(CC\)/(CC_REAL)/g' arch/i386/Makefile.defs.*config

Sigh.  Silly error in the fix :(

cd $KBUILD_SRCTREE_000
perl -i -ple 's/\(CC\)/(CC_real)/g;' arch/i386/Makefile.defs.*config

