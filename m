Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRBSKg0>; Mon, 19 Feb 2001 05:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129613AbRBSKgQ>; Mon, 19 Feb 2001 05:36:16 -0500
Received: from f12.law7.hotmail.com ([216.33.237.12]:19 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129604AbRBSKgF>;
	Mon, 19 Feb 2001 05:36:05 -0500
X-Originating-IP: [195.171.24.4]
From: "lafanga lafanga" <lafanga1@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proliant hangs with 2.4 but works with 2.2.
Date: Mon, 19 Feb 2001 10:35:58 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F12wG4I18SHyZ2CIfdL0001b484@hotmail.com>
X-OriginalArrivalTime: 19 Feb 2001 10:35:59.0541 (UTC) FILETIME=[BFB75E50:01C09A5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

You were spot on. Indeed touching the device file causes it to hang. Should 
I recompile the kernel in a particular way to avoid this?

Many Thanks.

>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>To: lafanga1@hotmail.com (lafanga lafanga)
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Proliant hangs with 2.4 but works with 2.2.
>Date: Mon, 19 Feb 2001 01:53:59 +0000 (GMT)
>
> > The programs 'gpm', 'kudzu' and 'startx' all hang the server immediately
> > after they exit (with exit status 0). I cannot pinpoint why the kernel 
>hangs
> > and would appreciate any help. The only thing I suspect it may be is 
>that it
>
>The three of them all touch the mouse. Does
>
>dd if=/dev/psaux of=/dev/null count=256
>
>also hang the box ?
>

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

