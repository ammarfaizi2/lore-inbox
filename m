Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312817AbSC0Brm>; Tue, 26 Mar 2002 20:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312925AbSC0Brc>; Tue, 26 Mar 2002 20:47:32 -0500
Received: from pcp01314487pcs.hatisb01.ms.comcast.net ([68.63.220.2]:9344 "EHLO
	bacchus.jdhouse.org") by vger.kernel.org with ESMTP
	id <S312817AbSC0BrV>; Tue, 26 Mar 2002 20:47:21 -0500
Subject: Re: Linux 2.4.19-pre4-ac2
From: "Jonathan A. Davis" <davis@jdhouse.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16q29I-0004Qr-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 26 Mar 2002 19:47:05 -0600
Message-Id: <1017193625.1435.18.camel@bacchus.jdhouse.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-03-26 at 19:22, Alan Cox wrote:
> Linux 2.4.19pre4-ac2

Alan and Co,

By chance I was culling through my boot log and noticed the following:

Initializing CPU#0
Detected 8132.282 MHz processor.

Now, I'd *love* to have a processor that could do that for real, but
don't think my Athlon XP quite makes the grade.  :-)

Looking through my boot logs, this problem seems to start somewhere
between 2.4.19-pre2-ac4 and 2.4.19-pre4-ac1 (I didn't run any of the
intervening releases).

It's also sporadic -- out of 5 reboots, the proper speed (1466.559 MHz)
was detected 2 of the 5 times.  Dropping back to 2.4.19-pre2-ac4 gives
me correct detection 5 of 5.  No config changes were made between these
kernels (except =n for any new options).

System:

Athlon XP 1700+
Soyo SY-K7VX MB (VIA KT266A)
1GB ECC PC2100 Memory
Redhat 7.2 (stock+updates with the exception of the kernel and XFree 4.2
(to support my ATI 7500 card)
Everything from the P/S to the cpu fan is AMD spec'd and environment
sensors show normal.

Please let me know if more info is needed...

-- 

-Jonathan <davis@jdhouse.org>

          * "The mind is like a parachute. It works best when open." *
