Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSFCNJd>; Mon, 3 Jun 2002 09:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSFCNJc>; Mon, 3 Jun 2002 09:09:32 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:58137 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S315893AbSFCNJa>; Mon, 3 Jun 2002 09:09:30 -0400
Message-Id: <5.1.0.14.2.20020603090921.009e82e0@pop.mindspring.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 03 Jun 2002 09:11:05 -0400
To: Helge Hafting <helgehaf@aitel.hist.no>,
        "Ronny T. Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>,
        linux-kernel@vger.kernel.org
From: Joe Korty <l-k@mindspring.com>
Subject: Re: 3c59x driver: card not responding after a while
In-Reply-To: <3CFB21C5.27BBFB66@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:59 AM 6/3/02 +0200, Helge Hafting wrote:
>"Ronny T. Lampert (EED)" wrote:
>
> > I'm having (reproducable) problems with the 3c59x driver; after a while
> > (depends on card/traffic), the card doesn't send nor receive anymore.
> >
>I see this too.  I always thought it was the less-than-perfect ABIT BP6
>loosing an irq or something.  (odd that it _always_ is the NIC that goes
>though...)  I also have a k6 with the same NIC, and another
>UP machine at work.  They never fail this way.
>Could it be a SMP problem?



Try increasing max_interrupt_work from 32 to 128 (located in 
drivers/net/3c59x.c).
Joe

