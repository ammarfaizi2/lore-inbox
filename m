Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVC2LwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVC2LwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVC2LwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:52:05 -0500
Received: from asia.telenet-ops.be ([195.130.132.59]:53379 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP id S262243AbVC2Lvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:51:50 -0500
Date: Tue, 29 Mar 2005 13:51:36 +0200
From: Smets Jan <jan@smets.cx>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Quotaoff -> crash
Message-ID: <20050329115136.GA1751@smets.cx>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0503291306020.19483@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503291306020.19483@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I have a Dell Poweredge 1600SC with kernel 2.6.11 running and using the ext3
FS + quota v2.

After a while the quota system was running out of sync. This shouldn't be a 
problem, so I decided to turn off quota for a while and rescan my files...

When running the quotaoff utility, it suddenly segfaulted and my /home was 'dead'.
I also noticed that the load of my box was rising very high. After a few minutes 
the whole server was 'dead'.

This is already the second time it occures, with a 2.6.7 kernel and with a
2.6.11 one. I have no clue if it has something to do with the SMP stuff.

Also, I didn't manage to get an crash/oops/whatever log, sorry.

If anyone has seen the same problem or has any idea howto solve this problem,
or howto get more debugging information, please let me know.

- Jan [having a dead box:]


-- 
Smets Jan
jan@smets.cx

