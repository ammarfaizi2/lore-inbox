Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTKEJaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 04:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTKEJaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 04:30:18 -0500
Received: from defout.telus.net ([199.185.220.240]:53401 "EHLO
	priv-edtnes56.telusplanet.net") by vger.kernel.org with ESMTP
	id S262765AbTKEJaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 04:30:15 -0500
Subject: mouse problem on 2.6.0-test9-bk9
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068024630.15471.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Nov 2003 02:30:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently patched 2.6.0-test9 to 2.6.0-test9-bk9.  Hard disk cache read
timings on /dev/hda went from 13 to 24 MB/sec, and on /dev/hdb from 24
to 28 MB/sec.  The problem is that my mouse became slow.  It was very
fast in 2.6.0-test9, but with bk9 it became very slow (4 edge-to-edge
drags across the mouse pad to go across the screen).  "xset m 9 1"
works, but I am at times unable to resize windows (the mouse is skipping
over the edge of the window).  Option "Resolution" "250" in Section
"InputDevice" of XF86Config and restarting the X server does not work
either (nor does substituting for 250 : 15, 100, 500, 2000, 15000). 
It's a minor thing, but it would be nice to change the mouse speed
again.

Thanks in advance.
-- 
Bob Gill <gillb4@telusplanet.net>

