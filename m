Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSFJTqF>; Mon, 10 Jun 2002 15:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSFJTqE>; Mon, 10 Jun 2002 15:46:04 -0400
Received: from p50887BDF.dip.t-dialin.net ([80.136.123.223]:3201 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315925AbSFJTqD>; Mon, 10 Jun 2002 15:46:03 -0400
Date: Mon, 10 Jun 2002 13:46:02 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andrew Morton <akpm@zip.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <3D04FE64.B92706E8@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206101344170.6159-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Jun 2002, Andrew Morton wrote:
> __func__ does *not* work on egcs-1.1.2 and so cannot be used in Linux.
> 
> `struct blah = { .open = driver_open };' *does* work in egcs-1.1.2
> and is OK to use.

Gee. I guess we need a special host gcc to support our needs - on 
sparc(|64). We might have a patch that easily renames it in the sources of 
egcs...

Anyway, what is the problem about new gcc on old sparc? It works at least 
on my sparc64, I can't complain.

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

