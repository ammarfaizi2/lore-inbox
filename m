Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285268AbRLNAEY>; Thu, 13 Dec 2001 19:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285266AbRLNAEO>; Thu, 13 Dec 2001 19:04:14 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:40267 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S285265AbRLNAD5>; Thu, 13 Dec 2001 19:03:57 -0500
From: brian@worldcontrol.com
Date: Thu, 13 Dec 2001 16:02:15 -0800
To: "Jonathan D. Amery" <jdamery@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C686 && APM deadlock bug?
Message-ID: <20011213160215.A14006@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	"Jonathan D. Amery" <jdamery@chiark.greenend.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0112121632440.4294-100000@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112121632440.4294-100000@chiark.greenend.org.uk>
User-Agent: Mutt/1.3.19i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 04:37:01PM +0000, Jonathan D. Amery wrote:
> 
>  I haven't seen this reported anywhere, so apologies if you've heard this
> before:).
> 
>  in 2.4.9 and 2.4.16 with APM compiled in on my Sony Vaio FX201 laptop
> (Via VT82C686 chipset) sometimes when the hardware screensaver comes on
> (as a result of APM) the machine deadlocks and has to be powered off and
> on again.  (Lots of fscking).
> 
>  If you want any more info, please ask :).

I experience the same problem on my Sony Vaio FXA32.

It seems to me to be related to the display.

I can sometimes go into standby mode while in text mode and things 
seem fine.

Going into standby while in X cause the system to freeze.

I can go into standby and come right back out immediately and things
come back but there seems to be memory corruption.


-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
