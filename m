Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSEYE2q>; Sat, 25 May 2002 00:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSEYE2q>; Sat, 25 May 2002 00:28:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55057 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313419AbSEYE2p>; Sat, 25 May 2002 00:28:45 -0400
Date: Fri, 24 May 2002 21:27:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Karim Yaghmour <karim@opersys.com>
cc: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205242059410.4177-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0205242124260.5385-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Linus Torvalds wrote:
>
> You know what? I don't care. If the RTAI people are trying to make it easy
> for non-GPL module people, I have absolutely zero interest.

[ Clarification: here "module" is not just "the thing you insert with
  insmod". In RTAI it's a mlock'ed user-level thing that has higher
  priority than the kernel, and can thus trivially crash the system.
  Whether it runs in CPL0 or CPL3 is immaterial at that point - a crash is
  a crash, and I'm not interested in systems where I cannot debug the
  thing that caused it ]

		Linus

