Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271106AbRIASzX>; Sat, 1 Sep 2001 14:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271124AbRIASzN>; Sat, 1 Sep 2001 14:55:13 -0400
Received: from ns.ithnet.com ([217.64.64.10]:54287 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271106AbRIASzF>;
	Sat, 1 Sep 2001 14:55:05 -0400
Date: Sat, 1 Sep 2001 20:54:01 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-Id: <20010901205401.158577a1.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0109011021570.280-100000@mikeg.weiden.de>
In-Reply-To: <20010901055634Z16057-32383+2785@humbolt.nl.linux.org>
	<Pine.LNX.4.33.0109011021570.280-100000@mikeg.weiden.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2001 10:26:48 +0200 (CEST) Mike Galbraith <mikeg@wen-online.de>
wrote:

> On Sat, 1 Sep 2001, Daniel Phillips wrote:
> 
> > Better go back and read the thread.  The allocation rate is definitely
> > limited - he's doing a cd burn and some network copies.  [....]
>                          ^^^^^^^
> P.S.
> Stephan:  try unconditionally doing gfp_mask &= ~__GFP_WAIT at the top
> of page_launder().  I think that will help your problem some.

Hi Mike,

I tried, doesn't make a difference. Same number of alloc-fails.
Sorry. 
Patch looks weird anyway :-)

Regards, Stephan

