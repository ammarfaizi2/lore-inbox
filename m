Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315727AbSEILpx>; Thu, 9 May 2002 07:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315737AbSEILpw>; Thu, 9 May 2002 07:45:52 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:47371 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315727AbSEILpv>;
	Thu, 9 May 2002 07:45:51 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.4 is available 
In-Reply-To: Your message of "Sat, 04 May 2002 23:01:17 +1000."
             <24512.1020517277@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 21:45:39 +1000
Message-ID: <19760.1020944739@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 May 2002 23:01:17 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>Release 2.4 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
>release 2.4.

Extra architecture support added to release 2.4:

  kbuild-2.5-ppc-2.5.14-1.bz2 from Paul Mackerras
  kbuild-2.5-sparc64-2.5.14-1.bz2 from Tom Duffy
  kbuild-2.5-sh-2.5.12-1.bz2 from Greg Banks

  Read the start of each patch for special instructions.

kbuild-2.5-core-12.bz2 added to release 2.4

  Changes from core-11.

    Verify that KBUILD_OBJTREE points to an objtree directory during
    make clean/mrproper.  Old object trees will get a warning,
      echo "must not be empty" > $KBUILD_OBJTREE/_objtree
    to mark old objtrees, only needed once.

    Change message when switching from normal mode to NO_MAKEFILE_GEN
    mode, document why the switch requires additional processing.

    Fix standardization of file names in commands.

    pp_ programs are compiled with -O2 -NDEBUG=1.

    Tune database layout to improve speed, especially for small builds.
    The new database format requires and will force a complete rebuild.

