Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271870AbRIDBJY>; Mon, 3 Sep 2001 21:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271871AbRIDBJO>; Mon, 3 Sep 2001 21:09:14 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:12268 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271870AbRIDBJJ>; Mon, 3 Sep 2001 21:09:09 -0400
Date: Mon, 3 Sep 2001 21:09:26 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: <Andries.Brouwer@cwi.nl>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [resend PATCH] reserve BLKGETSIZE64 ioctl
In-Reply-To: <200109032057.UAA36797@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.33.0109032107001.2463-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001 Andries.Brouwer@cwi.nl wrote:

> Yes.
>
> (1) As you can see you'll only get redefinition complaints.
> In other words, there is a B too much in the ioctl name.

Yeah, the previous version was actually matching the subject.

> (2) We just concluded that 108-111 have been used for various
> private purposes. If we avoid 108-111 in all official kernels
> then nobody will be surprised if he ever uses some system
> utility that uses one of these.
> Thus, it is a very bad idea to want to use these again.

Where was 110 used?  That wasn't mentioned in the last thread.

> (3) Soon we'll all need a BLKGETSIZE64 ioctl, that gives
> the size of a block device in bytes. Your proposed ioctl
> gave the size in blocks if I recall correctly.
> So, if you have to change the name and the number,
> you might as well change the definition.

I'd accepted that suggestion, I suppose that it should be added to the
comment.

		-ben

