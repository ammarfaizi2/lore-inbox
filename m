Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUBDNgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 08:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUBDNgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 08:36:49 -0500
Received: from m99-mp1.n01.edn.dial.ntli.net ([217.137.131.99]:57730 "EHLO
	tanagra.demon.co.uk") by vger.kernel.org with ESMTP id S261731AbUBDNgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 08:36:46 -0500
Subject: TSC and real-time clock slippage with 2.6.2
From: Ian Chard <ian@chard.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1075901679.5608.13.camel@tanagra>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 04 Feb 2004 13:34:39 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ever since I upgraded from 2.4.20 to the 2.6 tree, I've had a problem
with real-time clock slippage and hard hangs on my Athlon XP 2500+
(1830MHz according to /proc/cpuinfo).  I've kept an eye on the list and
have applied new patches as the problem seems to be known about, but as
the problem's still there with 2.6.2 I thought it was about time I
reared my ugly head.

At or shortly after boot time, I get the "Losing too many ticks!"
message (this seems to be related to how hard the system is working --
if it runs an fsck, the message appears immediately).  Then, while the
system is running, the real-time clock will lose time: the more jobs use
the CPU, the more time I lose.  Occasionally, the system will oops or
hard-hang altogether (which could be an unrelated driver issue; it is
pretty unusual).

I'm willing to test any patches you clever folk want to throw at me, or
alternatively if there's an easy solution I'll try anything.

Please cc: me on any replies, as my phone line is made of wet string and
would never cope with being subscribed!

Thanks for any help
- Ian

-- 
Ian Chard <ian@chard.org>
"Resting" Unix sysadmin and RHCE
near Linlithgow, central Scotland  |  sedimentation fault - beach dumped

