Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276877AbRJVPtv>; Mon, 22 Oct 2001 11:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276907AbRJVPtb>; Mon, 22 Oct 2001 11:49:31 -0400
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:7440 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S276877AbRJVPt2>; Mon, 22 Oct 2001 11:49:28 -0400
Date: Mon, 22 Oct 2001 17:49:59 +0200
From: Patrick Mau <mau@oscar.prima.de>
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: connect() to localhost non-blocking.
Message-ID: <20011022174959.A31147@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
In-Reply-To: <3BD357B2.12AE9A5E@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BD357B2.12AE9A5E@kegel.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 04:18:10PM -0700, Dan Kegel wrote:
> > Patrick Mau <mau@oscar.prima.de> writes:
> > 

[Snip]

> You have to be prepared to handle both immediate and delayed
> connection, especially if you want to be portable.  (Solaris behaves 
> a bit differently than Linux in this regard.)  See
> http://www.kegel.com/dkftpbench/dkftpbench-0.37/ftp_client_pipe.cc
> for an example of how to handle nonblocking connects more or less portably.
> (You have to wade through quite a bit of code, tabstops 4, to find
> all the connect-handling stuff -- sorry.)
> - Dan

Hallo Dan,

thnaks for the pointer and your remarks, but I really
wondered if linux _never_ immediatly accept()'s connections.

I never saw a connect() call returning 0 (connected) on a
non-blocking socket. Always EINPROGRESS. I guess I have to
look at the kernel to see scheduling effects ...

thanks,
Patrick
