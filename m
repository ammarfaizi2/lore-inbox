Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269168AbRHBWBv>; Thu, 2 Aug 2001 18:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269171AbRHBWBl>; Thu, 2 Aug 2001 18:01:41 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:56335 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S269168AbRHBWBf> convert rfc822-to-8bit; Thu, 2 Aug 2001 18:01:35 -0400
Subject: Re: Ongoing 2.4 VM suckage
From: Miles Lane <miles@megapathdsl.net>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: Jakob =?ISO-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108021448400.21298-100000@heat.gghcwest.com>
In-Reply-To: <Pine.LNX.4.33.0108021448400.21298-100000@heat.gghcwest.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 02 Aug 2001 14:56:29 -0700
Message-Id: <996789389.12934.25.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Aug 2001 14:52:11 -0700, Jeffrey W. Baker wrote:
> On Thu, 2 Aug 2001, Jakob Østergaard wrote:
> 
> > You fill up mem and you fill up swap, and you complain the box is
> > acting funny ??
> 
> The kernel should save whatever memory it needs to do its work.  It isn't
> my problem, from userland, to worry that I take the last page in the
> machine.  If the kernel needs pages to operate efficiently, it had better
> reserve them and not just hand them out until it locks up.
> 
> > This is a clear case of "Doctor it hurts when I ..."  - Don't do it !
> >
> > I'm interested in hearing how you would accomplish graceful
> > performance degradation in a situation where you have used up any
> > possible resource on the machine.  Transparent process back-tracking ?
> > What ?
> 
> Gosh, here's an idea: if there is no memory left and someone malloc()s
> some more, have malloc() fail?  Kill the process that required the memory?
> I can't believe the attitude I am hearing.  Userland processes should be
> able to go around doing whaever the fuck they want and the box should stay
> alive.  Currently, if a userland process runs amok, the kernel goes into
> self-fucking mode for the rest of the week.

Hmm.  What about the OOM process killer?  Shouldn't that kick in?

	Miles

