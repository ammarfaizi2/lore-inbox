Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbSBCObp>; Sun, 3 Feb 2002 09:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287293AbSBCObg>; Sun, 3 Feb 2002 09:31:36 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:49162 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S287279AbSBCObS>; Sun, 3 Feb 2002 09:31:18 -0500
Date: Sun, 3 Feb 2002 14:31:08 +0000 (GMT)
From: <chris@scary.beasts.org>
X-X-Sender: <cevans@sphinx.mythic-beasts.com>
To: <rwhron@earthlink.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020202192334.GA21556@earthlink.net>
Message-ID: <Pine.LNX.4.33.0202031429250.18232-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Feb 2002 rwhron@earthlink.net wrote:

>  		Num    Seq Write    CPU    Rand Write   CPU
>  		Thr   Rate (CPU%)   Eff    Rate (CPU%)  Eff
>  		---  -------------------  -----------------
> 2.4.17            1  11.08  50.5%  21.94  0.69  1.6%  44.10
> 2.4.17rat         1   7.77  32.8%  23.69  0.53  1.1%  48.44

This is a worrying trend your benching has exposed - all the streaming
write tests have taken a performance hit. Above is tiobench, and bonnie
showed the same trend too.

Chris


