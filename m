Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTKWIUk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 03:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTKWIUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 03:20:40 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:57359 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S263258AbTKWIUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 03:20:39 -0500
Date: Sun, 23 Nov 2003 09:20:16 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4: page allocation failure. order 3, mode 0x20
Message-ID: <20031123082016.GA20062@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20031121060545.GA6847@middle.of.nowhere> <20031120222616.6028d321.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120222616.6028d321.akpm@osdl.org>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, Nov 20, 2003 at 10:26:16PM -0800
> Jurriaan <thunder7@xs4all.nl> wrote:
> >
> >  After several runs of cdda2wav I get this message:
> > 
> >  Nov 21 07:03:34 middle kernel: cdda2wav: page allocation failure. order:3, mode:0x20
> >  Nov 21 07:03:34 middle last message repeated 36 times
> > 
> > ...
> > 
> >  I ran cdda2wav a lot more under 2.9.0-test9-mm3 and didn't see this
> >  message.
> 
> Are you sure you were running -mm4 and not Linus's kernel?  -mm has a tweak
> for this, and it was present in -mm4.

I was running -mm4, sure.

> 
> It would help to add this patch; maybe the allocation is coming from
> somewhere else.
> 
Unfortunately, I've been unable to reproduce it, even when running the
same programs as I remembered running at that time.

Jurriaan
-- 
> What does ELF stand for (in respect to Linux?)
ELF is the first rock group that Ronnie James Dio performed with back in 
the early 1970's.  In constrast, a.out is a misspelling	 of the French word 
for the month of August.  What the two have in common is beyond me, but 
Linux users seem to use the two words together.
	seen on c.o.l.misc
Debian (Unstable) GNU/Linux 2.6.0-test9-mm4 4259 bogomips 0.59 0.36
