Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131689AbQLJWTt>; Sun, 10 Dec 2000 17:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131752AbQLJWTj>; Sun, 10 Dec 2000 17:19:39 -0500
Received: from f39.law9.hotmail.com ([64.4.9.39]:22533 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S131689AbQLJWTc>;
	Sun, 10 Dec 2000 17:19:32 -0500
X-Originating-IP: [213.73.164.155]
From: "Jonathan Brugge" <jonathan_brugge@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: fatal lockup, BIOS/CMOS reset?
Date: Sun, 10 Dec 2000 22:49:05 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F394unQVK110xQGocT0000136aa@hotmail.com>
X-OriginalArrivalTime: 10 Dec 2000 21:49:05.0712 (UTC) FILETIME=[046BC300:01C062F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was experimenting with Hunt, a program I found. This caused some heavy 
load, and my system had already quite some programs running, so I think I 
got out of memory (no programs got killed, shouldn't that be done by the 
VM?). Maybe it was for some other reason, but my system locked, I had to use 
CTRL-ALT-DELETE. This seemed to work, my HD made some sound and it rebooted. 
But then: I got a message about a bad CMOS and when I looked in my 
BIOS-settings I saw they were totally reset... No HD's, date was 1/1/2000, 
etc.
After setting everything to the correct value I tried to boot again and no 
problem this time, not even about a partition that was unmounted 
incorrectly. It seems to me that no program may EVER have a chance to change 
things in BIOS/CMOS.I'm running kernel 2.4.0test11 with libc6-2.2.5 (Debian 
woody, if it matters).

1: Is it possible that a program sets options in BIOS/CMOS?
2: If so, should it be possible?
3: Any other things that could cause this to happen?

I'm not sure it's a kernel-related problem, but it's something that should 
never happen, in my opinion (except BIOS-flashing).

Thanks,

Jonathan Brugge

P.S.: My system: Gigabyte GA-7IXE mainboard, K7-700, 128 MB, AMD 751/756 
chipset.
_____________________________________________________________________________________
Get more from the Web.  FREE MSN Explorer download : http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
