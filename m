Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbTBGTn4>; Fri, 7 Feb 2003 14:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTBGTn4>; Fri, 7 Feb 2003 14:43:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:34953 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266806AbTBGTnE>;
	Fri, 7 Feb 2003 14:43:04 -0500
Date: Fri, 7 Feb 2003 11:52:37 -0800
From: Andrew Morton <akpm@digeo.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@elte.hu
Subject: Re: 2.5.59-mm9
Message-Id: <20030207115237.7f58e69e.akpm@digeo.com>
In-Reply-To: <20030207141114.GA31151@nevyn.them.org>
References: <20030207013921.0594df03.akpm@digeo.com>
	<20030207030350.728b4618.akpm@digeo.com>
	<20030207141114.GA31151@nevyn.them.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2003 19:52:37.0453 (UTC) FILETIME=[7704CFD0:01C2CEE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz <dan@debian.org> wrote:
>
> On Fri, Feb 07, 2003 at 03:03:50AM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@digeo.com> wrote:
> > >
> > > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm9/
> > 
> > I've taken this down.
> > 
> > Ingo, there's something bad in the signal changes in Linus's current tree.
> > 
> > mozilla won't display, and is unkillable:
> 
> Yeah, I'm seeing hangs in rt_sigsuspend under GDB also.  Thanks for
> saying that they show up without ptrace; I hadn't been able to
> reproduce them without it.
> 
> Something is causing realtime signals to drop.

OK.  Looks like Linus is hot on the trail.

BTW, some nice people have been sending in smalldevfs testing results
(successful).  I've put that patch back up at

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/smalldevfs.patch

for other testers.  It applies to 2.5.59 base.

And it is not clear why I copied Ingo on the signal thing, when it is not he
who is working that code.  Sorry about that.

