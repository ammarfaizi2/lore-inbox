Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313817AbSEIQJ7>; Thu, 9 May 2002 12:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313818AbSEIQJ6>; Thu, 9 May 2002 12:09:58 -0400
Received: from relay1.pair.com ([209.68.1.20]:12302 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S313817AbSEIQJ5>;
	Thu, 9 May 2002 12:09:57 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CDAA018.F00E8015@kegel.com>
Date: Thu, 09 May 2002 09:13:12 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Brownfield <ken@irridia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khttpd-users@lists.alt.org" <khttpd-users@alt.org>
Subject: Re: khttpd newbie problem
In-Reply-To: <3CD402D2.E3A94CA2@kegel.com> <20020505005439.GA12430@krispykreme> <3CD4C93D.E543B188@kegel.com> <20020508222119.A12672@asooo.flowerfire.com> <3CDA0876.218285C7@kegel.com> <20020509003155.B12672@asooo.flowerfire.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Brownfield wrote:
> Hmm.  I've had it running *hard* for two years, never seen a single oops
> or glitch of any sort, kernels 2.4.0-test1 through 2.4.18.  O(1),
> preempt, low-latency all on at various times.

Try cycling it up and down in a loop.  That's what triggers the bug
my recent patch fixed. (Actually, just starting it once triggers it,
depending on a race condition between the management thread and the
worker threads.)

> | Yukky.  Makes me want to go work with user-mode web servers instead.
> 
> Yeah, good luck tracking down X15.

I have a copy, actually.  It uses Linux's rtsig scheme.
Can't use it, though, as its license prohibits commercial use.
I am tempted to add rtsig support to thttpd, though.

- Dan
