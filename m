Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316238AbSEVQxV>; Wed, 22 May 2002 12:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316241AbSEVQxU>; Wed, 22 May 2002 12:53:20 -0400
Received: from splat.lanl.gov ([128.165.17.254]:31666 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S316238AbSEVQxU>; Wed, 22 May 2002 12:53:20 -0400
Date: Wed, 22 May 2002 10:53:20 -0600
From: Eric Weigle <ehw@lanl.gov>
To: "Linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Subject: Safety of -j N when building kernels?
Message-ID: <20020522165320.GC18059@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, stupid question of the moment-

I always read about the kernel compilation benchmarks people run on the
ultra-snazzy new machines, but do people actually run the kernels thus
generated?

I have visions of a process being backgrounded to generate some files, and
not completing before the one of the old files gets linked into the kernel
(because not all files were listed as dependencies, for example).

So are the kernel's current Makefiles really SMP safe -- can one really
run multiple jobs when building Linux kernels? Any horror stories, or am
I just paranoid?


Thanks
-Eric

-- 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
