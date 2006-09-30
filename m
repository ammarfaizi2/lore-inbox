Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWI3Wv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWI3Wv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWI3Wv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:51:26 -0400
Received: from xenotime.net ([66.160.160.81]:729 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751626AbWI3WvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:51:25 -0400
Date: Sat, 30 Sep 2006 15:52:50 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Cc: "Stefan Richter" <stefanr@s5r6.in-berlin.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 V6] drivers: add lcd display support
Message-Id: <20060930155250.8cae208b.rdunlap@xenotime.net>
In-Reply-To: <653402b90609301545y2d4f162dq824ac360149fc0a7@mail.gmail.com>
References: <20060930132253.8ccaa0ad.maxextreme@gmail.com>
	<20060930123547.d055383f.rdunlap@xenotime.net>
	<451EE36C.5080002@s5r6.in-berlin.de>
	<20060930144830.eba63268.rdunlap@xenotime.net>
	<653402b90609301545y2d4f162dq824ac360149fc0a7@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 22:45:56 +0000 Miguel Ojeda wrote:

> Randy, I'm testing right now the V7 of the driver after fixing all
> your mistakes found. Thank you for your deep work: the sharing of the
> buffer was a very good point. Finally I allocated both 2 (the bigger
> and the smaller one at the initialization).
> 
> In a few minutes I will send the V7 patch.
> 
> About "lcdisplay":
> 
> On 9/30/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > On Sat, 30 Sep 2006 23:36:44 +0200 Stefan Richter wrote:
> >
> > > ...
> > > >> patching file drivers/lcddisplay/cfag12864b.c
> > > ...
> > >
> > > What does the D in LCD stand for? I suggest this is named
> > > drivers/lcdisplay/ instead.
> >
> > Yes, someone else mentioned that too.
> > It does mean Display.
> > not a big deal to me in this age of acronyms.
> >
> 
> Well, I can rename it, but there is a problem:
> 
> How should I write the name in other places?
> 
> I mean, for example, in Kconfig:
> 
> 	tristate "KS0108 LCD Controller"
> 
> if the ks0108 is a LCD controller, then
> 
> 	tristate "CFAG12864B LCD Display"

That seems very common to me.

> should be the right way to write it?
> 
> 	tristate "CFAG12864B LCDisplay"
> 
> seems so ugly to me. Is it? Remember, this applies for all the other
> places in the documentation / source code / ...
> 
> IMHO it seems better as LCD Display. Yeah, drivers/lcdisplay/ would be
> nice, but I don't think the same about other places:
> 
> LCD Controller.

OK

> LCDisplay??

I would continue to use LCD display (small d).

---
~Randy
