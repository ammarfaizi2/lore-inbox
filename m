Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315547AbSFJR0J>; Mon, 10 Jun 2002 13:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSFJR0I>; Mon, 10 Jun 2002 13:26:08 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:59895 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S315547AbSFJR0I>; Mon, 10 Jun 2002 13:26:08 -0400
Message-ID: <3D04E140.76633075@cisco.com>
Date: Mon, 10 Jun 2002 22:56:24 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems
X-Mailer: Mozilla 4.51C-CISCOENG [en] (X11; I; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>,
        Andreas Dilger <adilger@clusterfs.com>, Dan Aloni <da-x@gmx.net>,
        Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <Pine.LNX.4.44.0206100954250.30535-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The linux coding style _tends_ to avoid using typedefs. It's not a hard
> rule (and I did in fact apply this patch, since it otherwise looked fine),
> but it's fairly common to use an explicit "struct xxxx" instead of
> "xxxx_t".
> 


	Besides , if someone's browsing the code using 'gid' one would
	have to first discover where xxxx_t is defined and realise it's
	typedef'ed to struct _xxxx_t and then we'd start to find where
	the heck _xxxx_t is .

	I'm not saying code needs to be written keeping in mind ease
	with which we can run code browsing tools, but avoiding unnecessary
	typedefs can certainly help here.
