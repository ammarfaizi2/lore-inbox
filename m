Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUBHD1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 22:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUBHD1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 22:27:38 -0500
Received: from [209.124.87.2] ([209.124.87.2]:14565 "EHLO
	server.cyberhostplus.biz") by vger.kernel.org with ESMTP
	id S261928AbUBHD1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 22:27:36 -0500
From: "Steve Lee" <steve@tuxsoft.com>
To: <gene.heskett@verizon.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: aRTS vs 2.6.3-rc1, aRTS loses
Date: Sat, 7 Feb 2004 21:27:11 -0600
Message-ID: <026201c3edf3$73ed8e50$e501a8c0@saturn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <200402070647.54889.gene.heskett@verizon.net>
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.cyberhostplus.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tuxsoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having the same problem you described in your original message.  I
built 2.6.3-rc1 as you described here, ".config + a make oldconfig" but
arts dies with a message saying, "Sound server error, CPU overload".  I
click OK, but about 30 seconds later it says the same thing again.  This
is with KDE 3.2 all compiled from sources with GCC 3.3.2.  I boot under
2.6.2 and everything works well again.  I did notice that the sound
config file saved by doing "alsactl store" under 2.6.2 is not compatible
with that of the 2.6.3-rc1 kernel or versus.  If anyone else has any
ideas, I'm interested.  I was really hoping this kernel would solve some
issues I was seeing with 2.6.2.

Thanks,
Steve


-----Original Message-----
From: Gene Heskett [mailto:gene.heskett@verizon.net] 
Sent: Saturday, February 07, 2004 5:48 AM
To: linux-kernel@vger.kernel.org
Subject: Re: aRTS vs 2.6.3-rc1, aRTS loses

On Saturday 07 February 2004 06:31, Gene Heskett wrote:
>Greetings;
>
>On rebooting to 2.6.3-rc1, I get a failed advisory from aRTS that I
>didn't get with 2.6.2.
>
>Is this a known problem?  FWIW, things like tvtime continue to make
>sound ok.

Must be a known operator problem, I just rebuilt it from the 
2.6.2 .config + a make oldconfig, and its all working again.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




