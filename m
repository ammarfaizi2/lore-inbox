Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317476AbSFHXts>; Sat, 8 Jun 2002 19:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317479AbSFHXtr>; Sat, 8 Jun 2002 19:49:47 -0400
Received: from p50887457.dip.t-dialin.net ([80.136.116.87]:28039 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317476AbSFHXtq>; Sat, 8 Jun 2002 19:49:46 -0400
Date: Sat, 8 Jun 2002 17:49:39 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dan Aloni <da-x@gmx.net>, Brian Gerst <bgerst@didntduck.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More list_del_init cleanups
In-Reply-To: <Pine.LNX.4.44.0206081628390.11630-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0206081744280.15675-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 8 Jun 2002, Linus Torvalds wrote:
> Ehh.. Am I the only one who thinks "move()" would make more sense than
> "del_add()"?
> 
> How many such users are there? I don't want to make up new abstractions if
> they aren't widely used - it's not as if "del + add" is all that hard to
> understand in itself..

There are 57 uses of list_del(); list_add(); plus 1 use of 
remove_parent(); add_parent().
There are 29 uses of list_del(); list_add_tail();.

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

