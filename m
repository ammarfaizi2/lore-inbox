Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272113AbRHXPDi>; Fri, 24 Aug 2001 11:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272114AbRHXPD2>; Fri, 24 Aug 2001 11:03:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44559 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S272113AbRHXPDS>; Fri, 24 Aug 2001 11:03:18 -0400
Date: Fri, 24 Aug 2001 17:03:34 +0200
From: Martin Mares <mj@ucw.cz>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem with includes: pc_keyb.h
Message-ID: <20010824170334.A9055@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3B866B52.508CF2C6@pcsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B866B52.508CF2C6@pcsystems.de>; from nicos@pcsystems.de on Fri, Aug 24, 2001 at 04:57:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I tried to include pc_keyb.h into my project, but it fails:
> 
> In file included from test_pc_keybh.c:1:
> /usr/include/linux/pc_keyb.h:127: parse error before `wait_queue_head_t'
> 
> /usr/include/linux/pc_keyb.h:127: warning: no semicolon at end of struct
> or union
> /usr/include/linux/pc_keyb.h:130: parse error before `}'
> 
> I tried to include linux/sched.h before, but that didn't work either
> (seems to have problems with sys/time.h).
> 
> What to do ?

<linux/pc_keyb.h> is a kernel include which shouldn't be included
by user-space code. What parts of it do you need?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
How an engineer writes a program: Start by debugging an empty file...
