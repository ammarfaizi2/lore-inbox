Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSFHX6h>; Sat, 8 Jun 2002 19:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317483AbSFHX6g>; Sat, 8 Jun 2002 19:58:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45586 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317482AbSFHX6g>; Sat, 8 Jun 2002 19:58:36 -0400
Date: Sat, 8 Jun 2002 16:59:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Thunder from the hill <thunder@ngforever.de>
cc: Dan Aloni <da-x@gmx.net>, Brian Gerst <bgerst@didntduck.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More list_del_init cleanups
In-Reply-To: <Pine.LNX.4.44.0206081744280.15675-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0206081657360.11630-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jun 2002, Thunder from the hill wrote:
>
> There are 57 uses of list_del(); list_add(); plus 1 use of
> remove_parent(); add_parent().
>
> There are 29 uses of list_del(); list_add_tail();.

Hmm. Sounds like "list_move()" and "list_move_tail()" might be worthwhile.

That's assuming people actually _want_ something like that? Anybody
willing to do this, _and_ go through the maintainers of the appropriate
sub-systems?

		Linus

