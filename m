Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262087AbSIYToO>; Wed, 25 Sep 2002 15:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262088AbSIYToO>; Wed, 25 Sep 2002 15:44:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36868 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262087AbSIYToN>; Wed, 25 Sep 2002 15:44:13 -0400
Date: Wed, 25 Sep 2002 12:52:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.4.44.0209252154010.18654-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0209251250150.2836-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Ingo Molnar wrote:
> 
> hm, then what is the standard way to make a new kernel option default-Y?  

There is none.

In fact, there _cannot_ be any these days, since all recent kernrels have 
stopped using defconfig entirely, and favour using /etc/kernel-config 
instead (making it much easier to have per-machine default 
configurations).

> At least for the development kernel, a default-enabled kksymoops sounds
> like the right way to go.

We can ask people to enable it if they can't get their oops reports 
together (and whether they get their oops reports in shape by using the 
user-space ksymoops or the kernel version really doesn't matter).

		Linus

