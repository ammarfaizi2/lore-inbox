Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261775AbSI2U25>; Sun, 29 Sep 2002 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261796AbSI2U25>; Sun, 29 Sep 2002 16:28:57 -0400
Received: from mail.eskimo.com ([204.122.16.4]:58885 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S261775AbSI2U2J>;
	Sun, 29 Sep 2002 16:28:09 -0400
Date: Sun, 29 Sep 2002 00:37:51 -0700
To: Michael Clark <michael@metaparadigm.com>
Cc: Elladan <elladan@eskimo.com>, felix.seeger@gmx.de,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: System very unstable
Message-ID: <20020929073751.GA21735@eskimo.com>
References: <200209281155.32668.felix.seeger@gmx.de> <20020928.025900.58828001.davem@redhat.com> <200209281233.21897.felix.seeger@gmx.de> <20020928.033510.40857147.davem@redhat.com> <3D958EF5.7080300@metaparadigm.com> <20020929000056.GB19765@eskimo.com> <3D9694AC.9020907@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9694AC.9020907@metaparadigm.com>
User-Agent: Mutt/1.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 01:50:36PM +0800, Michael Clark wrote:
> On 09/29/02 08:00, Elladan wrote:
> >On Sat, Sep 28, 2002 at 07:13:57PM +0800, Michael Clark wrote:
> >>
> >>Radeon 7500 is currently the fastest board with an opensource
> >>driver that supports 3D. 8500 XFree support is currently 2D only,
> >>although apparently work on the opensource GL driver is underway.
> >
> >Unfortunately, in my experience the open source Radeon 7500 drivers are
> >so unstable as to be basically unusable.  Plus, they seem to still be
> >basically incompatible with a lot of 3d software.
> 
> Don't know what version of X you've been running, but i haven't
> had a problem for over 8 months (since XFree86 4.2). Before then,
> the 4.1.99 CVS was needed for radeon support which was of course
> a developer branch, although i never experienced the sort of problems
> you describe.
> 
> Definately rock solid and stable on my 7500 mobility.

For 2d, the card was fine except for some drawing bugs.  I was using
XFree 4.2, as well as trying a large number of DRI CVS snapshots and the
like when the 4.2 release version proved too unstable to use.

The stability problems aside, the other issue with the 7500 drivers is
that they just didn't appear compatible with even rather simple GL
software.  There appeared to be severe graphics problems in basically
all of the OpenGL example programs I could get to run.  More complicated
games didn't tend to run at all - either the game would give an error
and fail to start, or the computer would crash.  The computer-
crashing-instantly aspect made it rather difficult for me to see how to
have a pleasant debugging experience without a lot more hardware, which
is why I gave up.

And of course, for comparison, Matrox and NVidia cards in the same
machine work fine, and the Radeon card worked fine when placed in a
windows box for testing.  So the evidence points to a driver stability
problem.

I don't mean to get completely off-topic with "Waa!  It didn't work!"
stories, but this seemed to be a recommendations thread.  My
recommendation: Radeon 7500 no, other Radeons I don't know.  Your
mileage may vary.  If you have time for a new driver debugging project,
Radeon 7500 big yes.  And hopefully XFree 4.3 will solve all the world's
problems.  :-)

-J
