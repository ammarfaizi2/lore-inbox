Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315615AbSECJRU>; Fri, 3 May 2002 05:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315616AbSECJRT>; Fri, 3 May 2002 05:17:19 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:31974 "EHLO
	protactinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S315615AbSECJRS>; Fri, 3 May 2002 05:17:18 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: Announce: Kernel Build for 2.5, Release 2.3 is available
Date: Fri, 3 May 2002 10:18:47 +0100
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9771.1020415890@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200205031018.47907.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 May 2002 9:51 am, Keith Owens wrote:
> On Fri, 03 May 2002 18:38:05 +1000,
>
> Keith Owens <kaos@ocs.com.au> wrote:
> >On Thu, 2 May 2002 17:45:19 +0100,
> >
> >Nick Sanders <sandersn@btinternet.com> wrote:
> >>I'm having problems installing a kernel built with kbuild-2.5 (Release
> >> 2.3), the kernel compiled fine its just the install step.
> >
> >Silly error in arch/i386/Makefile.defs.*config.
> >
> >cd $KBUILD_SRCTREE_000
> >perl -i -ple 's/\(CC\)/(CC_REAL)/g' arch/i386/Makefile.defs.*config
>
> Sigh.  Silly error in the fix :(
>
> cd $KBUILD_SRCTREE_000
> perl -i -ple 's/\(CC\)/(CC_real)/g;' arch/i386/Makefile.defs.*config

The 1st fix worked fine for me, thanks

