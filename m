Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbTD0RJX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264687AbTD0RJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 13:09:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:50620 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264682AbTD0RJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 13:09:20 -0400
Message-Id: <5.2.0.9.2.20030427191459.00caed60@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sun, 27 Apr 2003 19:25:59 +0200
To: "Martin J. Bligh" <mbligh@aracnet.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Houston, I think we have a problem
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <28750000.1051454510@[10.10.2.4]>
References: <5.2.0.9.2.20030427090009.01f89870@pop.gmx.net>
 <5.2.0.9.2.20030427090009.01f89870@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:41 AM 4/27/2003 -0700, Martin J. Bligh wrote:
> > To reproduce this 100% of the time, simply compile virgin 2.5.68
> > up/preempt, reduce your ram to 128mb, and using gcc-2.95.3 as to not
> > overload the vm, run a make -j30 bzImage in an ext3 partition on a P3/500
> > single ide disk box.  No, you don't really need to meet all of those
> > restrictions... you'll see the problem on a big hairy chested box as
> > well, just not as bad as I see it on my little box.  The first symptom of
> > the problem you will notice is a complete lack of swap activity along
> > with highly improbable quantities of unused ram were all those hungry
> > cc1's getting regular CPU feedings.
>
>Yes, that's why I don't use ext3 ;-) It's known broken, akpm is fixing it.

I'm not at all convinced (must say I wouldn't mind at _all_ being 
convinced) that it's ext3... that just _seems_ to be worst easily 
reproducible case for some un-(expletive deleted)-known reason.

         -Mike

