Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSGMOA3>; Sat, 13 Jul 2002 10:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSGMOA2>; Sat, 13 Jul 2002 10:00:28 -0400
Received: from dsl-213-023-021-044.arcor-ip.net ([213.23.21.44]:52137 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313563AbSGMOA1>;
	Sat, 13 Jul 2002 10:00:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: john slee <indigoid@higherplane.net>
Subject: Re: bzip2 support against 2.4.18
Date: Sat, 13 Jul 2002 16:04:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <E17Suso-0002dn-00@starship> <20020713135602.GK7579@higherplane.net>
In-Reply-To: <20020713135602.GK7579@higherplane.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17TNVl-0003J2-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 July 2002 15:56, john slee wrote:
> On Fri, Jul 12, 2002 at 09:30:29AM +0200, Daniel Phillips wrote:
> > Actually, what is the use of even including 'bz2' in the name?  Nobody
> > besides we geeks needs to know the thing is compressed with bzip2.  It
> > would be nice to see the word 'linux' in there.  How about bzlinux?
> > Just think of the hundreds of cases of carpal tunnel syndrome you'd
> > prevent by eliminating the shifted character.
> 
> why not just call it 'linux'?  file(1) exists for a reason, and the 'vm'
> prefix is a bit redundant these days
> 
> also i've never really understood why the binary format of the kernel is
> selected via make.  why not just make it a regular kernel option with a
> sane default?  surely your average kernel compiling person picks
> something that works (zImage? bzImage? Image?) and sticks to it...

Unix geeks like tradition and they like oddball names that can only be
explained by knowing history; this creates a kind of lore to be passed 
down from senior to junior programmers, a kind of bonding.

This gets increasingly silly as time goes by.  However, it's not yet
gotten so silly that 'bzImage' is likely to be replaced by 'linux' any
time soon.  At least, we don't have to make it any worse and if you
read the whole thread you'll see the consensus is strongly in favor
of pushing the desired image format into the config.

Note that Jeff Dike sensibly called his make target 'linux'.

-- 
Daniel
