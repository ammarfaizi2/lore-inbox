Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbSJUDqv>; Sun, 20 Oct 2002 23:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264720AbSJUDqv>; Sun, 20 Oct 2002 23:46:51 -0400
Received: from dp.samba.org ([66.70.73.150]:39396 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264717AbSJUDqu>;
	Sun, 20 Oct 2002 23:46:50 -0400
Date: Mon, 21 Oct 2002 13:51:37 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       davej@suse.de, davem@redhat.com,
       "Guillaume Boissiere" <boissiere@adiglobal.com>, mingo@redhat.com
Subject: 2.6: Shortlist of Missing Features
Message-Id: <20021021135137.2801edd2.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0210201444460.8911-100000@serv>
References: <Pine.LNX.4.44L.0210192357430.22993-100000@imladris.surriel.com>
	<Pine.LNX.4.44.0210201444460.8911-100000@serv>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002 14:59:58 +0200 (CEST)
Roman Zippel <zippel@linux-m68k.org> wrote:
> But now would be a good time to recapitulate things which Linus might have
> forgotten in the patching frenzy.

Yes.  If we only consider new arch-independent features which are actively
being pushed at the moment and are feature complete, I get the following
(much stolen from Guilluame: thanks!):

- Build option for Linux Trace Toolkit (LTT)  (Karim Yaghmour)  
- Kernel Probes  (Vamsi Krishna S)
- High resolution timers  (George Anzinger, etc.)  
- EVMS (Enterprise Volume Management System)  (EVMS team)  
- Device Mapper (lvm2)	(Alasdair Kergon, Patrick Caulfield, Joe Thornber)
- New config system (Roman Zippel)
- In-kernel module loader (Rusty Russell)
- Unified boot/parameter support (Rusty Russell)
- Hotplug CPU removal (Rusty Russell)
- ext2/ext3 extended attribute & ACLs support (Ted Ts'o)

The rest (eg. hyperthread-aware scheduler, connection tracking optimizations)
don't really qualify as major new features as far as I can tell.

To ensure none of these get simply missed (rather than an actual decision
not to include them), it'd be nice to actually get "NAK"s once Linus gets
back.  And at least if we have a finite "possible" list, we can judge how
frozen we really are.

It's a relatively short list: how many am I missing?  (Dave?)
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
