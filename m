Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTDXHsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTDXHs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:48:27 -0400
Received: from mail.gmx.net ([213.165.65.60]:52390 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261707AbTDXHsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:48:22 -0400
Date: Thu, 24 Apr 2003 10:00:24 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030424100024.5b58fcdd.gigerstyle@gmx.ch>
In-Reply-To: <1051136725.4439.5.camel@laptop-linux>
References: <20030423135100.GA320@elf.ucw.cz>
	<Pine.GSO.4.21.0304231631560.1343-100000@vervain.sonytel.be>
	<20030423144705.GA2823@elf.ucw.cz>
	<20030423175629.7cfc9087.gigerstyle@gmx.ch>
	<1051126871.1893.35.camel@laptop-linux>
	<20030423223639.7cc6a796.gigerstyle@gmx.ch>
	<1051136725.4439.5.camel@laptop-linux>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

On Thu, 24 Apr 2003 10:25:25 +1200
Nigel Cunningham <ncunningham@clear.net.nz> wrote:

> 
> 
> On Thu, 2003-04-24 at 08:36, Marc Giger wrote:
> > Ok! I see the advantages / disadvantages of each version. But what
> > happens if the memory AND swap space are full and nothing can't be
> > freed? When I watch the memory and swap consumption on my laptop, I
> > think it's the most time the case...
> 
> If you're getting yourself in that situation, you should be increasing
> your swap space (and memory if possible) anyway.

Yeah, you are right but it was always enough. It was rarely the case that something got killed...I can't install more ram, 256MB is the maximum:-( and i don't want to repartition my harddisk..(~250MB swap)

> 
> > Another question:
> > Is it a big problem to save the memory in a separate file on the file
> > system, and save somewhere the pointer to it (as example in swap. Also
> > we could set a flag in swap so that we now that the last shutdown was
> > a hybernation). One Problem will be, that we don't know the filesystem
> > type on resume...(We could save the module in swap...)
> > All that is just theoretical. It's only a idea.
> 
> I guess the simplest answer is would it be worth the pain? Since disk
> space is cheap, it just requires a little forethought when installing
> Linux, to ensure enough swap is allocated. I certainly understand that
> using a file rather than swap makes adjusting the amount of space
> available easier, but as you rightly acknowledge, it does complicate
> things a fair bit more.

Yes I see, but there are a lot of users (like me) who has an already installed Linux and don't want to repartition the disk and reinstall it. Repartitioning Programs success is not always guaranteed...

Marc
