Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbUCZSwL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbUCZSwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:52:11 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:7297 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262099AbUCZSvN (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:51:13 -0500
Message-ID: <406462C1.5020507@namesys.com>
Date: Fri, 26 Mar 2004 09:05:05 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       cliff@lindows.com, Tom Welch <tom.welch@lindows.com>,
       Kurt Garloff <garloff@suse.de>, Daniel Robbins <drobbins@gentoo.org>,
       Ramon Reiser <reiserrf@hotmail.com>
Subject: Reiser4 needs more testers
References: <16484.24086.167505.94478@laputa.namesys.com>
In-Reply-To: <16484.24086.167505.94478@laputa.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have one NFS related bug remaining, and one mmap all of memory 
related bug (and performance issue) that you can hit using iozone.  We 
will fix both of these in next week's snapshot, they were both multi-day 
bug fixes.  When they are fixed, unless users/distros find bugs next 
week we will submit it for inclusion in the -mm and then the official 
kernel.

We hope it is now fairly stable for average users if you avoid those two 
issues (we need to get rid of those dire warnings about its 
stability...., we will remember that next snapshot....;-) )

We need a lot more real user testers, because we have run out of scripts 
that can crash it, and there are distros that would like to ship it 
soon.  Please also complain to vitaly@namesys.com and ramon@namesys.com 
about poor documentation, etc., ....

The new reiser4 snapshot (against 2.6.5-rc2) is available at

http://www.namesys.com/snapshots/2004.03.26/


-- 
Hans

