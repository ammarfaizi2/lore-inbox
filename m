Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319073AbSHUUY3>; Wed, 21 Aug 2002 16:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319117AbSHUUY3>; Wed, 21 Aug 2002 16:24:29 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:18183 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S319073AbSHUUY2>; Wed, 21 Aug 2002 16:24:28 -0400
Date: Wed, 21 Aug 2002 17:27:43 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       <linux-kernel@vger.kernel.org>, Thomas Molina <tmolina@cox.net>
Subject: Re: Race in pagevec code
In-Reply-To: <3D63D0DC.271B6130@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208211726460.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, Andrew Morton wrote:

> The page->pte.chain != NULL problems predate the locking changes.
> We haven't found that one yet.

Yes, but we have 2 fixes for the page->pte.chain != NULL
problem that happened with mlock() and with discontigmem.

I don't remember seeing the other manifestation of the
bug without the locking changes...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

