Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRBOSUb>; Thu, 15 Feb 2001 13:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129398AbRBOSUL>; Thu, 15 Feb 2001 13:20:11 -0500
Received: from [194.46.8.33] ([194.46.8.33]:42506 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S129216AbRBOSUG>;
	Thu, 15 Feb 2001 13:20:06 -0500
Date: Thu, 15 Feb 2001 18:21:02 +0000
From: Dale Amon <amon@vnl.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Crypto patches for losetup
Message-ID: <20010215182101.J21919@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to update some patches of Harald's to work
with the official 2.4.0 international patches. He had
a very nice unofficial patch set that doesn't use a
table, it just sees what is in /proc/crypto. I fixed
a few bugs and it worked marvelously with unofficial
test9 patches all the way up to t12.

However the official patches have changed the data
structure underlying the "files", ie 
/proc/crypto/cipher/twofish-ecb no longer has int t_id;
it has int t_flags instead. And it isn't just a name
change, it does something entirely different.

Since Harald's code depended on predefined id's in the
international patches, that broke it pretty thoroughly.
I'm looking at them to see if I can excise that dependance
entirely. I think I can, but I'd like someone who I
could chat with about some of the underlying reasons
for certain things being there. Harald is busy with
other things and can't take time off to refresh himself
on the contents of the patch-int's enough to help.

I'm working on some mods now but I can see a couple
ways to go and I'd rather pick the right one first
time.

Please contact me directly, amon@vnl.com; since the
LK-digest went away I've been finding I often (mostly?)
miss things in the flood of thousands of itty bitty
messages :-) 

-- 
------------------------------------------------------
Use Linux: A computer        Dale Amon, CEO/MD
is a terrible thing          Village Networking Ltd
to waste.                    Belfast, Northern Ireland
------------------------------------------------------
