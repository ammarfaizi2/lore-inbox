Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318255AbSHINHp>; Fri, 9 Aug 2002 09:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318256AbSHINHp>; Fri, 9 Aug 2002 09:07:45 -0400
Received: from tistel.levonline.com ([193.15.191.243]:15095 "EHLO
	utter.levonline.com") by vger.kernel.org with ESMTP
	id <S318255AbSHINHp>; Fri, 9 Aug 2002 09:07:45 -0400
Date: Fri, 9 Aug 2002 15:10:47 +0200 (CEST)
From: Johan Martensson <a0087901@levonline.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, <jom@virrvarr.com>
Subject: Re: 2.4.19 Oops :Unable to handle kernel paging request
In-Reply-To: <20020809132447.A9306@infradead.org>
Message-ID: <Pine.LNX.4.44.0208091502450.14539-100000@utter.levonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Aug 2002, Christoph Hellwig wrote:

> On Fri, Aug 09, 2002 at 02:17:22PM +0200, Johan Martensson wrote:
> > One of our machines running linux 2.4.19 with grsecurity 1.9.6 got an Oops 
> > last night. I'm sorry if it is obvious that this is caused by grsecurity 
> > and wouldn't happen with vanilla 2.4.19 (I'm too stupid to tell:)).
> 
> At least the oops is in the grsecurity code.  I'd contact it's developers
> first.

I did. But when looking at the Oops output it seems to me that it is
get_free_page() that fails. If that is correct then it shouldn't matter
wether the call was made from grsecurity, should it? I thought
get_free_page would be succesful as long as I have free memory in
the system. I didn't post to lkml just to spam but because I thought that
it actually didn't matter that it happend in the grsecurity code.

Of course I could still be very wrong :-).

/Johan 

