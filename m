Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265629AbSKAR4V>; Fri, 1 Nov 2002 12:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265635AbSKAR4V>; Fri, 1 Nov 2002 12:56:21 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:52638 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S265629AbSKAR4U>; Fri, 1 Nov 2002 12:56:20 -0500
Message-ID: <3DC2C587.5080706@kegel.com>
Date: Fri, 01 Nov 2002 10:18:47 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: "Matthew D. Hall" <mhall@free-market.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
References: <Pine.LNX.4.44.0210311838060.972-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
>>*  I'm sure everyone would agree that passing an opaque "user context"
>>pointer is necessary with each event.
> 
> I asked this about a week ago. It's _trivial_ to do in epoll. I did not
> receive any feedback, so I didn't implement it. Feedback will be very much
> appreciated here ...

If it's cheap, do it!  It relieves the programmer of having
to manage a fd to object lookup table.
- Dan


