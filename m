Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUDHWvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDHWvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:51:22 -0400
Received: from web40502.mail.yahoo.com ([66.218.78.119]:36904 "HELO
	web40502.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261786AbUDHWvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:51:18 -0400
Message-ID: <20040408225114.94370.qmail@web40502.mail.yahoo.com>
Date: Thu, 8 Apr 2004 15:51:14 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404080430.i384TvCw005203@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> > --- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > > Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> 
> [...]
> 
> > > > I started exactly with that. I found out
> shortly that
> > > > have no idea of functionality needed for such
> kind of
> > > > system.
> 
> > > Come back when you have found out.
> 
> > Sorry. I live in the real world. In 1999 I had
> servers
> > to protect. One of them was hacked and I started
> to
> > look for tools which could protect servers. I
> found
> > NOTHING. (there were some Intrusion Detection
> Systems,
> > which would alert you when your server was ALREADY
> > hacked - it was completely unacceptable for me).
> 
> We had an unwellcome visitor in 2001... scrapped
> SomeOtherUnix shortly
> thereafter (a "security fix" installed a "remote
> administration facility"
> (complete with an extremely nice, well-known hole),
> which the cracker then
> used to "remotely administer" our machine...), no
> further trouble since it
> is all Linux now. Just be careful in what you
> install, how you configure,
> and keep patches up to date.
> 
> I.e., a bit of common sense and care goes a _long_
> way. Security is mostly
> a _people_ affair, and has much to do with being
> careful and attention to
> detail, it is not at all technical. Trying to solve
> such a people problem
> with (misguided) technical measures gets you
> nowhere.

I completely agree with you on that. Security is not
only technical issues. I was an owner of the company
when our server was hacked, so I did all explanations
for down time with our customers. (Downtime was
significant - server was collocated in another country
and it took quite a while for reinstall Linux -
different time zone, nobody on 24x7 duty...).

Advice to apply all new patches is good, one should do
that. But there are problems:

1. One should monitor patch development constantly and
be paid for that job (additional expenses).
2. Will be patch available in time and would it be
possible to find it - there are questions.
3. Some patches are created after security hole was
exploited. I don't want to be among these first sites
:-)

So, even if you patched everything - there are
security holes anyway (patches will be developed in
the future). If it is not production server - not a
big deal. If it is production - downtimes should be
minimal and stealing of sensitive information is
unacceptable. If kernel is slow - I'll buy faster
hardware with SMP if needed - it's not an issue at
all. Not enough - I'll install cluster, but I can't
allow system to be compromised.

Serge.


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
