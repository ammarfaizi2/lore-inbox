Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265834AbSKBA1P>; Fri, 1 Nov 2002 19:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265835AbSKBA1P>; Fri, 1 Nov 2002 19:27:15 -0500
Received: from almesberger.net ([63.105.73.239]:39688 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265834AbSKBA1O>; Fri, 1 Nov 2002 19:27:14 -0500
Date: Fri, 1 Nov 2002 21:33:25 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Ed Vance <EdV@macrolink.com>
Cc: "'Richard B. Johnson'" <root@chaos.analogic.com>,
       Ken Ryan <newsryan@leesburg-geeks.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5] October 30, 2002
Message-ID: <20021101213324.H2599@almesberger.net>
References: <11E89240C407D311958800A0C9ACF7D1A33C8E@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33C8E@EXCHANGE>; from EdV@macrolink.com on Fri, Nov 01, 2002 at 02:25:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Vance wrote:
> functional as long as he can keep up. For the memory, the many separate bit
> error events would cause only correctable errors, as long as the scrubbing
> can keep up.

Don't those bit errors have a Poissonian character ? If so, it's
impossible to "keep up". All you can do is make the interval small
enough that, on average, it takes a long time until you get hit
twice (or more often) in that interval.

A better example would be car tires on roads with many randomly
distributed sharp objects (i.e. such that age does not significantly
change the odds of tire damage): you can keep going as long as you
can get a flat tire fixed before another tire gets punctured. But
sometimes, you may end up with two flat tires, and need a tow truck.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
