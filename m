Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbTAKOkf>; Sat, 11 Jan 2003 09:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbTAKOkf>; Sat, 11 Jan 2003 09:40:35 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34316 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267255AbTAKOkd>; Sat, 11 Jan 2003 09:40:33 -0500
Date: Sat, 11 Jan 2003 09:46:23 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Another idea for simplifying locking in kernel/module.c
In-Reply-To: <Pine.LNX.4.10.10301100138270.31168-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.96.1030111094350.8637B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Andre Hedrick wrote:

> 
> I'll bite .... what the flip is [unsafe] ??

Actually, I believe it means the modules doesn't use try_module_get
instead of the old I_cant_remember_the_name macro.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

