Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266444AbRGCGRU>; Tue, 3 Jul 2001 02:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266446AbRGCGRL>; Tue, 3 Jul 2001 02:17:11 -0400
Received: from ruddock-207.caltech.edu ([131.215.90.207]:14745 "EHLO
	agard.caltech.edu") by vger.kernel.org with ESMTP
	id <S266444AbRGCGQy>; Tue, 3 Jul 2001 02:16:54 -0400
Message-ID: <3B41641F.6737858A@its.caltech.edu>
Date: Mon, 02 Jul 2001 23:20:15 -0700
From: James Lamanna <jlamanna@its.caltech.edu>
Reply-To: jlamanna@its.caltech.edu
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: waitqueues 2.2->2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, I"m working on converting a module from 2.2 to being
compatible with 2.4.
In the 2.2 version it uses wait_queue structs with function
calls such as wake_up(), interruptible_sleep_on()...
In 2.4 these have changed to accept wait_queue_head_t's.
What is the correct way to convert to the new way of doing things?

And on another note, what is the best way to debug a module that
crashes in an interrupt routine? (the oops info doesn't get logged
anywhere since it crashes in the ISR).

* Please CC to me since I'm not subscribed...

Thanks,
--James Lamanna
