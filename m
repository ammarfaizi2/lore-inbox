Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbSJDA1M>; Thu, 3 Oct 2002 20:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbSJDA1H>; Thu, 3 Oct 2002 20:27:07 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:21165 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261404AbSJDA1E>; Thu, 3 Oct 2002 20:27:04 -0400
Date: Thu, 3 Oct 2002 21:32:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Greg Ungerer <gerg@snapgear.com>
cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.40-ac1
In-Reply-To: <3D9CD647.7000806@snapgear.com>
Message-ID: <Pine.LNX.4.44L.0210032129570.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002, Greg Ungerer wrote:
> Rik van Riel wrote:

> Easy done. Would it bother anyone having a few files
> named XYZ-nommu.c in there?

Excellent.

> Although the sticking point may be the common files that
> still contain a lot of ifdefs.

That's ok initially. We can probably split up functions
somewhat or do other tricks to reduce the number of
ifdefs later on.

Alternatively, we could do the splitting first and the
nommu merge later. I don't really care about the order
as long as things don't happen simultaneously in patch
that's too big to check ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

