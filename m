Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281518AbRKHL0Z>; Thu, 8 Nov 2001 06:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281516AbRKHL0P>; Thu, 8 Nov 2001 06:26:15 -0500
Received: from posta2.elte.hu ([157.181.151.9]:61414 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S281518AbRKHL0A>;
	Thu, 8 Nov 2001 06:26:00 -0500
Date: Thu, 8 Nov 2001 13:23:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: J Sloan <jjs@pobox.com>, J Sloan <jjs@lexus.com>,
        Robert Love <rml@tech9.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: preempt-patch cleared of blame
In-Reply-To: <20011108113615.F27652@suse.de>
Message-ID: <Pine.LNX.4.33.0111081322570.8555-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, Jens Axboe wrote:

> On Wed, Nov 07 2001, J Sloan wrote:
> > I think there may be a problem with the
> > compaq smart/2p raid drivers, since
> > the "do_ida_intr" code keeps showing
> > up in the oops, and I have not seen a
> > problem with 2.4.14 on any other system.
>
> Does this fix it?

it did the trick on my system, which used to oops in/around do_ida_intr as
well.

	Ingo

