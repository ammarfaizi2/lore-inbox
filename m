Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbRLGUoY>; Fri, 7 Dec 2001 15:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285518AbRLGUoO>; Fri, 7 Dec 2001 15:44:14 -0500
Received: from 24-28-205-10.mf3.cox.rr.com ([24.28.205.10]:24070 "EHLO
	24-28-205-10.mf3.cox.rr.com") by vger.kernel.org with ESMTP
	id <S285516AbRLGUoC>; Fri, 7 Dec 2001 15:44:02 -0500
To: linux-kernel@vger.kernel.org
Path: 24-28-205-10.mf3.cox.rr.com!not-for-mail
From: gsh@cox.rr.com (Greg Hennessy)
Newsgroups: list.linux
Subject: Re: horrible disk thorughput on itanium
Date: Fri, 7 Dec 2001 20:44:05 +0000 (UTC)
Organization: A InterNetNews site
Message-ID: <9ur9ml$5jp$1@24-28-205-10.mf3.cox.rr.com>
In-Reply-To: <Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>
NNTP-Posting-Host: localhost
X-Trace: 24-28-205-10.mf3.cox.rr.com 1007757845 5754 127.0.0.1 (7 Dec 2001 20:44:05 GMT)
X-Complaints-To: news@24-28-205-10.mf3.cox.rr.com
NNTP-Posting-Date: Fri, 7 Dec 2001 20:44:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>,
Linus Torvalds <torvalds@transmeta.com> wrote:
> bonnie is a _benchmark_. It's meant for finding bad performance. Changing
> it to make it work better when performance is bad is _pointless_. You've
> now made the whole point of bonnie go away.

It isn't just bonnie showing bad performance. My application shows it,
bonnie shows it, and tiobench shows it. I think the focus on putc
may be too intense. It isn't suprizing to me that either the kernel
or glibc may not be optimised on ia64, I'm just trying to figure out
how to get better io rates out of my itanium machine.



