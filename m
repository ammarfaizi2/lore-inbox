Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbRD1Ibr>; Sat, 28 Apr 2001 04:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132586AbRD1Ib2>; Sat, 28 Apr 2001 04:31:28 -0400
Received: from mail3.noris.net ([62.128.1.28]:25990 "EHLO mail3.noris.net")
	by vger.kernel.org with ESMTP id <S132580AbRD1IbR>;
	Sat, 28 Apr 2001 04:31:17 -0400
To: dalecki@evision-ventures.com (Martin Dalecki)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AE9A69B.D11F0BBD@evision-ventures.com>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
From: smurf@noris.de (Matthias Urlichs)
Date: Sat, 28 Apr 2001 10:31:10 +0200
Message-ID: <1eskkme.1imowzk1sryex0M%smurf@noris.de>
Organization: noris network AG
User-Agent: MacSOUP/2.4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki :
> tar/cpio and friends don't deal properly with
> 
> a. holes inside of files.
> b. hardlinks between files.
> 
??? GNU tar does both. The only thing it currently cannot handle is Not
Changing Anything: either atime or ctime _will_ be updated.
