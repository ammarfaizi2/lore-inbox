Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290113AbSA3Qq3>; Wed, 30 Jan 2002 11:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290084AbSA3QpL>; Wed, 30 Jan 2002 11:45:11 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21777 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290018AbSA3QoM>; Wed, 30 Jan 2002 11:44:12 -0500
Date: Wed, 30 Jan 2002 19:44:08 +0300
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@suse.de>, Sebastian Dr?ge <sebastian.droege@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020130194408.A2153@namesys.com>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de> <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de> <20020130190905.A820@namesys.com> <20020130174011.L24012@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130174011.L24012@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 30, 2002 at 05:40:11PM +0100, Dave Jones wrote:
>  > I can reproduce this problem on IDE only.
>  > Hm, may be this is IDE corruption thing, Andre Hendrick spoke about,
>  > or was it fixed already?
>  > I am looking into it anyway.
>  There were no IDE changes in my tree recently, and its strange
>  that this only shows up in reiserfs since the new set of patches
>  went in. I've no reports from users of other filesystems with any
>  problems, so I'm suspecting a rogue change in your last update.
>  Finding a common factor seems tricky, as it works flawlessly here
>  on IDE [*], but dies instantly for others.
You do not play with a hdparm in your boot scripts, do you?
I do (will retry without this now).
How about others?

Bye,
    Oleg
