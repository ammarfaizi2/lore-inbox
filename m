Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbVHEQ45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbVHEQ45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 12:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVHEQ4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 12:56:43 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:5805 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263066AbVHEQze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 12:55:34 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: Re: 2.6.13-rc5-git2 does not boot on (my) amd64
Date: Fri, 5 Aug 2005 16:55:34 +0000 (UTC)
Organization: Cistron
Message-ID: <dd05m6$7be$1@news.cistron.nl>
References: <dctuso$tl$1@news.cistron.nl.suse.lists.linux.kernel><Pine.LNX.4.61.0508042358530.8665@goblin.wat.veritas.com> <113800000.1123197027@[10.10.2.4]> <833200000.1123259737@flay>
X-Trace: ncc1701.cistron.net 1123260934 7534 62.216.30.70 (5 Aug 2005 16:55:34 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh <mbligh@mbligh.org> wrote:
>>>> > VM: killing process hotplug
>>>> > Unable to handle kernel paging request at fffffff28017b5be RIP:
>>>> > [<fffffff28017b5be>]
>>>> 
>-git3 works! wheeeeeeeee! thanks guys.

ACK!

The newsgateway is pounding on git3 as well ;-)

# procinfo
Linux 2.6.13-rc5-git3 (root@newsgate) 

Memory:      Total        Used        Free      Shared     Buffers
Mem:       2058040     2041800       16240           0         464
Swap:            0           0           0

Bootup: Fri Aug  5 16:54:42 2005    Load average: 3.10 3.29 3.31 1/65 9610

user  :       0:10:28.91   8.7%  page in :        0
nice  :       0:01:18.71   1.1%  page out:        0
system:       0:31:07.22  26.0%  swap in :        0
idle  :       0:04:34.04   3.8%  swap out:        0
uptime:       1:59:55.23         context : 18646886

irq  0:   1795085 timer                 irq 12:         3
irq  1:         8 i8042                 irq 24:   1981124 aic79xx
irq  2:         0 cascade [4]           irq 25:  17270208 aic79xx, eth3
irq  4:       771 serial                irq 28:  34999920 acenic


Let's see if this survives longer than 30 hours ! ;-)

Danny


