Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbUDFWGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUDFWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:06:26 -0400
Received: from web40513.mail.yahoo.com ([66.218.78.130]:57421 "HELO
	web40513.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264031AbUDFWFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:05:23 -0400
Message-ID: <20040406220521.56509.qmail@web40513.mail.yahoo.com>
Date: Tue, 6 Apr 2004 15:05:21 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Timothy Miller <miller@techsource.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40731A02.5030502@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Timothy Miller <miller@techsource.com> wrote:
> 
> 
> Horst von Brand wrote:
> 
> > OK, so you need the policy to be interpreted
> in-kernel (dunno why a
> > largeish high-level general purpose language is
> needed for that, when a
> > tiny interpreter for a specialized language will
> do very well, and has been
> > shown to work fine), and written in a "high level
> language" so that your
> > garden variety sysadmin _can_ write her own
> policy, but it really doesn't
> > matter because she'll never have to do so...
> > 
> > Completely lost me.
> 
> I was getting hung up on that one too, but I didn't
> know how to say it. 
>   You did a nice job.  :)

Can you guys be more specific? I don't see any
technical objections. The only one is that performance
would suffer because of use of higher level language
than C or Assembler.

There is a reason people use languages like PERL, Java
and so on. I would prefer to spend less time writing
actual code - this is what these high level languages
for. If performance would be most important - people
would do everything in Assembler, but they don't. I'd
better write a small Assembler subroutine which will
handle stack problems for me and benefit from using
the high level language after that.

There were times when userland projects were written
in Assembler. Now people are using other languages,
too. May be it's time to try something new in the
kernel, too :-) Or we will not consider that because
nobody did that before? Someone should be the first
:-)

Serge.


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
