Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTJMFjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 01:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTJMFjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 01:39:07 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:4622 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S261460AbTJMFjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 01:39:05 -0400
To: linux-kernel@vger.kernel.org
From: tconnors+linuxkernel1066023352@astro.swin.edu.au
Subject: 2.6.0-test7 + X11 + screen savers vs. user
References: <228201c38fd6$32b82c90$5cee4ca5@DIAMONDLX60>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-8533-8442-200310131535-tc@hexane.ssi.swin.edu.au>
Date: Mon, 13 Oct 2003 15:39:01 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Norman Diamond" <ndiamond@wta.att.ne.jp> said on Sat, 11 Oct 2003 18:00:45 +0900:
> In 2.6.0-test1 through test7, when running X11, the screen saver kicks in
> about every 5 minutes.  I haven't checked the configuration but have
> confidence that it's obeying the timing correctly.  The problem is that it
> doesn't care whether the keyboard and mouse have been used during that time.
> When the screen saver is running, any keyboard or mouse activity will
> restore the screen.  Also when the screen saver isn't running, the focused
> window gets the input.  But it's irritating to be in the middle of typing or
> mousing and suddenly lose a character or click because the screen saver
> kicked in and gobbled up the next event.

What was this about time jumping backwards for some people?

Follow this thread:
http://www.ussg.iu.edu/hypermail/linux/kernel/0310.1/0056.html

Could trigger the screensaver if it thinks MAXINT time has elapsed :)

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
When some other esteemed editor reposts this, it'll be the Periodic 
Periodic Table Table story, and I will be even happier. ;^)
           --  Emil Brink on /., about the periodic table table.
