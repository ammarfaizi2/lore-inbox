Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268856AbUIACvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268856AbUIACvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 22:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268868AbUIACvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 22:51:46 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:47284 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S268856AbUIACvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 22:51:44 -0400
Message-ID: <41353913.70102@nodivisions.com>
Date: Tue, 31 Aug 2004 22:50:59 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: devfsd stuck in D state
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running devfs v1.22 on this Gentoo system:


Linux soma 2.6.3 #8 Thu Jun 10 00:17:31 EDT 2004 i686 Pentium III 
(Coppermine) GenuineIntel GNU/Linux


...and I just unplugged my USB memory-stick reader.  That apparently caused 
devfsd to go into "D" state (uninterruptible sleep, right?):


root       118  0.0  0.1  1832  924 ?        D    Aug27   0:01 /sbin/devfsd /dev


...and it won't come back.  CPU is idle, but load is:


load average: 52.90, 51.41, 49.48


...and now some weird stuff is happening, for example man doesn't work, and 
ps works but doesn't return.  (top works, vmstat works...)

killall -HUP devfsd doesn't do anything.

Is it possible to fix this without rebooting?

Thanks,
Anthony DiSante
http://nodivisions.com/


PS - sorry about that misdirected "subscribe" email.
