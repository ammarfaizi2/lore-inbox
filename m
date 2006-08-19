Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751729AbWHSLrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbWHSLrb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 07:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbWHSLrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 07:47:31 -0400
Received: from lucidpixels.com ([66.45.37.187]:34253 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751726AbWHSLra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 07:47:30 -0400
Date: Sat, 19 Aug 2006 07:47:29 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Andrew Baker <andrew@teledesign.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Daily crashes, incorrect RAID behaviour
In-Reply-To: <loom.20060819T133036-36@post.gmane.org>
Message-ID: <Pine.LNX.4.64.0608190746530.30851@p34.internal.lan>
References: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
 <200608151545.49345@bj-ig.de> <loom.20060819T133036-36@post.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Aug 2006, Andrew Baker wrote:

> We too are having the same problem and the only obviously common factor is
> Maxtor SATA HDD.
>
> We have two identical systems - 64 bit - 2 x Dual Opterons, 8Gb Ram running
> Novell/SUSE SLES10. Both systems are showing the problem.
>
> In our case the RAID controller is
>
> 3ware Escalade 9550SX - 8LP
>
> And the HDD are:
>
> Maxtor MaxLine III (7V250F0) 250GB SATA II
>
> The symptoms here are almost exactly as you describe.  A disc "drops out" once
> every week or two and the only way to clear the problem is a power cycle - or
> remove and replace the HDD (our system is hot-swap).
>
> Regards
>
> Andrew
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

I had the same problem with a 3ware 2 port IDE raid controller, 7006-2. 
One drive would always drop out under heavy I/O. Made me sick.  Moved to 
SW raid, all problems went away.

Justin.

