Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSKCOli>; Sun, 3 Nov 2002 09:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSKCOli>; Sun, 3 Nov 2002 09:41:38 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42202 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261963AbSKCOlh>; Sun, 3 Nov 2002 09:41:37 -0500
Date: Sun, 3 Nov 2002 15:48:04 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Kai Engert <kai.engert@gmx.de>
cc: linux-kernel@vger.kernel.org, <james@cobaltmountain.com>,
       <alan@redhat.com>
Subject: Re: Regression in 2.4.20 radeonfb.c
In-Reply-To: <3DC5333A.3090808@gmx.de>
Message-ID: <Pine.NEB.4.44.0211031539110.14178-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Kai Engert wrote:

> In 2.4.19-rc3-ac2, Alan Cox / James Mayer added a modeline entry to
> modedb.c that enables a 1280x600 console screen on Vaio C1M* devices.
> The patch works fine for me in 2.4.19.
>
> In 2.4.20-pre* kernels, it does no longer work for me, the console
> remains at the default setting.
>
> I identified the hunk below to be the culprit. That check was removed in
> 2.4.20-* kernels. When I revert the hunk below, adding back the null
> check, my system again switches to full screen console mode.
>
> I propose to revert the hunk for 2.4.20.
> Tested with 2.4.20-rc1.

This "According to XFree86 4.2.0..." patch was never in the 2.4 tree. It
is in the -ac tree (the latest -ac kernel is 2.4.20-pre10-ac2).

It might be a good idea to add it in 2.4.21-pre to the 2.4 tree but it's
most likely too late to get it into 2.4.20.

> Thanks,
> Kai
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



