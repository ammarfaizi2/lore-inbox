Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVHUOsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVHUOsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 10:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVHUOsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 10:48:32 -0400
Received: from scsoftware.csnc.net ([205.214.229.65]:32416 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id S1751030AbVHUOsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 10:48:31 -0400
Date: Sun, 21 Aug 2005 07:42:54 -0700 (PDT)
From: John Heil <kerndev@sc-software.com>
To: "j.t. holmes" <linux@jtholmes.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.5 stalls on boot
In-Reply-To: <43082267.2030009@jtholmes.com>
Message-ID: <Pine.LNX.4.58.0508210735030.9183@scsoftware.sc-software.com>
References: <43082267.2030009@jtholmes.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2005, j.t. holmes wrote:

> Date: Sun, 21 Aug 2005 02:42:47 -0400
> From: j.t. holmes <linux@jtholmes.com>
> To: linux-kernel@vger.kernel.org
> Subject: 2.6.12.5 stalls on boot
>
>
> 2.6.12.5 and others below that to 2.6.10  stall on boot. The problem is
> udev.
>
> It stalls between 1 to 3 minutes.
>

Just a data point...

I haven't had any prolems what so ever so far at 18 hrs.

I just installed it yesterday on an Athlon XP 3200+ w a nvida 2 chipset

Distribution is Slackware 10.1

I am running W$ XP Pro under VMware 5 & have interminently heavy NFS
traffic.

I compiled 2.6.12.5 w gcc v3.3.4.  Did you by any chance build w gcc v4 ?

Cheers,
johnh

> I have the latest
>
> udev
> hotplug
> klibc
>
> u name it
>
> Something happened about 2.6.11.X and I see others writing about
> similar items
>
> The base system is Suse 9.2  and I am beginning to wonder if
> there is something that Suse wrote that is interferring w/the boot.
> Since they shipped 9.2 with a 2.6.8-24 and there have been a lot
> of changes up to 2.6.12.5
>
> In any case the  boot  stalls  just after it prints these two lines
>
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: PS/2 Generic Mouse on isa0060/serio4
>
> and about 2 mins + -  later it prints this
>
> EXT2-fs warning (device hda6): ext2_fill_super: mounting ext3 filesystem
> as ext2
> and then continue normal boot
>
> I sent in  an  ALT SYSREQ  P  and T  trace a few weeks ago
> but didnt get an answer.
>
> Am I incorrect in assuming that everything up until the root disk is mounted
> is primarily kernel activity? If not then where else can I look.
>
> I can provide any info desired.
>
> Just in case this is Suse related I am going to load  9.3  early next week
> and compile  2.6.12.5 on it and see it I encounter the stall problem. I will
> post the results from the activity.
>
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------
