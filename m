Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313601AbSDPF0b>; Tue, 16 Apr 2002 01:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313603AbSDPF0a>; Tue, 16 Apr 2002 01:26:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22800 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S313601AbSDPF03>; Tue, 16 Apr 2002 01:26:29 -0400
Date: Tue, 16 Apr 2002 01:22:35 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <20020416024458.H26561@dualathlon.random>
Message-ID: <Pine.LNX.4.21.0204160117230.18902-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Apr 2002, Andrea Arcangeli wrote:

> On Mon, Apr 15, 2002 at 04:20:58PM -0700, William Lee Irwin III wrote:
> > I won't scream too loud, but I think it's pretty much done right as is.
> 
> Regardless if that's the cleaner implementation or not, I don't see
> much the point of merging those cleanups in 2.4 right now: it won't
> make any functional difference to users and it's only a self contained
> code cleanup,

Thats exactly why they can be merged easily: They are self contained code
cleanups, as you said.

> while other patches that make a runtime difference aren't merged yet.

They aren't merged yet because they are intrusive and, in your case (-aa
VM patches), they are not obviously correct and are hard to understand.

We're making progress, though. The writeout scheduling changes (which were
easy for me to understand) have been merged already.


