Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317353AbSFCKcY>; Mon, 3 Jun 2002 06:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSFCKcX>; Mon, 3 Jun 2002 06:32:23 -0400
Received: from dsl-213-023-039-253.arcor-ip.net ([213.23.39.253]:56735 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317353AbSFCKcX>;
	Mon, 3 Jun 2002 06:32:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] TRIVIAL: rwhron@earthlink.net: remove space in cache names
Date: Mon, 3 Jun 2002 12:31:47 +0200
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <E17El4U-0007ha-00@wagner.rustcorp.com.au> <3CFAFCB0.5030304@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Ep7r-0000sV-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 June 2002 07:20, Martin Dalecki wrote:
> Rusty Russell wrote:
> > rwhron@earthlink.net: remove space in _proc_slabinfo cache_name:
> >   Most /proc/slabinfo cache_names are in the format:
> >   cache_name.  There are a couple with spaces in the
> >   name, which is inconsistent and requires a special case
> >   when scripting.
> >   
> >   Changes "fasync cache" and "file lock cache" to have
> >   the usual underscore.
> >   
> >   Tested on 2.5.18.  Applies to 2.4.19-pre8 with offset.
> 
> If you are looking in this area already plese remove
> the completely redundant and inconsistently used cache
> suffix for some entry names too. Slabinfo is about allocation
> caches and nothing else.

Amen.

-- 
Daniel
