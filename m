Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313968AbSDQMoK>; Wed, 17 Apr 2002 08:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313912AbSDQMoJ>; Wed, 17 Apr 2002 08:44:09 -0400
Received: from borg.org ([208.218.135.231]:45970 "HELO borg.org")
	by vger.kernel.org with SMTP id <S314020AbSDQMoH>;
	Wed, 17 Apr 2002 08:44:07 -0400
Date: Wed, 17 Apr 2002 08:44:04 -0400
From: Kent Borg <kentborg@borg.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020417084404.A9382@borg.org>
In-Reply-To: <20020416222156.GB20464@turbolinux.com> <E16xba3-0005tw-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 08:37:43AM +1000, Herbert Xu wrote:
> Why are we still measuring uptime using the tick variable? Ticks != time.
> Surely we should be recording the boot time somewhere (probably on a
> file system), and then comparing that with the current time?

It depends on the meaning of "is", er, opps, I mean: it depends on the
meaning of "uptime".

The notebook I am typing on at this moment was last booted just about
exactly 8 days ago (judging from the timestamp on /var/log/dmesg) but
in a cat-like way it spends a lot of its time asleep and so top
reports an uptime of only "4 days, 2:42".

Which is correct?  I suggest that the smaller number is closer to
correct because that is roughly the amount of time the system has
actually spent running.


-kb, the Kent who expects this question to get more complicated as the
new suspend gets more and more clever and if the kernel ever starts
seriously catnapping on its own.
