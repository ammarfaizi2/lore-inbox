Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278755AbRKDUbX>; Sun, 4 Nov 2001 15:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRKDUbN>; Sun, 4 Nov 2001 15:31:13 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:17672 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S278823AbRKDUbE>; Sun, 4 Nov 2001 15:31:04 -0500
Date: Sun, 4 Nov 2001 21:30:58 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre8: 'free' still reports bogus 'cached' value.
Message-ID: <20011104213058.A11308@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
In-Reply-To: <20011104132238.A14511@oscar.dorf.de> <3BE58886.FBCAEDB5@zip.com.au> <3BE59009.79CBED53@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE59009.79CBED53@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 10:59:21AM -0800, Andrew Morton wrote:
> Andrew Morton wrote:
> > 
> > It's a bug in the /proc code.  If buffercache pages exceed
> > pagecache pages, `pg_size' flips negative.
> > 
> > There doesn't seem to be any reason to subtract buffermem_pages
> > from page_cache_size - they're independent.
> > 
> 
> Well that was crap, wasn't it?  Wrong kernel.

Hallo Andrew,

I didn't even noticed, because I had no time to test ;o)

But thnks anyway. Maybe - for testing only - one could insert
a BUG() if the cached amount gets negative to get a call trace ?

My expirience in kernel hacking is rather limited.
I just wanted to report it anyway, because I thought it got fixed.

Have a nice Monday,
(at least I hope I will),

Patrick
