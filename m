Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281874AbRKSBu4>; Sun, 18 Nov 2001 20:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281876AbRKSBug>; Sun, 18 Nov 2001 20:50:36 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:19987 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S281874AbRKSBua>;
	Sun, 18 Nov 2001 20:50:30 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111190150.fAJ1oSZ68274@saturn.cs.uml.edu>
Subject: Re: Linux ACL designe - why the POSIX draft?
To: nmiell@home.com (Nicholas Miell)
Date: Sun, 18 Nov 2001 20:50:28 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BEF7FD8.D9FFB716@home.com> from "Nicholas Miell" at Nov 11, 2001 11:52:56 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell writes:

> With all the recent discussion about ACLs and Linux on
> linux-kernel, I was wondering why the ACL implementations
> for Linux are based off the withdrawn POSIX 1003.1e draft
> 17?

As a group, we are short-sighted herd followers.

> Is there any particular reason why this was chosen for
> the basis for the Linux ACL system, besides the fact
> that its what everybody else did? (It is a only a
> withdrawn draft after all, there's no reason to actually
> follow it...)
> 
> Wouldn't a more flexible solution, perhaps one based on 
> the NFSv4 ACL design[1] be better?

Of course it would be better, but then we'd all argue over
the details. (compatibility, API, user interface...)

> Because the NFSv4 design is in effect a superset of the
> POSIX 1003.1e draft functionality, all Unix filesystems
> with ACLs could be easily supported by the Linux VFS, and
> the task of implementing NFSv4, NTFS, and SMB would be
> made easier[2] because of it.

Sure. Problem is, few have seen NFSv4 ACLs. There is also a
prejudice against anything that even remotely resembles NT,
never minding if it is better or is what businesses want.
