Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319266AbSHNSoP>; Wed, 14 Aug 2002 14:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319268AbSHNSoP>; Wed, 14 Aug 2002 14:44:15 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:23770 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S319266AbSHNSoO>; Wed, 14 Aug 2002 14:44:14 -0400
Date: Wed, 14 Aug 2002 19:47:02 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, hch@infradead.org, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
Message-ID: <20020814194702.B26404@kushida.apsleyroad.org>
References: <20020813164415.A11554@infradead.org> <Pine.LNX.4.44.0208131921020.4369-100000@localhost.localdomain> <20020814234824.08faf190.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020814234824.08faf190.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Wed, Aug 14, 2002 at 11:48:24PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> > btw., with the help of these syscalls and futexes, the layer between Linux
> > and pthreads became very thin - almost nonexistant in the majority of
> > cases.
> 
> Woohoo!

Yes, futexes are wonderful, if quite difficult to figure out at first.
(I still haven't understood why the futex example reader-writer locks are
they way are.)

Even things like waitpid() are potentially faster with futexes -- no pid
to lookup!

-- Jamie
