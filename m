Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273424AbRI0Ptg>; Thu, 27 Sep 2001 11:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273448AbRI0PtT>; Thu, 27 Sep 2001 11:49:19 -0400
Received: from mx3out.umbc.edu ([130.85.253.53]:45443 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S273440AbRI0PtF>;
	Thu, 27 Sep 2001 11:49:05 -0400
Date: Thu, 27 Sep 2001 11:49:30 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: "George R. Kasica" <georgek@netwrx1.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10
In-Reply-To: <vsg6rto5cqtmj8dld5mc41mpvlbrf4s9vl@4ax.com>
Message-ID: <Pine.SGI.4.31L.02.0109271145190.5561307-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, George R. Kasica wrote:

> I'm currently running 2.4.5 here and I'm considering 2.4.10 but am
> somewhat more nervous about this release than others based on the
> number of reports of problems I'm seeing...
>
> What would be the advice of others in terms of moving up from 2.4.5
> which has been rock solid here?
>
> Would you recommend doing the upgrade or waiting for 2.4.11 or is
> there a middle ground release (2.4.6,7,8,9) that you'd recommend.

2.4.4 was the last kernel to pass the first stage of internal validation
where I work. (Okay, the first stage is me. :P). And the last to make it
out to the developers.

2.4.5 was pulled because of lkml reports of panics when unmounting
filesystems, and 2.4.7-9 all died or skrewed up on my test battery (a
couple of dd's to /dev/null, ping -f localhost, make -j32 && make modules
-j32 in /usr/src/linux)

2.4.10 just passed the first stage, and is entering the second stage of
evaluation, of which I know not what they do to it.

I'd say try it on a non-production system, beat on it for a while, and see
what comes out ...


--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

