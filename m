Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135861AbREDG0g>; Fri, 4 May 2001 02:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135867AbREDG00>; Fri, 4 May 2001 02:26:26 -0400
Received: from smtp3.xs4all.nl ([194.109.127.132]:28168 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S135861AbREDG0K>;
	Fri, 4 May 2001 02:26:10 -0400
From: thunder7@xs4all.nl
Date: Fri, 4 May 2001 08:25:57 +0200
To: linux-kernel@vger.kernel.org
Subject: rtc: lost some interrupts / mga_flush_ioctl *ERROR* lock not held
Message-ID: <20010504082557.A22797@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should I be worried about these?

May  4 08:09:29 middle kernel: rtc: lost some interrupts at 256Hz.
May  4 08:09:38 middle last message repeated 2 times
May  4 08:09:56 middle kernel: rtc: lost some interrupts at 1024Hz.
May  4 08:10:05 middle kernel: [drm:mga_flush_ioctl] *ERROR* lock not held
May  4 08:14:39 middle kernel: rtc: lost some interrupts at 512Hz.
May  4 08:15:07 middle last message repeated 4 times
May  4 08:16:06 middle kernel: rtc: lost some interrupts at 256Hz.
May  4 08:16:09 middle kernel: [drm:mga_flush_ioctl] *ERROR* lock not held
May  4 08:17:33 middle kernel: rtc: lost some interrupts at 512Hz.
May  4 08:18:01 middle last message repeated 12 times

this is an X-session during heavy IDE-UDMA disk activity.
Linux 2.4.4, i86-SMP system (Abit VP6, via chipset), Matrox G400.

Thanks,
Jurriaan
-- 
These, then, were Srenki, men whose virtue was the excess of vice, who
with leaden zest performed quintessential evil and so redeemed their
fellows from turpitude.
	Jack Vance - The Gray Prince.
GNU/Linux 2.4.4 SMP/ReiserFS 2x1743 bogomips load av: 0.05 0.02 0.01
