Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUB1MXo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 07:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbUB1MXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 07:23:44 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:36536 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S261816AbUB1MXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 07:23:41 -0500
Subject: Where does this load come from?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077971267.10257.24.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 28 Feb 2004 13:27:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing some strange load figures on my P4 Celeron based system
which I cannot explain. There always seem to be some load while there
are no real apps running. Stopping all daemons doesn't seem to effect
things at all.

Output from top with 2.6.4-rc1:

 13:16:38  up 38 min,  1 user,  load average: 1.67, 1.74, 1.57
62 processes: 59 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  47.5% user  52.4% system   0.0% nice   0.0% iowait   0.0%
idle
Mem:   515552k av,   93544k used,  422008k free,       0k shrd,   10980k
buff
        49632k active,              29284k inactive
Swap:  265064k av,       0k used,  265064k free                   59836k
cached

Is this a real problem or is top screwing things up here? 0.0% idle
doesn't seem right as for the load average. This system runs on RH9.

Compared to my P4 HT system running 2.6.4-rc1 on Fedore Core-1:

 13:17:42  up 30 min,  5 users,  load average: 0.12, 0.63, 0.64
91 processes: 90 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  cpu    user    nice  system    irq  softirq  iowait    idle
           total    1.2%    0.0%    0.4%   0.0%     0.0%    0.0%  198.0%
           cpu00    0.9%    0.0%    0.1%   0.0%     0.0%    0.0%   98.8%
           cpu01    0.1%    0.0%    0.3%   0.0%     0.0%    0.0%   99.4%
Mem:  1034456k av,  433712k used,  600744k free,       0k shrd,   26496k
buff
       239752k active,             152112k inactive
Swap:  787176k av,       0k used,  787176k free                  290452k
cached

This looks more like it.

What can be the problem here (if there is a real problem)?

Jurgen

