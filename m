Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268093AbTBYRZy>; Tue, 25 Feb 2003 12:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268095AbTBYRZy>; Tue, 25 Feb 2003 12:25:54 -0500
Received: from [195.223.140.107] ([195.223.140.107]:52358 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268093AbTBYRZx>;
	Tue, 25 Feb 2003 12:25:53 -0500
Date: Tue, 25 Feb 2003 18:37:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Server shipments [was Re: Minutes from Feb 21 LSE Call]
Message-ID: <20030225173711.GO29467@dualathlon.random>
References: <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <1630000.1046072374@[10.10.2.4]> <20030224161716.GC5665@work.bitmover.com> <12680000.1046105345@[10.10.2.4]> <20030225004113.GB12146@work.bitmover.com> <351250000.1046133664@flay> <20030225005451.GC12146@work.bitmover.com> <9340000.1046142041@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9340000.1046142041@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 07:00:42PM -0800, Martin J. Bligh wrote:
> Solaris et al failed was because the development model was different? 

Solaris can't be recompiled UP AFIK. This whole discussion about UP
performance is almost pointless in linux since we have CONFIG_SMP and we
can recompile it.

Especially if what you care is the desktop (not the UP server), the only
kernel bits that matters for the desktop are the VM, the scheduler and
I/O latency and perpahs the clear_page too.  the rest is all a matter of
the X/kde/qt/glibc-dynamiclinking/opengl/memorybloatwithmultiplelibs/etc..
the kernel core-raw performance in the fast paths doesn't matter much for the
desktop, even if the syscall would be twice slower desktop users
wouldn't notice much.

Andrea
