Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283007AbRK1CYO>; Tue, 27 Nov 2001 21:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281846AbRK1CYE>; Tue, 27 Nov 2001 21:24:04 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:51622 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S283007AbRK1CXp>;
	Tue, 27 Nov 2001 21:23:45 -0500
Message-ID: <3C044AA3.CDCF7D67@pobox.com>
Date: Tue, 27 Nov 2001 18:23:31 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: heads-up: preempt kernel and tux NO-GO
In-Reply-To: <Pine.LNX.4.40.0111272007070.9338-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:

> On Tue, 27 Nov 2001, J Sloan wrote:
>
> > I have been looking into the tux2 webserver -
> > Man, what a thing of beauty. A web benchmark
> > that sends the load on the web server to 150
> > when running apache results in a load average
> > of  maybe 2 when running tux, and much faster
> > results to boot - anyway, I digress....
>
> Loadavg isn't much of a measure here, it's a measure of the length of the
> runnable queue. If you've only got two processes because your server has a
> thread per processor, then yes, you'll see lower loadavg, but not lower
> load. A real measure would look at idle percentage and throughput.

That's easily done, and we know that load average
is a measure of tasks waiting to run - but rather
than throw more statistics around, I can say that
a Linux desktop running tux remains responsive
under a http load that would tend to monopolize it's
attention under apache -

Now I'm not knocking apache of course, it's the
standard these days, and there's nothing more
flexible or reliable - but there is indeed a niche
for a small, blindingly fast server like tux - and I
intend to explore that niche in coming months.

cu

jjs

