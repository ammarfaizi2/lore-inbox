Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQKAOmt>; Wed, 1 Nov 2000 09:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129029AbQKAOmj>; Wed, 1 Nov 2000 09:42:39 -0500
Received: from collibf1.jhuapl.edu ([128.244.27.248]:63104 "EHLO
	collibf1.jhuapl.edu") by vger.kernel.org with ESMTP
	id <S129026AbQKAOmf>; Wed, 1 Nov 2000 09:42:35 -0500
Message-ID: <3A002C04.D4CCA58D@jhuapl.edu>
Date: Wed, 01 Nov 2000 09:43:16 -0500
From: Skip Collins <bernard.collins@jhuapl.edu>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: screensaver locks up 2.4.0-test10-pre7 hard
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pentium 3, 256Mb RAM, kernel 2.4.0-test10-pre7 (as well as 2.4.0-test9).
I installed RH7, compiled the latest development kernels (using kgcc, as
required with RH7). After the "greynetic" screensaver (installed with
RH7) runs for a few minutes, my box freezes up hard. I can find no error
messages in any logs. This is always reproducible. Greynetic just paints
the screen with randomly sized, positioned and colored rectangles as
fast as it can. A stock RH7 2.2 kernel does not have this problem. In
case it matters, I am running xfree86 4.0.1 with a rage 128 video card.
I have not got acceleration set up yet and the r128 kernel module is not
loaded. My only attempt at debugging consisited of telneting into my box
while greynetic ran. I ran vmstat and the only thing that popped out at
me was that the system context switches number was continuously
increasing until the box locked up.

Please CC any responses directly to me.

Thanks,
sc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
