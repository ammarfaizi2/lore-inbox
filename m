Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280583AbRKJSqZ>; Sat, 10 Nov 2001 13:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280585AbRKJSqP>; Sat, 10 Nov 2001 13:46:15 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:1668 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S280583AbRKJSqM>;
	Sat, 10 Nov 2001 13:46:12 -0500
Message-ID: <3BED75E8.F87460A9@pobox.com>
Date: Sat, 10 Nov 2001 10:46:00 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Kirkwood <matthew@hairy.beasts.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Networking: repeatable oops in 2.4.15-pre2
In-Reply-To: <Pine.LNX.4.33.0111101148250.20176-100000@sphinx.mythic-beasts.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood wrote:

> On Fri, 9 Nov 2001, J Sloan wrote:
>
> > I have been running the 2.4.15-pre kernels and
> > have found an interesting oops. I can reproduce
> > it immediately, and reliably, just by issuing an ssh
> > command (as a normal user).
>
> I'm seeing the same thing on my gateway,

Good to know it's not just me!


> I am back to 2.4.10 for now.

2.4.14 runs fine here, much faster than 2.4.10

> My setup:
>
> K6-200 w/64 MB RAM
> Debian Woody
> a 3c905B and an RTL-8139

Excellent, that rules out CPU specifics, distro
specifics, and ethernet adapter specifics -

> using iptables and transparent proxying (no masq).

Aha, we are both using iptables - (I am using nat)

Rusty, I hope you are reading this.

> >  <0>Kernel panic: Aiee, killing interrupt handler!
>
> I haven't decoded the oops, but I'm certainly seeing this
> line.

Good info, thanks for your input.

cu

jjs

