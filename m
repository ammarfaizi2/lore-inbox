Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264700AbTD0RZO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 13:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbTD0RZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 13:25:14 -0400
Received: from imap.gmx.net ([213.165.64.20]:33517 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264700AbTD0RZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 13:25:13 -0400
Message-Id: <5.2.0.9.2.20030427193908.0220bee8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sun, 27 Apr 2003 19:41:53 +0200
To: "Martin J. Bligh" <mbligh@aracnet.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Houston, I think we have a problem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <32170000.1051464570@[10.10.2.4]>
References: <5.2.0.9.2.20030427191459.00caed60@pop.gmx.net>
 <5.2.0.9.2.20030427090009.01f89870@pop.gmx.net>
 <5.2.0.9.2.20030427090009.01f89870@pop.gmx.net>
 <5.2.0.9.2.20030427191459.00caed60@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:29 AM 4/27/2003 -0700, Martin J. Bligh wrote:
> >> > To reproduce this 100% of the time, simply compile virgin 2.5.68
> >> > up/preempt, reduce your ram to 128mb, and using gcc-2.95.3 as to not
> >> > overload the vm, run a make -j30 bzImage in an ext3 partition on a
> >> > P3/500 single ide disk box.  No, you don't really need to meet all of
> >> > those restrictions... you'll see the problem on a big hairy chested
> >> > box as well, just not as bad as I see it on my little box.  The first
> >> > symptom of the problem you will notice is a complete lack of swap
> >> > activity along with highly improbable quantities of unused ram were
> >> > all those hungry cc1's getting regular CPU feedings.
> >>
> >> Yes, that's why I don't use ext3 ;-) It's known broken, akpm is fixing
> >> it.
> >
> > I'm not at all convinced (must say I wouldn't mind at _all_ being
> > convinced) that it's ext3... that just _seems_ to be worst easily
> > reproducible case for some un-(expletive deleted)-known reason.
>
>Well, that's easy to test. Mount the fs as ext2, and see if it goes away.


Sure, btdt very first thing, and that's why I'm not convinced that ext3 is 
the core problem.  I see "it" in ext2 as well, just less so.

         -Mike 

