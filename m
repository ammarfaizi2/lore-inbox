Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288512AbSBDFaD>; Mon, 4 Feb 2002 00:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288531AbSBDF3x>; Mon, 4 Feb 2002 00:29:53 -0500
Received: from relay1.pair.com ([209.68.1.20]:9481 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S288512AbSBDF3m>;
	Mon, 4 Feb 2002 00:29:42 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C5E1DB6.CE97AD36@kegel.com>
Date: Sun, 03 Feb 2002 21:35:50 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Sethman <androsyn@ratbox.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <Pine.LNX.4.44.0202032337251.3086-100000@simon.ratbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Sethman wrote:
> 
> On Sun, 3 Feb 2002, Dan Kegel wrote:
> >
> > But do you remember that this fd is ready until EWOULDBLOCK?
> > i.e. if you're notified that an fd is ready, and then you
> > don't for whatever reason continue to do I/O on it until EWOULDBLOCK,
> > you'll never ever be notified that it's ready again.
> > If your code assumes that it will be notified again anyway,
> > as with poll(), it will be sorely disappointed.
> 
> Yeah that was the problem and I figured out how to work around it in the
> code.  If you are interested I can point out the code we have been working
> with.

Yes, I would like to see it; is it part of the mainline undernet ircd cvs tree?
- Dan
