Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbSKCNqJ>; Sun, 3 Nov 2002 08:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSKCNqJ>; Sun, 3 Nov 2002 08:46:09 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:22912 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261866AbSKCNqI>; Sun, 3 Nov 2002 08:46:08 -0500
Cc: Oliver Xymoron <oxymoron@waste.org>, Alexander Viro <viro@math.psu.edu>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
References: <Pine.LNX.4.44.0211022144070.2934-100000@home.transmeta.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Sun, 03 Nov 2002 14:52:18 +0100
Message-ID: <877kfuvjzh.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On the other hand, I have this suspicion that the most secure setup is one 
> that the sysadmin is _used_ to, and knows all the pitfalls of. Which 
> obviously is a big argument for just maintaining the status quo with suid 
> binaries.

As is shown every now and then, when the next security hole is
reported. So we stay at the lowest common denominator.

I've always had good experience with educating people, not with
dumbing them down. But maybe I've been just lucky then and worked
with very smart people.

> We have decades of knowledge on how to minimize the negative impact of
> suid (I've used sendmail as an example of a suid program, and yet last I
> looked sendmail was actually pretty careful about dropping all unnecessary
> privileges very early on).

So we throw out the baby with the bath water. This is conservatism at
it's worst.

> And as Al points out, new security features don't mean that you can just
> stop being careful. 

Stating the obvious. Capabilities are not an end in itself, nor is suid
root. It's just another line of defense to help with these binaries,
which are _not_ capability aware.

Regards, Olaf.
