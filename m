Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSKNPwU>; Thu, 14 Nov 2002 10:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSKNPwU>; Thu, 14 Nov 2002 10:52:20 -0500
Received: from windsormachine.com ([206.48.122.28]:16905 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S264938AbSKNPwT>; Thu, 14 Nov 2002 10:52:19 -0500
Date: Thu, 14 Nov 2002 10:59:09 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Jani Averbach <jaa@cc.jyu.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How do I re-activate IDE controller (secondary channel) after
 boot?
In-Reply-To: <Pine.GSO.4.33.0211141724410.20634-100000@tukki.cc.jyu.fi>
Message-ID: <Pine.LNX.4.33.0211141048050.10843-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Jani Averbach wrote:

> > I thought I remembered a way to get the full capacity after Linux has
> > booted up, using that method.
> >
>
> Even when drive has been jumppered to 32G? Please tell. =)

Well, from a debian-user posting I made today about crontab, and then
finding out i misread his statement completely, I'm in danger of
having my license to help revoked.

But I'll google anyways

take a look at the Large-Disk-HOWTO

www.win.tue.nl/~aeb/linux/Large-Disk-11.html#ss11.3

There's a program called setmax, that sets the maximum capacity.  As well,
there appears to be kernel patches, these appear to have been applied to
2.5.3 and above, but maybe not 2.4.x?

According to the howto, drives over 137 are still limited, with a patch to
2.5.3 handling it again.

I'm hoping someone who knows more about the kernel whether this patch has
been applied somewhere along the line.

Is your drive an IBM?

Apparently Maxtor does it right, and IBM doesn't.  IBM , you software clip
the drive to a certain size in another machine, and then move it back to
your original machine.

Maxtor, you can just use the setmax.

Hopefully my rambling helps, and doesn't get my license to help taken away

Mike

