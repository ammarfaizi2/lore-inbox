Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261263AbSJLPXL>; Sat, 12 Oct 2002 11:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbSJLPXL>; Sat, 12 Oct 2002 11:23:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:32782 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261263AbSJLPXK>; Sat, 12 Oct 2002 11:23:10 -0400
Date: Sat, 12 Oct 2002 17:28:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Pavel Machek <pavel@ucw.cz>, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: make idedisk_suspend()/idedisk_resume() conditional on CONFIG_SOFTWARE_SUSPEND
Message-ID: <20021012152857.GA23254@atrey.karlin.mff.cuni.cz>
References: <20021011182209.GA8046@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0210111831060.10081-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210111831060.10081-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Notice that Patrick broke ide on bitkeeper.... So if you wonder how it
can work in bk-current... It does not. In 2.5.41 it should be okay.

> On Fri, 11 Oct 2002, Pavel Machek wrote:
> 
> > It is handled by driver model layer, at least in 2.5.41. Do you see a
> > way how to integrate it more closely? 
> 
> Actually Pavel, what i'm boggling over is the existence of kernel/pm.c and 
> drivers/base/pm.c and its somewhat odd coexistence in the extra device 
> management code in suspend.c
> 
> 	Zwane lost-in-a-maze-of-device-management Mwaikambo
> 

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
