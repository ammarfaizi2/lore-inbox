Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267115AbSKMGQW>; Wed, 13 Nov 2002 01:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267117AbSKMGQW>; Wed, 13 Nov 2002 01:16:22 -0500
Received: from modemcable217.53-202-24.mtl.mc.videotron.ca ([24.202.53.217]:4111
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267115AbSKMGQW>; Wed, 13 Nov 2002 01:16:22 -0500
Date: Wed, 13 Nov 2002 01:18:00 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Tomasz Torcz, BG" <zdzichu@irc.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Uninitialised timer in 2.5.47
In-Reply-To: <20021113061147.GB19447@irc.pl>
Message-ID: <Pine.LNX.4.44.0211130116370.24523-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Tomasz Torcz, BG wrote:

> Hi,
> 
> today I've booted 2.5.47 and got some unpleasant, oopslooking
> messages. It's looks like some debugging info.
> I'm including dmegs output, as it seems to contain enough info.
> If any more info is needed, I will happily provide it.
> 
> (please CC me if replying).
>
> Uninitialised timer!
> This is just a warning.  Your computer is OK
> function=0xc03528bc, data=0xc759eb00
> Call Trace:
>  [<c0120370>] check_timer_failed+0x40/0x4c
>  [<c03528bc>] igmp6_timer_handler+0x0/0x50

I just sent a patch for that, and it might have been caught earlier too. 
Nothing to worry about though.

	Zwane
-- 
function.linuxpower.ca

