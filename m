Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264783AbSJVR0M>; Tue, 22 Oct 2002 13:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264803AbSJVR0M>; Tue, 22 Oct 2002 13:26:12 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:64404 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S264783AbSJVR0K>; Tue, 22 Oct 2002 13:26:10 -0400
Message-ID: <3DB58EFC.1010908@kegel.com>
Date: Tue, 22 Oct 2002 10:46:36 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: "Charles 'Buck' Krasic" <krasic@acm.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <20021018185528.GC13876@mark.mielke.cc> <Pine.LNX.4.44.0210181209510.1537-100000@blue1.dev.mcafeelabs.com> <20021019065624.GA17553@mark.mielke.cc> <xu4y98utnn7.fsf@brittany.cse.ogi.edu> <20021022172244.GA1314@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> epoll is not a poll()/select() enhancement (unless it is used in
> conjuction with poll()/select()). It is a poll()/select()
> replacement.
> 
> Meaning... purposefully creating an API that is designed the way one
> would design a poll()/select() loop is purposefully limiting the benefits
> of /dev/epoll.
> 
> It's like inventing a power drill to replace the common screw driver,
> but rather than plugging the power drill in, manually turning the
> drill as if it was a socket wrench for the drill bit.
> 
> I find it an excercise in self defeat... except that /dev/epoll used the
> same way one would use poll()/select() happens to perform better even
> when it is crippled.

Agreed.
- Dan


