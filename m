Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268672AbUGXPUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268672AbUGXPUs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268670AbUGXPUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:20:48 -0400
Received: from main.gmane.org ([80.91.224.249]:38831 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268669AbUGXPUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:20:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nuno Tavares <nunotavares@hotmail.com>
Subject: kernel hang, sometimes reboot
Date: Sat, 24 Jul 2004 16:11:38 +0100
Message-ID: <pan.2004.07.24.15.11.38.127110@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 217.129.164.13
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This i very odd, I haven't seen this for years. I have a JPEG/JFIF that
when opened with Mozilla will lock the whole system, and sometimes will
reboot the system after a little while.

My short investigation led me to conclude that this is a bug both in
kernel (as it reboots) and in Gecko-based browsers - gecko is the
HTML rendering engine used in Mozilla, Firefox, Epiphany and probably
others. This last assumption is due that Konqueror will not crash.

Unfortunely, the JPEG file has some sensitive information, and this hasn't
happened with anyother. No error messages, nothing. I'm looking for ways
to debug this, both firefox and the kernel. How do I do that?

This is the information for the file:
snapshot.jpg: JPEG image data, JFIF standard 1.00, resolution (DPI), 
"LEAD Technologies Inc. V1.01", 200 x 200

Moreover, all mentioned browsers are included in the standard FC2, except
for firefox (0.8-3, rpm by Dag Wieers[1]).
Tested with the original FC2 kernel (2.6.5-358) and a with vanilla 2.6.7.
With 2.6.7 it does not reboot, but with 2.6.5 will reboot always. The
system hangs completely (forcing reboot) with both.

Despite gecko probably having a bug, what does that have to do with the
kernel?

[1] http://dag.wieers.com/home-made/apt/
-- 
Nuno Tavares
http://nthq.cjb.net/

-- 
Nuno Tavares
http://nthq.cjb.net/


