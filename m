Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136863AbRA1VbH>; Sun, 28 Jan 2001 16:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143942AbRA1Va5>; Sun, 28 Jan 2001 16:30:57 -0500
Received: from [209.250.53.88] ([209.250.53.88]:1803 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S143937AbRA1Vas>; Sun, 28 Jan 2001 16:30:48 -0500
Date: Sun, 28 Jan 2001 15:30:36 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: ISAPnP Buglet in 2.4.0
Message-ID: <20010128153035.A8389@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Problem in a nutshell:  The module for my soundcard (cs4232.o) won't
load until after a "cat /proc/isapnp" has been run.  I'm guessing
(though not sure) that this isn't the intended behavior.  ISAPnP is
compiled into the kernel, and detects the card correctly during boot, as
evidenced by the boot messages.  Doesn't seem like a huge deal, any idea
where the problem lies?
-- 
-Steven
Never ask a geek why, just nod your head and slowly back away.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
