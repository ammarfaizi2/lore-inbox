Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290344AbSA3SY3>; Wed, 30 Jan 2002 13:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290293AbSA3SXa>; Wed, 30 Jan 2002 13:23:30 -0500
Received: from xi.linuxpower.cx ([204.214.10.168]:64004 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S290319AbSA3SWJ>;
	Wed, 30 Jan 2002 13:22:09 -0500
Date: Wed, 30 Jan 2002 13:24:42 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Corey Minyard <minyard@acm.org>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
Message-ID: <20020130132442.A12754@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.44.0201301831120.5518-100000@netfinity.realnet.co.sz> <3C583655.6060707@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3C583655.6060707@acm.org>; from minyard@acm.org on Wed, Jan 30, 2002 at 12:07:17PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 12:07:17PM -0600, Corey Minyard wrote:
> Zwane Mwaikambo wrote:
> >You didn't make that explicit in your previous email, and anyway what kind 
> >of resolution can you expect from gettimeofday...
> >
> Depending on the processor, gettimeofday has very high resolution.
> If I remember correctly, the TCP stacks put in delays for small sends so 
> they can pack multiple things together.  I think there are ways to work 
> around this via some type of flush, but memory fails me on exactly how.

Please! People, if you don't know exactly what you are talking about, at
least keep your replies off list.

The problem he's having is caused by nagle, I replied to him off list
because not knowing the API to disable a perfectly standard TCP behavior is
not related to kernel development.

I get enough traffic from this list without having a dozen blind people
trying to lead the blind.

It's great that you are trying to be helpful, but please do it off list,
unless it's actual pertinent to kernel development.

[For future archive searchers: The solution is to set the TCP_NODELAY socket
option]
