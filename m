Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319076AbSH2CZ6>; Wed, 28 Aug 2002 22:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319079AbSH2CZ6>; Wed, 28 Aug 2002 22:25:58 -0400
Received: from dp.samba.org ([66.70.73.150]:42371 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319076AbSH2CZ5>;
	Wed, 28 Aug 2002 22:25:57 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] "fully HT-aware scheduler" support, 2.5.31-BK-curr 
In-reply-to: Your message of "Wed, 28 Aug 2002 19:16:31 +0200."
             <Pine.LNX.4.44.0208281914100.2647-100000@localhost.localdomain> 
Date: Thu, 29 Aug 2002 11:28:16 +1000
Message-Id: <20020828213041.1BB3E2C152@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0208281914100.2647-100000@localhost.localdomain> you 
write:
> 
> On Wed, 28 Aug 2002, Rusty Russell wrote:
> 
> > >  - HT-aware affinity.
> > > 
> > >    Tasks should attempt to 'stick' to physical CPUs, not logical CPUs.
> > 
> > Linus disagreed with this before when I discussed it with him, and with
> > the current (stupid, non-portable, broken) set_affinity syscall he's
> > right.
> 
> actually, affinity still works just fine, users can bind tasks to logical
> CPUs as well. What i meant was the affinity logic of the scheduler (ie.  
> affinity decisions done by the scheduler), not the externally visible
> affinity API.

My bad.  I'll shut up now, and read the patch.

Sorry,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
