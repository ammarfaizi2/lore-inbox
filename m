Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278222AbRJMBB1>; Fri, 12 Oct 2001 21:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278223AbRJMBBR>; Fri, 12 Oct 2001 21:01:17 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57078
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278222AbRJMBBI>; Fri, 12 Oct 2001 21:01:08 -0400
Date: Fri, 12 Oct 2001 18:01:32 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Updated preempt-kernel patches
Message-ID: <20011012180132.C16500@mikef-linux.matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1002917978.957.86.camel@phantasy> <1002925193.868.5.camel@phantasy> <20011012172702.A16500@mikef-linux.matchmail.com> <1002933123.868.8.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002933123.868.8.camel@phantasy>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 08:32:00PM -0400, Robert Love wrote:
> On Fri, 2001-10-12 at 20:27, Mike Fedyk wrote:
> > On Fri, Oct 12, 2001 at 06:19:52PM -0400, Robert Love wrote:
> > > On Fri, 2001-10-12 at 16:19, Robert Love wrote:
> > > > - fix compile on SMP in some configurations (ac tree only)
> > > 
> > > Looks like I forgot to merge that one.  Fix follows below (its needed by
> > > some ac-tree users who also compile SMP).
> > >
> > 
> > Again? ;)
> 
> Yes, again :)
>

;)

> The 2.4.12-ac1 patch at http://tech9.net/rml/linux has been updated so
> you don't need the previous patch.
> 
> > Any idea how it would work on any smp systems using the -ac tree?
> 
> It should run fine, give it a whirl.
>

Don't worry, I'm just bugging... ;)

SMP patch is working great:
Now  : 1 day(s), 23:14:50 running Linux 2.4.10-ac11+smp+preempt+vm_hogstop
One  : 6 day(s), 01:51:56 running Linux
2.4.9-ac10_ext3_0.9.9_dir-speed_interactivity, ended Wed Sep 26 14:34:33 2001
Two  : 4 day(s), 03:37:47 running Linux 2.4.9-ac16-vfree, ended Mon Oct  1
18:51:31 2001
Three: 3 day(s), 00:59:12 running Linux 2.4.10-ac4, ended Mon Oct  8
19:53:54 2001

I reset ud after switching to 2.4-ac from 2.2...

> 	Robert Love
> 

Mike
