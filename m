Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293014AbSCDX5k>; Mon, 4 Mar 2002 18:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293020AbSCDX5a>; Mon, 4 Mar 2002 18:57:30 -0500
Received: from zero.tech9.net ([209.61.188.187]:21522 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293014AbSCDX5U>;
	Mon, 4 Mar 2002 18:57:20 -0500
Subject: Re: latency & real-time-ness.
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.44L.0203042047010.2181-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0203042047010.2181-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 18:56:57 -0500
Message-Id: <1015286218.1083.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 18:48, Rik van Riel wrote:

> > If rmap finds its way into 2.5, I and others have some ideas about ways
> > to optimize the algorithms to reduce lock hold time and benefit from
> > preemption.  For example, Daniel Phillips has some ideas wrt
> > zap_page_range.
> 
> Feel free to help resolve these issues before rmap code gets
> merged. I'd prefer to be able to introduce rmap in small bits
> and pieces without breaking anything.

The above was just an optimization ... rmap and preempt work fine
together.

What Andrew Morton, I, and others intend to do for 2.5 is work on the
algorithms and locking issues to work on latency issues cleanly.

But I'll surely work on the issues wrt rmap ;)

	Robert Love

