Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRAOAJM>; Sun, 14 Jan 2001 19:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbRAOAJB>; Sun, 14 Jan 2001 19:09:01 -0500
Received: from [209.250.58.160] ([209.250.58.160]:58379 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129718AbRAOAIs>; Sun, 14 Jan 2001 19:08:48 -0500
Date: Sun, 14 Jan 2001 18:08:16 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Weird (apparently FPU-related) bugs in 2.4.0
Message-ID: <20010114180816.A18369@hapablap.dyn.dhs.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this sounds weird, and it is.  After running 2.4.0 for... 1 day, 18
hours straight, I've run into some strange behavior.  Most noticeable is
that, whem playing sounds, XMMS squeaks.  However, the squeaks show up
on the graphic equalizer, which means to me that it is getting bad math
results.

I seem to recall seeing something about an interaction between the new
lazy-FPU handling (or something) and Athlons.  But, this is an AMD-K6/2
system.  Could the problem be on more chips than just the Athlon?

It started when I configured and compiling xine.  Also, whenever a
squeak happens, some other weird things occur.  For example, my clock
applet locks solid.  Anyone else experience this?  Perhaps a genius out
there who knows my problem, or has a lead?
-- 
-Steven
Never ask a geek why, just nod your head and slowly back away.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
