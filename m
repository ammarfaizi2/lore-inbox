Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288810AbSBKMJm>; Mon, 11 Feb 2002 07:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288930AbSBKMJc>; Mon, 11 Feb 2002 07:09:32 -0500
Received: from dialin-145-254-129-082.arcor-ip.net ([145.254.129.82]:6148 "EHLO
	dale.home") by vger.kernel.org with ESMTP id <S288810AbSBKMJP>;
	Mon, 11 Feb 2002 07:09:15 -0500
Date: Mon, 11 Feb 2002 12:59:02 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-pre8-K2: Kernel panic: CPU context corrupt
Message-ID: <20020211125902.B3342@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20020208001831.A200@steel> <20020208003653.A28235@suse.de> <20020209222358.GA1589@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020209222358.GA1589@elf.ucw.cz>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can good understand that it is a hardware problem.
But if someone seems not to be interested in reports like this,
why dump them out? Just save what we can and hang silently,
but no reports, they're boring 8-]


What does the "Bank 4: b200000000040151" mean?
If that is a memory, can anyone help to find out which slot it is?
(memtest86 haven't found anything, btw, i doubt that counts)
-alex

P.S. if someone going to change the message about machine check,
could you please avoid lame descriptions? Like "(hardware problem!)"?
I sure the majority are experienced enough to understand what the
words "Machine Check" mean.


On Sat, Feb 09, 2002 at 11:23:58PM +0100, Pavel Machek wrote:
> Hi!
> 
> >  > Feb  7 23:45:31 steel kernel: CPU 0: Machine Check Exception: 0000000000000004
> >  > Feb  7 23:45:31 steel kernel: Bank 4: b200000000040151
> >  > Feb  7 23:45:31 steel kernel: Kernel panic: CPU context corrupt
> > 
> >  Machine checks are indicative of hardware fault.
> >  Overclocking, inadequate cooling and bad memory are the usual
> > causes.
> 
> Maybe you should print something like
> 
> Machine Check Exception: .... (hardware problem!)
> 
> so that we get less reports like this?
> 									Pavel
> -- 
> (about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
> no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
