Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287644AbSAEKwt>; Sat, 5 Jan 2002 05:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287648AbSAEKwj>; Sat, 5 Jan 2002 05:52:39 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:32219 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S287645AbSAEKwb>; Sat, 5 Jan 2002 05:52:31 -0500
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200201051052.g05AqLb01141@ns.home.local>
Subject: Re: Linux Kernel-2.4.18-nj1
To: reddog83@chartermi.net
Date: Sat, 5 Jan 2002 11:52:21 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Location of Linux Kernel-2.4.18-nj1

Hi Nathan,

Please don't take it bad, I don't want to flame you nor anybody, but I
think that if everyone publicly announces his own tree with his own set
of changes against the main kernel, many users will be lost quickly.

Once, we had "only" 3 main trees for the stable release :
 - Linus' official kernels
 - Alan's who did an excellent job at combining a stable core with experimental
   drivers
 - Andrea's kernel which is more oriented towards big servers and very high
   loads.

Now that Alan is working on something else, I can easily understand that
people need a branch like the one he maintained, even if the majority of his
work has been merged into the main tree.

But there is now an -mjc tree, an -nj tree, perhaps others I missed, and many
more not announced here (-wt, I remember of Mathias Andree's -ma for example
who may have been the first one to merge ext3 and reiserfs into a same kernel).
All of them include nearly the same set of fixes that have not yet got into
the official kernel, plus a set of more-or-less stable, more-or-less
interesting features (depending who the targets are). At least, each one
should announce the goal of his kernel, and who it is intended to : developpers,
production users, desktop users, testers, all of them ? With your announce,
nobody even knows if he takes some particular risks using features from your
kernel. Example: I believe that at least Andre Pavenis still has problems with
Doug's i810_audio driver, so this cannot be annouced simply as a "fix" without
a little note.

I sure know it takes a lot of time maintaining a set of patches against a
mainstream kernel, and it even takes more time reading bug reports and
determining what is stable and what isn't. Not to tell about the dozens of
compilations before an announcement (because you compile them, don't you?),
and occasional porting of some fixes to other architectures.

So I really think it would be more productive if people worked around a
smaller set of trees, stopped editing patches by hand again and again to
resolve the same conflicts and tried to be a bit more understandable for
newbies who are a bit lost when they don't know what kernel to try.

Perhaps you could have sent your patches to Mickael Cohen to help him release
an -mjc2 more quickly, like we all did with Alan ? Or perhaps you have a clear
idea in mind about what your kernel tree will be, but in this case, please
elaborate on this a bit more than this simple post, and prepare to cope with
bug reports from people who will trust your tree. This last point may be the
major reason why I chose to keep my kernels for my friends and I...

I hope you didn't take it as an attack, it wasn't really against you, nor to
start a flame war, but just to make people think a bit about something more
constructive.

Regards,
Willy

