Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSGYWhR>; Thu, 25 Jul 2002 18:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSGYWhR>; Thu, 25 Jul 2002 18:37:17 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:14 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316601AbSGYWhQ>; Thu, 25 Jul 2002 18:37:16 -0400
Date: Thu, 25 Jul 2002 19:39:58 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Cort Dougan <cort@fsmlabs.com>
cc: Andrea Arcangeli <andrea@suse.de>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
In-Reply-To: <20020725142716.N2276@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.44L.0207251934490.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002, Cort Dougan wrote:

> I've found it valuable to have the EIP resolved.  Even though the symbol
> name may not be perfect (only resolves exported names) it is valuable to
> see that the function crashed 0x1fe bytes after a given symbol name.

It's an absolute must-have feature.  Too many users send in
undecoded or wrongly decoded oopses and we end up spending
too much time trying to teach users how to decode oopses.

Add to that the fact that symbols from modules aren't always
looked up allright.

Having the kernel print out the function symbol and offset
into the function would save us a lot of time and trouble
in tracking down problems.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

