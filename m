Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBMSso>; Tue, 13 Feb 2001 13:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129762AbRBMSse>; Tue, 13 Feb 2001 13:48:34 -0500
Received: from peace.netnation.com ([204.174.223.2]:24851 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S129754AbRBMSsZ>; Tue, 13 Feb 2001 13:48:25 -0500
Date: Tue, 13 Feb 2001 10:48:23 -0800
From: Simon Kirby <sim@netnation.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LDT allocated for cloned task!
Message-ID: <20010213104823.A14060@netnation.com>
In-Reply-To: <20010213124226.A15600@stormix.com> <E14Sk5t-0002Sl-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E14Sk5t-0002Sl-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 13, 2001 at 06:22:26PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 06:22:26PM +0000, Alan Cox wrote:

> > LDT allocated for cloned task!
> > 
> > I'm seeing this message come up fairly often while running vanilla
> > 2.4.2-pre3 on my dual Celeron system.  I don't think I saw it before
> > while running 2.4.1, but I may have just missed it.
> 
> Are you running wine or dosemu ?

Actually, I've ran both of them at least a few times this boot.

I think I've found what's doing it...xmms with the avi-xmms plugin will
cause the message to appear at startup even without playing anything. 
Moving the libraries out of the /usr/lib/xmms/Input directory and
starting xmms again will not produce any message.  I only just recently
downloaded this plugin which is probably why I didn't see it before.

It's also happening on my second (non-DRI) head, so it's probably not
related to that (I'll reboot and try again without any DRI modules loaded
and see).

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
