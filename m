Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317918AbSHCVTO>; Sat, 3 Aug 2002 17:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317922AbSHCVTO>; Sat, 3 Aug 2002 17:19:14 -0400
Received: from dsl-213-023-022-101.arcor-ip.net ([213.23.22.101]:21181 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317918AbSHCVTN>;
	Sat, 3 Aug 2002 17:19:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: [PATCH] Rmap speedup... call for testing
Date: Sat, 3 Aug 2002 23:24:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17aiJv-0007cr-00@starship> <E17aptH-0008DR-00@starship> <3D4B692B.46817AD0@zip.com.au>
In-Reply-To: <3D4B692B.46817AD0@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17b6Nd-0002gh-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 07:24, Andrew Morton wrote:
> No joy, I'm afraid.

We need to eliminate some variables.  People, can we please have some smp 
results for 2 way or whatever-way for the exact kernel I used:

   http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.18.tar.bz2
   http://www.kernel.org/pub/linux/kernel/v2.4/testing/old/patch-2.4.19-pre7.bz2
   http://surriel.com/patches/2.4/2.4.19p7-rmap-13b

With and without this patch:

   http://people.nl.linux.org/~phillips/patches/rmap.speedup-2.4.19-pre7

Using this script:

   http://people.nl.linux.org/~phillips/patches/lots_of_forks.sh

time sh lots_of_forks.sh

Thanks.

-- 
Daniel
