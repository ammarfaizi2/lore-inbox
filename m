Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRCTSTn>; Tue, 20 Mar 2001 13:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130065AbRCTSTe>; Tue, 20 Mar 2001 13:19:34 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:34573 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S130013AbRCTSTP>;
	Tue, 20 Mar 2001 13:19:15 -0500
Subject: Re: [PATCH] Re: PCMCIA serial CardBus support vanished in
	2.4.3-pre3 and  later
From: Miles Lane <miles@megapathdsl.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, tytso@mit.edu,
        guthrie@infonautics.com
In-Reply-To: <3AB77944.20018B9A@mandrakesoft.com>
In-Reply-To: <Pine.LNX.3.96.1010320080638.18764C-100000@mandrakesoft.mandrakesoft.com>
	<3AB77485.3BAB3AFE@oracle.com>  <3AB77944.20018B9A@mandrakesoft.com>
Content-Type: text/plain
X-Mailer: Evolution (0.9/+cvs.2001.03.16.09.00 - Preview Release)
Date: 20 Mar 2001 10:20:02 -0800
Mime-Version: 1.0
Message-ID: <auto-000017105057@megapathdsl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Mar 2001 10:37:40 -0500, Jeff Garzik wrote:
> On closer inspection, that patch I linked to appears to be incomplete.
> 
> Can you try the attached patch, to see if it fixes the
> absence-of-serial_cb problem?
> 
> Thanks,
> 
>       Jeff
> 
> 
> P.S. I'm surprised serial_cb in 2.4 worked at all, for anybody.  I guess
> they must be using pcmcia_cs's serial_cb, not the kernel's serial_cb...


Yes.  Well, this just strengthens the case for getting PCMCIA support
migrated fully into the kernel tree so that we can pry people's finger
loose from pcmcia_cs.  David Woodhouse is planning to take up this
project early in the 2.5 development cycle.

It's kind of a shame that more testing of the 2.4.x Cardbus/PCMCIA 
drivers isn't happening, because a lot of the Cardbus/PCMCIA support
in the kernel tree is really just fine.  We should all be using it and
testing it and reporting bugs.

One of the work items will be getting the in-kernel PCMCIA support
to work with the new hotplug stuff.


    Miles

