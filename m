Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284924AbRLPX0i>; Sun, 16 Dec 2001 18:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284918AbRLPX03>; Sun, 16 Dec 2001 18:26:29 -0500
Received: from flrtn-2-m1-236.vnnyca.adelphia.net ([24.55.67.236]:1193 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S284916AbRLPX0V>;
	Sun, 16 Dec 2001 18:26:21 -0500
Message-ID: <3C1D2D98.26775300@pobox.com>
Date: Sun, 16 Dec 2001 15:26:16 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Schrotenboer <adam@tabris.net>, Robert Love <rml@tech9.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is /dev/shm needed?
In-Reply-To: <E16FjME-0000WW-00@DervishD.viadomus.com> <1008541849.11242.2.camel@phantasy> <20011216231358.99830FB80D@tabris.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Schrotenboer wrote:

> On Sunday 16 December 2001 17:30, Robert Love wrote:
> > In other words, if you have memory to spare and the data ought to be
> > cached, Linux probably will cache it anyhow.  On the other hand, if you
> > have lots of memory to spare, give it a try.  Mount /tmp or all of /var
> > in tmpfs.
>
> Unfortunately, some(many?) distros are b0rken in re /var/. There is stuff put
> there that is needed across boots (for example, mandrake puts the DNS master
> files in /var/named.)

It's not just mandrake, it's all linux and in
fact that's where the named data wants to
live -

Not only dns info, but things like mail spool,
system logs, cron files -

And it's not just linux, it's pretty much a unix
thing in general -

Are you really sure you want to blow away
everyone's mail, all your dns records, cron
jobs etc if the system powers down?

cu

jjs

