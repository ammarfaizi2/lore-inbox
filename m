Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSKCNtG>; Sun, 3 Nov 2002 08:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSKCNtG>; Sun, 3 Nov 2002 08:49:06 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:4494 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261868AbSKCNtE>; Sun, 3 Nov 2002 08:49:04 -0500
Cc: Alexander Viro <viro@math.psu.edu>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>, <davej@suse.de>
References: <Pine.LNX.4.44.0211021925230.2382-100000@home.transmeta.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Sun, 03 Nov 2002 14:55:29 +0100
Message-ID: <87n0oqsqpa.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sat, 2 Nov 2002, Linus Torvalds wrote:
>
> It occurs to me that we actually do have the "extended symlink" concept in
> UNIX already: the existing "#!" escape for executables is really exactly
> that. It's just a structured symlink, except the extension is not a
> capability, but rather it's the script to be fed to the executable.
>
> With a simple extended binfmt_misc.c or binfmt_script.c, we could do a
> capability escape (that only removes capabilities, but allows for suid
> shells) fairly easily if people really want it. And it would work on any
> almost-UNIXy filesystem, including NFS etc.

Look at <http://marc.theaimsgroup.com/?l=linux-kernel&m=101639590421603>.

Regards, Olaf.
