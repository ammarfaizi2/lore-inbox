Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290075AbSBOQaL>; Fri, 15 Feb 2002 11:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290059AbSBOQaC>; Fri, 15 Feb 2002 11:30:02 -0500
Received: from relay1.pair.com ([209.68.1.20]:13835 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S290012AbSBOQ3u>;
	Fri, 15 Feb 2002 11:29:50 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C6D393A.92BBD4CF@kegel.com>
Date: Fri, 15 Feb 2002 08:37:14 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Brownfield <brownfld@irridia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: tux officially in kernel?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Brownfield wrote:
> The problem with X15 is that it's unavailable.  I've tried for months
> and months to get someone at that company to respond or get a copy to
> try.  Also, is it GPL?  Free?

I have a copy -- they sent one to me readily back when it was new --
but it's not open source, so I can't share it.
It's not a huge program; the whole thing is 5000 lines of C.
It uses the rtsignal method of readiness notification.

IMHO anyone writing a similar user-space server these days should start 
with a clean encapsulation of the readiness notification code, e.g. http://www.kegel.com/dkftpbench/doc/Poller.html .
The performance would be similar, the code would be
a lot cleaner, and it'd be a heck of a lot more portable.

> As for TUX, I would certainly prefer user-space if it was indeed as fast
> in all cases.  But I don't think X15 is really a factor in TUX's
> inclusion.  I'd say replacing khttpd with TUX2 is a no-brainer unless
> X15's performance has been proven and it's GPL.  And while khttpd is an
> interesting example, it really rocks at small image serving.  I've had
> it in production since 2.4.0-test1.

Point taken.  One of my friends uses khttpd in production, too.

Somebody needs to come up with a nice GPL'd userspace replacement
for khttpd.  (Or does one already exist?  I haven't been following things
too closely...)

- Dan
