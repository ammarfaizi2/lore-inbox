Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281546AbRKMH2Q>; Tue, 13 Nov 2001 02:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281417AbRKMH2G>; Tue, 13 Nov 2001 02:28:06 -0500
Received: from zok.SGI.COM ([204.94.215.101]:49114 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281416AbRKMH1y>;
	Tue, 13 Nov 2001 02:27:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.6 is available 
In-Reply-To: Your message of "Fri, 09 Nov 2001 01:34:11 +1100."
             <21560.1005230051@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Nov 2001 18:27:42 +1100
Message-ID: <13361.1005636462@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Release 1.6 of kernel build for kernel 2.5 (kbuild 2.5) has been
>released.  http://sourceforge.net/projects/kbuild/, Package kbuild-2.5,
>download release 1.6.

There is now a patch from kbuild 2.5 2.4.14 to kbuild 2.5 2.4.15-pre4,
under release 1.6.  Or there will be once it propagates through
sourceforge.

Apply in this order:

  Pristine 2.4.14 kernel
  kbuild 2.5 2.4.14-1 patch
  Linus's patch-2.4.15-pre4
  kbuild 2.5 2.4.15-pre4-2 patch (2.4.15-pre4-1 was incorrect)

