Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131501AbQKRWaR>; Sat, 18 Nov 2000 17:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131519AbQKRWaH>; Sat, 18 Nov 2000 17:30:07 -0500
Received: from [194.213.32.137] ([194.213.32.137]:5636 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131356AbQKRW3x>;
	Sat, 18 Nov 2000 17:29:53 -0500
Message-ID: <20001118214418.C382@bug.ucw.cz>
Date: Sat, 18 Nov 2000 21:44:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116150704.A883@emma1.emma.line.org> <20001116171618.A25545@athlon.random> <20001116115249.A8115@wirex.com> <20001117003000.B2918@wire.cadcamlab.org> <20001117112336.A8854@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001117112336.A8854@wirex.com>; from jesse on Fri, Nov 17, 2000 at 11:23:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Two easy "get out of jail free" cards.  There are other, more complex
> > exploits.  You have added one more.  They all require root privileges.
> 
> Actually, I've heard that a chrooted _non-root_ process can find another
> process with the same uid that's not chrooted and can ptrace() to pull
> itself out of the jail.

Right. Once you have same uid as someone else, you have basically his
priviledges if you chooseto.

> I'd imagine dropping CAP_SYS_PTRACE would avoid this, though.

Pardon me, but CAP_SYS_PTRACE is not required for tracing processes of
same UID. 
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
