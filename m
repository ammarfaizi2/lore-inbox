Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWHMKtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWHMKtG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 06:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWHMKtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 06:49:05 -0400
Received: from mail.gmx.de ([213.165.64.20]:11714 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750944AbWHMKtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 06:49:05 -0400
X-Authenticated: #625117
Date: Sun, 13 Aug 2006 12:49:12 +0200
From: Dimitri Chausson <tri2000@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: linux troubleshooting help
Message-Id: <20060813124912.6b7b83b9.tri2000@gmx.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

since about 1 week, I am experiencing system crashes. I tried kernel versions 2.6.15 and 2.6.16 but it occurs in both. I first thougth it was X related (so not a kernel problem), but the machine is not reachable via network. All logs I list below were obtained with a 2.6.15-1-k7 kernel (debian):

1- When booting, contains:
-------- output------------
Stack:...
Call Trace:...
========================
Unable to handle kernel NULL pointer dereference at virtual address 00000006
printing eip:
c01037ba
*pde = 00000000
Recursive die() failure, output supressed
<0> Kernel panic - not syncing: Fatal exception in interrupt
-------- output------------

2- Running on a terminal (no X running):
-------- output------------
CPU 0: Machine Check Exception: 0000000000000004
Bank 1: ......... at ...........
Kernel panic - not syncing: CPU context corrupt
-------- output------------


And there were other similar crashes. It crashes really often (several times a day, while the computer is not running the whole day). 
Since I did not add any hardware, I thought some hardware may be dying... but is there a way to know what ? Until now I ran a memtest86, and I checked the hard disk with smartmontools. Both went well...

I do not know how to proceed now, and I would appreciate any hint or help on how to further isolate the problem,

thanks for your time,

Dimitri 

PS: of course, I can provide you with more details if necessary
