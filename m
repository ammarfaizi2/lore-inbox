Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUAGMIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 07:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbUAGMIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 07:08:22 -0500
Received: from linuxhacker.ru ([217.76.32.60]:59551 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265476AbUAGMIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 07:08:21 -0500
Date: Wed, 7 Jan 2004 14:08:21 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, mfedyk@matchmail.com,
       Jesper Juhl <juhl-lkml@dif.dk>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       grev@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested
Message-ID: <20040107120821.GG415627@linuxhacker.ru>
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <200401062135.i06LZAOY005429@car.linuxhacker.ru> <3FFB46B0.9060101@namesys.com> <20040106235335.GC415627@linuxhacker.ru> <3FFBD0B1.50909@namesys.com> <20040107100113.GE415627@linuxhacker.ru> <3FFBE6D3.7090701@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFBE6D3.7090701@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 07, 2004 at 02:00:35PM +0300, Hans Reiser wrote:

> >>can we get gcc to issue us a warning?  there might be other stuff 
> >>lurking around also....
> >If you add -W switch to CFLAGS, you'd get A LOT of more warnings.
> >Also just reading manpage on gcc around description of that flag will
> >give you a list of options to individually turn on certain check types.
> >Also gcc 3.3 have this sort of " unsigned < 0 | unsigned > 0" checks on by
> >default, I think.
> Sigh, this means that not one member of our team bothered to compile 
> with -W and cleanup things that were found?  Sad.  This is what happens 

Well, I was doing these sorts of stuff and cleaning all stuff that I thought
was important enough.
Both on kernel code and progs code.
Also reiser4progs include -W switch by default (and -Werror as well) I think.
At least that was the case back in September.

Bye,
    Oleg
