Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSLOWfz>; Sun, 15 Dec 2002 17:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSLOWfz>; Sun, 15 Dec 2002 17:35:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23570 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262924AbSLOWfy>; Sun, 15 Dec 2002 17:35:54 -0500
Date: Sun, 15 Dec 2002 23:43:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>, Pavel Machek <pavel@ucw.cz>,
       Mike Hayward <hayward@loup.net>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021215224348.GA30159@atrey.karlin.mff.cuni.cz>
References: <200212090830.gB98USW05593@flux.loup.net> <20021213154544.GK9882@holomorphy.com> <20021215215951.GA6347@elf.ucw.cz> <20021215223703.GA2690@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021215223703.GA2690@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> This is the same for me. I'm extremely uninterested in the P-IV for my
> >> own use because of this.
> 
> > Well, then you should fix the kernel so that syscalls are done by
> > sysenter (or how is it called).
> > 								Pavel
> 
> ABI is immutable. I actually run apps at home.

Perhaps that one killer app can be recompiled?

> sysenter is also unusable for low-level loss-of-state reasons mentioned
> elsewhere in this thread.

Well, disabling v86 may be well wroth it :-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
