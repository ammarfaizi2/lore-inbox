Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbTDEUva (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 15:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTDEUva (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 15:51:30 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:42768
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262658AbTDEUv2 (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 15:51:28 -0500
Date: Sat, 5 Apr 2003 12:58:14 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Fixes for ide-disk.c
In-Reply-To: <1049570711.3320.2.camel@laptop-linux.cunninghams>
Message-ID: <Pine.LNX.4.10.10304051257060.29290-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why?

Drive->blocked N times is still blocked.

I refuse to play tracking games to figure out whose Drive->blocked is
whose!

Cheers,

On Sun, 6 Apr 2003, Nigel Cunningham wrote:

> Hi.
> 
> On Sun, 2003-04-06 at 04:46, Alan Cox wrote:
> > Drive->blocked is a single bit field. Its not a counting lock. Either
> > we are blocked or not.
> 
> Okay. We need a different solution then, but the problem remains - the
> driver can get multiple, nexted calls to block and unblock. Can it
> become a counting lock?
> 
> Regards,
> 
> Nigel
> 
> -- 
> Nigel Cunningham
> 495 St Georges Road South, Hastings 4201, New Zealand
> 
> Be diligent to present yourself approved to God as a workman who does
> not need to be ashamed, handling accurately the word of truth.
> 	-- 2 Timothy 2:14, NASB.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

