Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSFOUCE>; Sat, 15 Jun 2002 16:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSFOUCD>; Sat, 15 Jun 2002 16:02:03 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:17314 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315487AbSFOUCC>; Sat, 15 Jun 2002 16:02:02 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 15 Jun 2002 13:01:55 -0700
Message-Id: <200206152001.NAA02740@adam.yggdrasil.com>
To: akpm@zip.com.au
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>- It's tricky to determine how many bvecs are available in
>  a bio.  There is no straightforward "how big is it" field
>  in struct bio.

	Can't I make a macro to do a table lookup from bio->bi_max?

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
