Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269726AbRIDWpC>; Tue, 4 Sep 2001 18:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269718AbRIDWow>; Tue, 4 Sep 2001 18:44:52 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:35295 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269726AbRIDWok>; Tue, 4 Sep 2001 18:44:40 -0400
Date: Tue, 4 Sep 2001 18:43:20 -0400 (EDT)
From: Richard A Nelson <cowboy@debian.org>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: fsync(dir) redux
Message-ID: <Pine.LNX.4.33.0109041839060.2267-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've got now got open(dir);fsync(dir);close(dir) after my
rename,unlink, and link calls.

Now, I need to know when its needed, and when it isn't allowed!
I seem to recall that newer Reiserfs wouldn't need it, is that true?
and if so, at what level?.

How about xfs, jfs, etc ?

I also seem to recall discussion that some of this might wind up
supported in VFS?

Lastly, I just received an error report from a user who is getting
fsync(dir) errors on an NFS mounted directory ?!?!?

-- 
Rick Nelson
"...and scantily clad females, of course.  Who cares if it's below zero
outside"
(By Linus Torvalds)

