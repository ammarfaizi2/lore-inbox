Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSJPQFJ>; Wed, 16 Oct 2002 12:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSJPQFJ>; Wed, 16 Oct 2002 12:05:09 -0400
Received: from packet.digeo.com ([12.110.80.53]:54527 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265134AbSJPQFI>;
	Wed, 16 Oct 2002 12:05:08 -0400
Message-ID: <3DAD8F91.FA93860E@digeo.com>
Date: Wed, 16 Oct 2002 09:10:57 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@fenrus.demon.nl>
CC: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       NPT library mailing list <phil-list@redhat.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mmap-speedup-2.5.42-C3
References: <Pine.LNX.4.44.0210160751260.2181-100000@home.transmeta.com> <1034783351.4287.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 16:10:57.0814 (UTC) FILETIME=[9CB97360:01C2752E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> On Wed, 2002-10-16 at 16:52, Linus Torvalds wrote:
> \
> > > i think it should be unrelated to the mmap patch. In any case, Andrew
> > > added the mmap-speedup patch to 2.5.43-mm1, so we'll hear about this
> > > pretty soon.
> >
> > There's at least one Oops-report on linux-kernel on 2.5.43-mm1, where the
> > oops traceback was somewhere in munmap().
> >
> > Sounds like there are bugs there.
> 
> could be the shared pagetable stuff just as well ;(
> 

Yes, Matt had shared pagetables enabled.  That code is not stable yet.
