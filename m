Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315466AbSEBX0N>; Thu, 2 May 2002 19:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315467AbSEBX0M>; Thu, 2 May 2002 19:26:12 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:61710 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315466AbSEBX0M>; Thu, 2 May 2002 19:26:12 -0400
Date: Fri, 3 May 2002 01:25:55 +0200
From: tomas szepe <kala@pinerecords.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Keith Owens <kaos@ocs.com.au>, davej@suse.de,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020502232554.GB10617@louise.pinerecords.com>
In-Reply-To: <20020502213443.GA10617@louise.pinerecords.com> <Pine.GSO.4.21.0205021738410.17171-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 10 days, 16:19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > '/usr/include/asm' points to '/usr/src/linux/include/asm', which doesn't
> > exist at this moment. It seems to me that kbuild 2.5 makes the assumption
> > that the 'asm' symlink in /usr/include already determines the machine
> > architecture type by pointing to a concrete asm-$arch
> > in /usr/src/linux/include.
> Sigh...  Configurations with /usr/include/{linux,asm} being symlinks
> are BROKEN.  Please, look through the archives - it had been discussed
> a lot of times.  Userland has no business using kernel headers directly
> and that's precisely what had bitten you - setup where /usr/include/asm
> comes not from libc but from the (currently being built) kernel.

My apologies then... Actually, this is how Slackware-8.0 came (and
slackware-current AFAIK still comes). Apparently I must've missed
the transition, and so has Patrick Volkerding.

Also I'm sorry for bringing up the MODVERSIONS issue. If I had known
what flamewar it would trigger, I'd never have raised the topic. *sigh*

Now let's see what's to be found in glibc-2.2.5.tar.gz. :)

-Tomas

-- 
"hello it's not like i read my mail so that you have where to offer to sell me
a giant turnip or anything else thankyou." -tomas szepe <kala@pinerecords.com>          
