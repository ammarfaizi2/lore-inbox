Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRCIGFB>; Fri, 9 Mar 2001 01:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130436AbRCIGEv>; Fri, 9 Mar 2001 01:04:51 -0500
Received: from [216.184.166.130] ([216.184.166.130]:13864 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S129444AbRCIGEm>; Fri, 9 Mar 2001 01:04:42 -0500
Date: Thu, 8 Mar 2001 22:01:03 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac15 -- Build fails in serial.c if CONFIG_SERIAL_CONSOLE is enabled.
In-Reply-To: <E14bBTs-00048o-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1010308215937.1676C-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Alan Cox wrote:

> Date: Fri, 9 Mar 2001 01:14:04 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Miles Lane <miles@megapathdsl.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.2-ac15 -- Build fails in serial.c if CONFIG_SERIAL_CONSOLE is enabled.
> 
> > In serial.c, in function `wait_for_xmitr' at lines 5497 and 5666, 
> > `ASYNC_NO_FLOW' is undeclared.
> 
> Yep. Disable serial console for now. Jeff's serial merge broke serial console
> support

What's the last level w functioning serial console. I've got a couple
of boot up issues I may need it for.

> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

