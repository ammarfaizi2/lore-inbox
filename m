Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315042AbSEYRpF>; Sat, 25 May 2002 13:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315155AbSEYRpE>; Sat, 25 May 2002 13:45:04 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58367 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315042AbSEYRpD>;
	Sat, 25 May 2002 13:45:03 -0400
Date: Sat, 25 May 2002 13:45:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup parse_options() of fatfs (3/4)
In-Reply-To: <87y9e8zbj3.fsf@devron.myhome.or.jp>
Message-ID: <Pine.GSO.4.21.0205251343420.13379-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, OGAWA Hirofumi wrote:

> This patch merges the parse_options() of vfat and fat. And, added the
> (borrowed from ext3) code for reporting the error of specified
> options.
> 
> Please apply.

Please, hold on.  If we are going to do that, we'd better do it right...
I'll resurrect and post the options-parser patch - it covers all that
stuff with less ad-hackery.

