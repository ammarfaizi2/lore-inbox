Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSHPCLF>; Thu, 15 Aug 2002 22:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317978AbSHPCLF>; Thu, 15 Aug 2002 22:11:05 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:10626 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S317950AbSHPCLE>; Thu, 15 Aug 2002 22:11:04 -0400
Date: Thu, 15 Aug 2002 19:14:49 -0700
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] don't write all inactive pages at once
Message-ID: <20020816021449.GA1531@gnuppy.monkey.org>
References: <Pine.LNX.4.44L.0208152122130.23404-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208152122130.23404-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 09:24:45PM -0300, Rik van Riel wrote:
> Hi,
> 
> the following patch, against current 2.4-rmap, makes sure we don't
> write the whole inactive dirty list to disk at once and seems to
> greatly improve system response time when under swap or other heavy
> IO load.
> 
> Scanning could be much more efficient by using a marker page or
> similar tricks, but for now I'm going for the minimalist approach.
> If this thing works I'll make it fancy.
> 
> Please test this patch and let me know what you think.

Hey,

Test your patch ? What ??!?!! :)

Actually, the interactivity is much better overall and it seems to
much less stupid stuff (by non-empirical feel) than it use to.

It's just a matter of seeing if my experiences are backed up by
others using this patch. ;)

(/me hopes)

bill

