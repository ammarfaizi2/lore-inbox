Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264680AbTFEN43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 09:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbTFEN43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 09:56:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57606 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264680AbTFEN42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 09:56:28 -0400
Date: Thu, 5 Jun 2003 14:42:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG_ON() in drivers/ide/ide-disk.c:1526.
Message-ID: <20030605124207.GA3660@zaurus.ucw.cz>
References: <Pine.GSO.4.10.10306041550510.2442-100000@catfish.lcs.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10306041550510.2442-100000@catfish.lcs.mit.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

See "IDE Power managment" thread.

> When using suspend-to-disk, I trigger BUG_ON in ide-disk.c:1526:
> 
> 	BUG_ON (HWGROUP(drive)->handler);
> 
> It seems that this assertion is intended to check that all interrupts have
> been handled before idedisk_suspend returns --- but I can't find any code
> which ought to do this.
> 
> More details available if needed.
>  --scott
> 
> Mk 48 assassination politics FSF EZLN spy Marxist interception Nazi 
> Hussein RNC shotgun cracking COBRA JUDY ammunition COBRA JANE chemical agent 
>                          ( http://cscott.net/ )
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

