Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbTEORyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTEORyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:54:41 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6158 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264133AbTEORyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:54:40 -0400
Date: Thu, 15 May 2003 14:00:50 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Christopher Hoover <ch@murgatroid.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <3EC3D247.20609@redhat.com>
Message-ID: <Pine.LNX.3.96.1030515135628.30631A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Ulrich Drepper wrote:

> Ingo Oeser wrote:
> 
> > Is this also the case, if I don't want threading at all on my
> > system? Does glibc still have a seperate static library for this,
> 
> This has nothing to do with static linking or not.
> 
> glibc, when compiled with nptl, will always include uses of futexes.
> But since there is no contention and the fast path is entirely handled
> at userlevel, the actual kernel functionality is not required.

He didn't say static linking he said static library. I assume he meant a
.a lib instead of a .so lib. One which has elements which are made part of
the executable instead of being part of a shared library.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

