Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbRESIRP>; Sat, 19 May 2001 04:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbRESIRG>; Sat, 19 May 2001 04:17:06 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:50634 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261689AbRESIQy>; Sat, 19 May 2001 04:16:54 -0400
Date: Sat, 19 May 2001 04:16:53 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@devserv.devel.redhat.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andrew Clausen <clausen@gnu.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <Pine.GSO.4.21.0105190405180.3724-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0105190411030.13165-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, Alexander Viro wrote:

> On Sat, 19 May 2001, Ben LaHaise wrote:
>
> > It's not done yet, but similar techniques would be applied.  I envision
> > that a raid device would support operations such as
> > open("/dev/md0/slot=5,hot-add=/dev/sda")
>
> Think for a moment and you'll see why it's not only ugly as hell, but simply
> won't work.

Yeah, I shouldn't be replying to email anymore in my bleery-eyed state.
=) Of course slash seperated data doesn't work, so it would have to be
hot-add=<filedescriptor> or somesuch.  Gah, that's why the options are all
parsed from a single lookup name anyways...

		-ben (who's going to sleep)


