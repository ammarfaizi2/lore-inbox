Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316852AbSGHPKq>; Mon, 8 Jul 2002 11:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSGHPKp>; Mon, 8 Jul 2002 11:10:45 -0400
Received: from smtp.alacritech.com ([12.44.162.34]:48009 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S316852AbSGHPKo>; Mon, 8 Jul 2002 11:10:44 -0400
Message-ID: <3D29A9BC.266EC55E@alacritech.com>
Date: Mon, 08 Jul 2002 08:03:24 -0700
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: direct-to-BIO for O_DIRECT
References: <3D2904C5.53E38ED4@zip.com.au.suse.lists.linux.kernel> <p73adp2wugy.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Andrew Morton <akpm@zip.com.au> writes:
> 
> >       drivers/md/lvm-snap.c
> >       drivers/media/video/video-buf.c
> >       drivers/mtd/devices/blkmtd.c
> >       drivers/scsi/sg.c
> >
> > the video and mtd drivers seems to be fairly easy to de-kiobufize.
> > I'm aware of one proprietary driver which uses kiobufs.  XFS uses
> > kiobufs a little bit - just to map the pages.
> 
> lkcd uses it too for its kernel crash dump. I suspect it wouldn't be that
> hard to change.
> 

We can remove their use from our 2.5 tree.  Not a problem, as
there are other ways to accomplish what we want.

> -Andi

--Matt
