Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVDLHRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVDLHRi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVDLHOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:14:16 -0400
Received: from mail.dif.dk ([193.138.115.101]:62438 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261913AbVDLHNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:13:18 -0400
Date: Tue, 12 Apr 2005 09:13:14 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matt Mackall <mpm@selenic.com>
Cc: Steven French <sfrench@us.ibm.com>, Steve French <smfrench@austin.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cifs: md5 cleanup - functions
In-Reply-To: <20050412063745.GN25554@waste.org>
Message-ID: <Pine.LNX.4.62.0504120854470.3879@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.62.0504112209220.2480@dragon.hyggekrogen.localhost>
 <20050412063745.GN25554@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2005, Matt Mackall wrote:

> Date: Mon, 11 Apr 2005 23:37:45 -0700
> From: Matt Mackall <mpm@selenic.com>
> To: Jesper Juhl <juhl-lkml@dif.dk>
> Cc: Steven French <sfrench@us.ibm.com>, Steve French <smfrench@austin.rr.com>,
>     linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] cifs: md5 cleanup - functions
> 
> On Mon, Apr 11, 2005 at 10:11:39PM +0200, Jesper Juhl wrote:
> > 
> > Function names and return types on same line - conform to established 
> > fs/cifs/ style.
> > 
> > Patch is also available at:
> > 	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_md5-funct.patch
> 
> I think the right thing to do here is what I did with the SHA1 code
> from random.c: put the favorite implementation in lib/ and replace the
> cryptoapi and CIFS implementations (and any other users) with it.
> 
> If you feel like tackling this, let me know, it's been on my todo list
> for a while.
> 
I wouldn't mind having a go at it, but I don't have too much time this 
week, but next week I should have some time - I'll take a look at it then.

-- 
Jesper Juhl


