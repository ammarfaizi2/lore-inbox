Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284874AbRLFA1T>; Wed, 5 Dec 2001 19:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284886AbRLFA0F>; Wed, 5 Dec 2001 19:26:05 -0500
Received: from mailf.telia.com ([194.22.194.25]:35839 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S284899AbRLFAYc>;
	Wed, 5 Dec 2001 19:24:32 -0500
Message-Id: <200112060024.fB60OTa09388@d1o849.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: Tim Waugh <twaugh@redhat.com>
Subject: Re: Linux 2.4.17-pre4
Date: Thu, 6 Dec 2001 01:22:52 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0112051640570.20575-100000@freak.distro.conectiva> <200112052155.fB5Ltxa26014@d1o849.telia.com> <20011205221812.U14028@redhat.com>
In-Reply-To: <20011205221812.U14028@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 5 December 2001 23.18, Tim Waugh wrote:
> On Wed, Dec 05, 2001 at 10:54:26PM +0100, Jakob Kemi wrote:
> > Since 2.4.14 the ieee1284 parport functions have worked improperly
> > for some drivers (CPiA, W9966 and others). Joe
> > <joeja@mindspring.com> was quick to find the failure. He said he was
> > going to send the patch to you some week ago and maybe he already
> > have. If it somehow got lost in an internet black-hole or something
> > I try to also send it to you. It's just a one-liner which reverts to
> > pre-2.4.14 behavior.
>
> I am the maintainer of this code.  Why is this the first time that I
> have seen this patch (or even heard of a problem report)?  Marcelo,

Dunno, It's been a couple of mails about it on the list, under the topic CPIA 
is broke and then later '2.4.14/2.4.15 cpia driver IS broke.. no its parport'

> please don't apply it.
>
> The correct fix is to change:
>
> ctl &= ~(PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
>
> so that it also turns off AUTOFD as well.
>
> I have several patches queued up for parport (see

Nice, I hope it gets in before 2.4.17.


> http://people.redhat.com/twaugh/patches/).  It would be very helpful
> to me if you could first send changes to me rather than Marcelo or

Sounds good to me, I'll do that next time. It was just that I heard the 25 of 
nov. that the patch was sent by joe and I just wanted to make sure that it 
didn't dissapear in the noise.

Regards,
	Jakob
