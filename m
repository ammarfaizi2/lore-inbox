Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSG2Lk2>; Mon, 29 Jul 2002 07:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSG2Lk2>; Mon, 29 Jul 2002 07:40:28 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56588 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315374AbSG2Lk1>; Mon, 29 Jul 2002 07:40:27 -0400
Date: Mon, 29 Jul 2002 07:37:50 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Shaya Potter <spotter@cs.columbia.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: file descriptor passing (jail related question)
In-Reply-To: <1027115899.2161.110.camel@zaphod>
Message-ID: <Pine.LNX.3.96.1020729073459.30577A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jul 2002, Shaya Potter wrote:

> If it can be transmited over IP, its a much more serious issue, as all
> one has to do is crack a jail (root inside the jail), crack the local
> system (regular user) run a program that talks to the local system over
> ip, and have the cracked regular user pass a fd in.

But of course you would have no more access outside the jail than the
cracked user. I would expect connections into the jail to behave as if
they were on another machine, which would prevent fd passing. At least the
last time I played with fd passing it didn't work between machines, that
may have been a bug rather than a security features, of course.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

