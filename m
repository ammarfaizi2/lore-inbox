Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317789AbSGVUCH>; Mon, 22 Jul 2002 16:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317793AbSGVUCH>; Mon, 22 Jul 2002 16:02:07 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12297 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317789AbSGVUCG>; Mon, 22 Jul 2002 16:02:06 -0400
Date: Mon, 22 Jul 2002 17:05:00 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Paul Larson <plars@austin.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
In-Reply-To: <Pine.LNX.4.44L.0207221657460.3086-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Rik van Riel wrote:

> I've gotten two reports of this bug now, but have no idea
> what particular combination of hardware / compiler / config
> triggers the bug. The rmap code seems to have survived akpm's
> stress tests so it's probably not a simple bug to track down ;/

Now that I think about it, could you try enabling RMAP_DEBUG
in mm/rmap.c and try triggering this bug again ?

It's quite possible the debugging code in page_remove_rmap()
will show us a hint...

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

