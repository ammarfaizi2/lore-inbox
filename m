Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318955AbSIJBoX>; Mon, 9 Sep 2002 21:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318971AbSIJBoW>; Mon, 9 Sep 2002 21:44:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25608 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318955AbSIJBoV>; Mon, 9 Sep 2002 21:44:21 -0400
Date: Mon, 9 Sep 2002 18:49:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Skip Ford <skip.ford@verizon.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.34 ufs/super.c
In-Reply-To: <Pine.GSO.4.21.0209092139520.4087-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0209091848510.1714-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Alexander Viro wrote:
> 
> No particulary good reason, except keeping calling convention the same for
> sb_set_blocksize() and sb_min_blocksize()...

Ahh, that kind of makes sense. I'll apply the minimal patch from Skip (ie 
not change the current convention).

		Linus

