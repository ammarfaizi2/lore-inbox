Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbSJCUTi>; Thu, 3 Oct 2002 16:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSJCUTi>; Thu, 3 Oct 2002 16:19:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59922 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261177AbSJCUTh>; Thu, 3 Oct 2002 16:19:37 -0400
Date: Thu, 3 Oct 2002 13:24:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Andreas Dilger <adilger@clusterfs.com>, <peterc@gelato.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Large Block device patch part 3/4
In-Reply-To: <15772.42409.841005.571964@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.33.0210031323590.23619-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Peter Chubb wrote:
>
> Theoretically as long as individual members are <1TB the
> sector_div/do_div macro can be used (I'm not an asm-386 expert: will
> do_div work for the full range of divisor? i.e., 0 to 2^32-1?  Someone
> on the LKML said it wouldn't)

It certainly _should_ work fine, although maybe I've missed something..

		Linus

