Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274341AbRITGky>; Thu, 20 Sep 2001 02:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274343AbRITGko>; Thu, 20 Sep 2001 02:40:44 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:40105 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274341AbRITGki>; Thu, 20 Sep 2001 02:40:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@ufl.edu>, Roger Larsson <roger.larsson@norran.net>
Subject: Re: Feedback on preemptible kernel patch
Date: Thu, 20 Sep 2001 08:40:56 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200109140302.f8E32LG13400@zero.tech9.net> <200109181822.f8IIMv618968@mailg.telia.com> <1000855890.19833.51.camel@phantasy>
In-Reply-To: <1000855890.19833.51.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920064042Z274341-760+14433@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 19. September 2001 01:31 schrieb Robert Love:
> On Tue, 2001-09-18 at 14:18, Roger Larsson wrote:
> > Do you run with the playback process reniced -N?
> > It should really run with a low SCHED_FIFO or SCHED_RT policy.
> > But renicing it with a negative value gives some of the benefits...
> > (but you need to run as root)
> > In addition to this the program might need to lock its pages down - the
> > only thing I can think of that could cause several seconds delay would
> > be if it has been swapped out...
>
> Certainly giving it a higher priority should improve results (especially
> with preemption), but the application should receive a fair amount of
> process attention as it is, as it is TASK_RUNNABLE at all times and the
> disk I/O should be routinely preempted.  I am interested how much
> renicing it helps, though.

Nearly zero :-)

> Now, if it has to swap pages, that is a very good point.  I tend to
> blame this, or perhaps something with a long held lock (the audio
> driver?) for the blips.

System didn't go into swap during whole test, sorry.

> Its so hard to tell swap/VM issues now with all the VM work, sadly...:)

I point to the second;-)

-Dieter
