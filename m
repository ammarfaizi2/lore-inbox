Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129138AbRBOUPj>; Thu, 15 Feb 2001 15:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129276AbRBOUPa>; Thu, 15 Feb 2001 15:15:30 -0500
Received: from datafoundation.com ([209.150.125.194]:16900 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S129138AbRBOUPT>; Thu, 15 Feb 2001 15:15:19 -0500
Date: Thu, 15 Feb 2001 15:15:01 -0500 (EST)
From: John Jasen <jjasen@datafoundation.com>
To: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>,
        <axp-list@redhat.com>
Subject: Re: 2.4.x/alpha/ALI chipset/IDE problems summary Re: 2.4.1 not fully
 sane on Alpha - file systems
In-Reply-To: <20010215124837.B13755@ellpspace.math.ualberta.ca>
Message-ID: <Pine.LNX.4.30.0102151513170.4654-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2001, Michal Jaegermann wrote:

> > Well, the situation is improving, I suppose ...
> >
> > Under kernel 2.4.0 and 2.4.1, a dd of about 10000 4k blocks would cause
> > the system to go technicolor and lock up.
>
> On UP1100 which I have here somehow this looks a bit different _after_
> I put on it the latest SRM and used this "magic incantation" from
> Hyung Min SEO ('d -l 801fe0000ac d' at SRM prompt to modify firmware).
> I copied from disk to disk directory tries with some 150 MB of data
> in these and no ill effects.

I retried the mysticism and incantations (d -l 801fe0000ac d) at the srm
prompt, and the machine locked on fsck, under kernel 2.4.1-ac13.

I don't care about X on this system, all that much, honestly.

-- John

