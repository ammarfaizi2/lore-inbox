Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSENFoY>; Tue, 14 May 2002 01:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315206AbSENFoX>; Tue, 14 May 2002 01:44:23 -0400
Received: from zok.SGI.COM ([204.94.215.101]:65479 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315200AbSENFoX>;
	Tue, 14 May 2002 01:44:23 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.4 is available 
In-Reply-To: Your message of "Sat, 11 May 2002 19:32:19 +1000."
             <6624.1021109539@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 May 2002 15:44:02 +1000
Message-ID: <7875.1021355042@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 May 2002 00:19:10 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>Release 2.4 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
>release 2.4.

kbuild-2.5-core-14
  Changes from core-13.

    Correct typo in safety check for make clean/mrproper.

    Add sys/time.h to pp_makefile5, not all libraries include
    sys/time.h from time.h.

kbuild-2.5-common-2.5.15-3
  Changes from common-2.5.15-2.

    Revert cp -fa to cp for modules_install.  Modules install as root,
    not builder.

    Tweak aic7xxx dependencies.

    Makefile.in changes fr9om s390 group.

kbuild-2.5-sparc64-2.5.15-1 (new)
kbuild-2.5-s390-2.5.15-1 (new)
kbuild-2.5-s390x-2.5.15-1 (new)
kbuild-2.5-ppc-2.5.14-1 (new)

Greg Banks reports that SuperH is up to 2.5.13 and the existing
kbuild-2.5-sh-2.5.12-1 patch will work on 2.5.13.
