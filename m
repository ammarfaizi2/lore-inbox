Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSEYF4l>; Sat, 25 May 2002 01:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313690AbSEYF4k>; Sat, 25 May 2002 01:56:40 -0400
Received: from dsl-213-023-038-075.arcor-ip.net ([213.23.38.75]:7371 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313687AbSEYF4j>;
	Sat, 25 May 2002 01:56:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Karim Yaghmour <karim@opersys.com>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Sat, 25 May 2002 07:53:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205242124260.5385-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17BUUw-0003Ui-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 May 2002 06:27, Linus Torvalds wrote:
> On Fri, 24 May 2002, Linus Torvalds wrote:
> >
> > You know what? I don't care. If the RTAI people are trying to make it easy
> > for non-GPL module people, I have absolutely zero interest.
> 
> [ Clarification: here "module" is not just "the thing you insert with
>   insmod". In RTAI it's a mlock'ed user-level thing that has higher
>   priority than the kernel, and can thus trivially crash the system.
>   Whether it runs in CPL0 or CPL3 is immaterial at that point - a crash is
>   a crash, and I'm not interested in systems where I cannot debug the
>   thing that caused it ]

This issue is easily dealt with by requiring root for the rt_task_init
call.

As for debugging the thing, Linus doth protest too much.

-- 
Daniel
