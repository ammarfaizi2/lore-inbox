Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289732AbSAPB6i>; Tue, 15 Jan 2002 20:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289802AbSAPB62>; Tue, 15 Jan 2002 20:58:28 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:29966 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289732AbSAPB6T>; Tue, 15 Jan 2002 20:58:19 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Jan 2002 18:04:21 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Robert Love <rml@tech9.net>
cc: Ingo Molnar <mingo@elte.hu>, Ed Tomlinson <tomlins@cam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
In-Reply-To: <1011146349.8756.63.camel@phantasy>
Message-ID: <Pine.LNX.4.40.0201151803020.940-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 2002, Robert Love wrote:

> On Tue, 2002-01-15 at 21:48, Ingo Molnar wrote:
>
> > there is a way: renicing. Either use nice +19 on the compilation job or
> > use nice -5 on the 'known good' tasks. Perhaps we should allow a nice
> > decrease of up to -5 from the default level - and things like KDE or Gnome
> > could renice interactive tasks, while things like compilation jobs would
> > run on the default priority.
>
> This isn't a bad idea, as long as we don't use it as a crutch or
> excuse.  That is, answer scheduling problems with "properly nice your
> tasks" -- the scheduler should be smart enough, to some degree.
>
> FWIW, Solaris actually implements a completely different scheduling
> policy, SCHED_INTERACT or something.  It is for windowed tasks in X --
> they get a large interactivity bonus.

Now ( with 2.5.3-pre1 ) intractivity is *very good* but SCHED_INTERACT
would help *a lot* to get things even more right.




- Davide


