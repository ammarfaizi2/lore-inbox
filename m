Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263958AbSJOJTn>; Tue, 15 Oct 2002 05:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSJOJTn>; Tue, 15 Oct 2002 05:19:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55246 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263958AbSJOJTm>; Tue, 15 Oct 2002 05:19:42 -0400
Date: Tue, 15 Oct 2002 11:25:33 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Matt Domsch <Matt_Domsch@Dell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers
In-Reply-To: <Pine.LNX.4.44.0210141408400.13924-100000@humbolt.us.dell.com>
Message-ID: <Pine.NEB.4.44.0210151118160.20607-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Matt Domsch wrote:

>...
> This will update the following files:
>
>...
>  drivers/char/Config.help             |  436 -----------------------
>...
>  drivers/char/watchdog/Config.help    |  220 +++++++++++
>...

I was wondering where this difference came from and it seems the diffstat
output is wrong?

<--  snip  -->

$ filterdiff -i *char/Config.help linux-2.5.42-mvwatchdog.patch \
> | grep ^- | grep -v ^--- | wc -l
    221
$

<--  snip  -->

> http://domsch.com/linux/patches/watchdog/linux-2.5.42-mvwatchdog.patch
>...
> Thanks,
> Matt

cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed



