Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUELN2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUELN2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbUELN2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:28:23 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:42236 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S265040AbUELN2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:28:22 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: odd problem with dd, kernels 2.6.5-mm6, 2.6.6 maybe others
Date: Wed, 12 May 2004 09:28:00 -0400
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405120928.00764.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.63.246] at Wed, 12 May 2004 08:28:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I'm apparently having tape problems, and dd is one of the tools I use 
to fix things.  Unforch, when /dev/nst0 has reported an error during 
the amcheck cycle, on 2 of the 4 tapes that it read just fine 
yesterday, and then I do a rewind on one of them, and issue a 'dd 
if=/dev/nst0 count=1' which *should* spit out the tape header 
onscreen, what I'm actually getting is that nothing touches the drive 
as far as moving the tape or changing the "Ready 1" display on the 
face of the changer, but I do have a hung dd that can only be gotten 
rid of by a reboot.

It cannot be killed, not even with a -9.  I do not know if this is a 
new development in kernel history or not, but it sure is a PITA.

Its been hung for about 20 minutes now.

Is there anything that I as a big dummy can do to remedy this?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
