Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269068AbRHLLGT>; Sun, 12 Aug 2001 07:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269081AbRHLLGI>; Sun, 12 Aug 2001 07:06:08 -0400
Received: from web10407.mail.yahoo.com ([216.136.130.99]:63246 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269068AbRHLLGF>; Sun, 12 Aug 2001 07:06:05 -0400
Message-ID: <20010812110617.34113.qmail@web10407.mail.yahoo.com>
Date: Sun, 12 Aug 2001 21:06:17 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: Performance 2.4.8 is worse than 2.4.x<8
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108120754020.593-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Mike Galbraith <mikeg@wen-online.de> wrote: > On
Sun, 12 Aug 2001, Steve Kieu wrote:
> 
> > Anyone noticed that?
> 
> Details?

VM is very much improved but it seems to take
resources  to free cached pages.
> Here, disk write throughput seems to want some
> tweaking, and Bonnie

that is what I see

 doing it's rewrite test triggers a very large and
> persistant inactive
> shortage which shouldn't be there (imho).
> 
> page_launder() is definitely working better than
> some of the pre8
> kernels in that it is no longer laundering the
> entire dirty list in
> one huge gulp.  It is also no longer laundering some
> random amount.
> 
> Under FWIW:  I can find no reason for the existance
> of either the
> launder_loop nor doing synchronous IO.  Here, I
> remove both regularly
> and detect nothing but benefit both in responsivness
> and throughput.
> 
>  -Mike
>  

=====
S.KIEU

_____________________________________________________________________________
http://shopping.yahoo.com.au - Father's Day Shopping
- Find the perfect gift for your Dad for Father's Day
