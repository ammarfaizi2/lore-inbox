Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVECWdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVECWdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVECWde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:33:34 -0400
Received: from 210-55-221-221.adsl.ihug.co.nz ([210.55.221.221]:18984 "EHLO
	kieu.family") by vger.kernel.org with ESMTP id S261870AbVECWa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:30:29 -0400
Date: Wed, 4 May 2005 10:30:24 +1200 (NZST)
From: steve@perfectpc.co.nz
X-X-Sender: sk@localhost.localdomain
Reply-To: steve@perfectpc.co.nz
To: linux-kernel@vger.kernel.org
Subject: Journalling file system and dm-raid
Message-ID: <Pine.LNX.4.62.0505041020540.3940@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I install linux system from remote to a box that has Silicon Image chipset 
and using dmraid + device mapper. Because it is remote box, then I can not 
get any OOP message (sorry), the problem is:

If I use JFS + SMP kernel (this is a dual P4 box); it runs unstable (slow, 
slugish) and when I do a rm -rf linux_source_dir  then the terminal 
freeze, system unresponding. I have to phone someone to power it off and 
on.

If use JFS without SMP. it runs stable.

If use reiserfs it oops on boot (no matter SMP or not), the only thing I 
got is some sort of EIP bad value message (told by a non IT staff at the site) so I guess it 
OOPes.

Now I have to revert it to ancient but stable ext2!
I really like JFS as I use it stably in my server box but do not its 
behavior in SMP kernel.

please let me know if it is known problem with JFS and smp, and it has 
been fixed in recent kernel. Thank you.


Steve Kieu
PerfectPC Ltd. Technical Division.
Web: http://www.perfectpc.co.nz/
Ph: 04 461 7489
Mob: 021 137 0260
