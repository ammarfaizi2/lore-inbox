Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSFJQuV>; Mon, 10 Jun 2002 12:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSFJQuU>; Mon, 10 Jun 2002 12:50:20 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:34723 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S315525AbSFJQuT>; Mon, 10 Jun 2002 12:50:19 -0400
Date: Mon, 10 Jun 2002 18:50:16 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Dan Aloni <da-x@gmx.net>,
        Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <20020610163702.GL20388@turbolinux.com>
Message-ID: <Pine.GSO.4.05.10206101846060.17299-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--snip/snip

> I think you will find that the "struct list_head" is the preferred way
> to go (which is why there are lots of "struct list_head" users in the
> code and few "list_t" users.

ok, the point that *_t is hiding implementation details (when used for
structs is valid). but is there a general consens on not using typedefs
for structs?

if yes, can we _please_ get rid of the *_t for structs.
if no, shouldn't we use the types already defined?

a similar thing will be unsigned (int|short|long|...)

just my $0.02 for the day,

	tm

-- 
in sometimes i don't, this time i do. 

