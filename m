Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289055AbSBISVf>; Sat, 9 Feb 2002 13:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289099AbSBISVZ>; Sat, 9 Feb 2002 13:21:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4614 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289055AbSBISVJ>; Sat, 9 Feb 2002 13:21:09 -0500
Date: Sat, 9 Feb 2002 13:19:58 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Pavel Machek <pavel@suse.cz>
cc: Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
        vojtech@ucw.cz, andre@linuxdiskcert.org
Subject: Re: ide cleanup
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz>
Message-ID: <Pine.LNX.3.96.1020209131726.23246D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Pavel Machek wrote:

> -#ifdef CONFIG_BLK_DEV_PDC4030
>  	if (IS_PDC4030_DRIVE) {
>  		extern ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *, unsigned long);
>  		return promise_rw_disk(drive, rq, block);
>  	}
> -#endif /* CONFIG_BLK_DEV_PDC4030 */

Am I reading this totally wrong, or do you really think it's a good idea
to test for a drive even if the user didn't configure such hardware?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

