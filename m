Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282919AbRLMAXw>; Wed, 12 Dec 2001 19:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282948AbRLMAXm>; Wed, 12 Dec 2001 19:23:42 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:37271 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S282947AbRLMAXc>; Wed, 12 Dec 2001 19:23:32 -0500
Date: Thu, 13 Dec 2001 00:24:11 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Over-enthusiastic OOM killer.
Message-ID: <20011213002411.A26944@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The oom killer just killed a bunch of processes on my workstation.
What I don't understand, is why this was deemed necessary, when
there was 400MB of buffer cache sitting around in memory, and 175MB
of free swap space unused. (66mb of swap was used)
		
Seems something is drastically amiss here.

The box is still alive, if theres anything else I can provide,
although cron.daily just ran 5 minutes after the oomkill,
which has polluted the situation a little..

It's been up for just over 10 days on pre2.

regards,
Dave.

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
