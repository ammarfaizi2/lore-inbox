Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUEJIut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUEJIut (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 04:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264573AbUEJIut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 04:50:49 -0400
Received: from mail.genesys.ro ([193.230.224.5]:4514 "EHLO mail.genesys.ro")
	by vger.kernel.org with ESMTP id S264571AbUEJIuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 04:50:40 -0400
Message-ID: <33073.192.168.1.88.1084179033.squirrel@mail.genesys.ro>
Date: Mon, 10 May 2004 11:50:33 +0300 (EEST)
Subject: dynamic allocation of swap disk space
From: "Silviu Marin-Caea" <silviu@genesys.ro>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.0 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's the same old whine.  Please include
http://sourceforge.net/projects/swapd/ or
http://sourceforge.net/projects/dynswapd/
or whatever in the official kernel.

My desktop has been thrashing the disk for a couple of hours because
the swap space was exhausted.  And I have the ambition to leave it alone
to see if it ever comes out of the thrashing.  Of course, it's not usable
at all during this time, I'm writing this on the laptop.

This is the only serious bug (I consider it a bug) in the linux kernel
that I encountered on occasions.  And it was not fixed in 2.6.  Forgot to
mention, my desktop is running 2.6.3.

The way I see the solution is: allocate swap space dynamically, until
there is no need for more or the disk becomes nearly full.  If that
happens, then start thrashing it, all right.  Then when the condition is
gone and things are back to normal deallocate the additional swap.

Old whine or not, it's a real problem.  Thanks.

PS: I'm not subscribed.
