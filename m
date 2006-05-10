Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWEJHb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWEJHb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWEJHb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:31:26 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:2792 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964840AbWEJHb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:31:26 -0400
Date: Wed, 10 May 2006 09:31:23 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joshua Hudson <joshudson@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stability of 2.6.17-rc3?
In-Reply-To: <bda6d13a0605091340x2e16342v15733b2c9612d985@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0605100929450.27657@yvahk01.tjqt.qr>
References: <bda6d13a0605091340x2e16342v15733b2c9612d985@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Was hoping 2.6.17 would be out within one week, doesn't look like it
> is going to happen.
> My thesis defense is coming up, need to merge my patches against some kernel
> (requiring 2.6.16.1 looks weird).
>
Surprisingly I'm in the same position ^_^ Basing my patches on 2.6.16 makes 
a lot of changes produce compiler warnings again (e.g. due to changed 
prototypes in ipt_* matches and targets).

> On a machine that 2.6.16.1 runs bug-free, is it sane to assume
> 2.6.17-rc3 will as well?
> If it fails outright, I can revert, but if it is unstable I'm going to
> have some problems.
> (You would be surprised how long it took me to discover a mistake that
> sys_rename(on any filesystem) -> deadlock with my custom patch).

If it is a kernel problem, report it. If it is a problem of your patch, 
well, I suppose you need to fix it then. :/


Jan Engelhardt
-- 
