Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276782AbRJBXWv>; Tue, 2 Oct 2001 19:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276781AbRJBXWl>; Tue, 2 Oct 2001 19:22:41 -0400
Received: from [66.122.62.187] ([66.122.62.187]:1868 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S276782AbRJBXWb>; Tue, 2 Oct 2001 19:22:31 -0400
From: brian@worldcontrol.com
Date: Tue, 2 Oct 2001 16:34:44 -0700
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-ac3+preempt opening PDF eliminates responsiveness
Message-ID: <20011002163443.A6882@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.10-ac3+preempt on a K6-3/366 with 128MB RAM.

I tried to open the file flag.pdf in ghostview 

-rw-r--r--   1 brian    console    229365 Oct  1 22:49 flag.pdf

The system became almost completely unresponsive.  The mouse would
move every 20 seconds or so.   The hard drive indicator on the laptop
was basically on the whole time, and I could hear the drive
making noise.

The computer was working just had become nearly unresponsive just
occasionally moving the mouse pointer every 20 seconds or so.

I ctrl-alt-bs'd the X session and eventually the X session came down and
everything returned to normal as far as responsiveness is concerned.

Just brought X back up and continued as normal.

The behavior is repeatable.  And the same thing happens if I try to
open the flag.pdf file in gimp.

I suppose if I waited long enough both gimp and ghostview would
eventually come up.

However, I'm sure the system isn't meant to grind to a halt while
bringing up that file.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
