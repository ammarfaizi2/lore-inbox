Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbSJANCi>; Tue, 1 Oct 2002 09:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSJANCi>; Tue, 1 Oct 2002 09:02:38 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:21402 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261605AbSJANCh>;
	Tue, 1 Oct 2002 09:02:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave McCracken <dmccr@us.ibm.com>,
       "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Page table sharing
Date: Tue, 1 Oct 2002 15:08:12 +0200
X-Mailer: KMail [version 1.3.2]
References: <200209252013.17714.gjwucherpfennig@gmx.net> <59570000.1032979211@baldur.austin.ibm.com>
In-Reply-To: <59570000.1032979211@baldur.austin.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wMl3-0005tY-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 September 2002 20:40, Dave McCracken wrote:
> --On Wednesday, September 25, 2002 20:12:36 +0200 "Gerold J. Wucherpfennig"
> <gjwucherpfennig@gmx.net> wrote:
> 
> > What about page table sharing? Does anybody still care about this?
> > 
> > The patch from Daniel Phillips
> > (http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35)
> > is a few month old and I can't see any progress.
> > 
> > Sorry, I'm not a kernel expert, so I can't help.
> > But page table sharing is still listed as betaware at the
> > Linux Kernel 2.5 Status page (http://kernelnewbies.org/status/latest.html)
> > and Page Table sharing isn't marked post Halloween.
> > 
> > Some comments from Daniel Phillips or Dave McCracken?
> 
> I'm working on it.  I sent out a patch to the mm list a few weeks ago, but
> it didn't have the locking right.  I'm in the proces of finishing an
> improved version with new locking.  I'll send a snapshot of it out when I
> can make it stop oopsing :)

Hi Dave,

I'm not sure how relevant page table sharing has to the halloween deadline
since it's not a feature per se, just an optimization.   It has more to do
with getting numa ia32 boxes to survive, so it's an ideal out-of-tree patch.

Anyway, I feel your pain - debugging these deep VM hacks can get very weird.
I just got back home, I'll have a read through your latest.

-- 
Daniel
