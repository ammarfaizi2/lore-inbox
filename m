Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTKEDOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 22:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTKEDOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 22:14:25 -0500
Received: from bab72-140.optonline.net ([167.206.72.140]:33416 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP id S262745AbTKEDOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 22:14:23 -0500
Date: Tue, 4 Nov 2003 22:14:21 -0500
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 and X11: box dies when I switch to VT
Message-ID: <20031105031421.GA20829@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello all,

I can't really remember when this happened (probably after test 6 or 7) but
now, using plain vanilla 2.6.0-test9, I can't switch to the console after
XFree has been started. If I do, I get a login prompt but all the input
devices are disabled (keyboard/mouse).
At this point, the box is frozen and doesn't respond to pings (Magic SysRq
doesn't work either). Note that switching still works if I reboot and use a
different kernel.

I've tried enabling all the debug options to get a call trace using a
serial console but that was unsucessful. A shutdown/reboot produces the
same thing, XFree exits, I get the "Switching to runlevel" message and
that's it...

I'm not running any proprietary binaries and if this helps, thix box runs
fedora (XFree version 4.3.0-42).

I would like to know if I'm the only one experiencing this.

Thanks, Mathieu.
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
