Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273098AbRIOVkn>; Sat, 15 Sep 2001 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273089AbRIOVkf>; Sat, 15 Sep 2001 17:40:35 -0400
Received: from [209.202.108.240] ([209.202.108.240]:14341 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S273093AbRIOVkT>; Sat, 15 Sep 2001 17:40:19 -0400
Date: Sat, 15 Sep 2001 17:39:37 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Pavel Machek <pavel@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Strange /dev/loop behavior
In-Reply-To: <20010915125716.A499@bug.ucw.cz>
Message-ID: <Pine.LNX.4.33.0109151738460.398-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2001, Pavel Machek wrote:

> Hi!
>
> > > Is there any known method of copying/compressing the loopback-mounted file-
> > > system that always guarantees consistency after a sync, without requiring the
> > > fs to be unmounted first?
> >
> > Try mounting the loop device synchronously (mount ... -o sync).
>
> That should not be needed. All data should be on disk by time umount
> succeeds. That's not currently the case, and that's a bug.

The message reads as though he wants the data to be on-disk without requiring
a umount.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

