Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVBOAUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVBOAUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVBOAUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:20:10 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:24030 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261391AbVBOATw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:19:52 -0500
Subject: Re: PATCH: Address lots of pending pm_message_t changes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Bernard Blackham <bernard@blackham.com.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050215001514.GB2116@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au>
	 <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
	 <1108418226.12611.75.camel@desktop.cunningham.myip.net.au>
	 <20050214220459.GM12235@elf.ucw.cz>
	 <1108418990.12611.86.camel@desktop.cunningham.myip.net.au>
	 <20050214234151.GA2134@elf.ucw.cz>
	 <1108426556.3666.1.camel@desktop.cunningham.myip.net.au>
	 <20050215001514.GB2116@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1108426918.3666.3.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 15 Feb 2005 11:21:58 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-02-15 at 11:15, Pavel Machek wrote:
> Hi!
> 
> > > > I guess I'm wrong then - I thought the other changes avoided compilation
> > > > errors.
> > > 
> > > Well, yes, if you switch pm_message_t into struct. But we are not yet
> > > ready to do that... it is going to be typedefed to u32 for 2.6.11...
> > 
> > Ah. So I haven't realised that Bernard took your patches wholesale,
> > which is why we're fixing the compile errors too :>
> > 
> > Okay then, I guess the whole thing isn't urgent then?
> 
> Well, it would be nice to be able to switch to struct pm_message_t
> very soon in 2.6.12 cycle, so that it actually works in 2.6.12...

Okay.. but it can wait until post 2.6.11, right?

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

