Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265393AbSJaWCp>; Thu, 31 Oct 2002 17:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265388AbSJaWCp>; Thu, 31 Oct 2002 17:02:45 -0500
Received: from [195.39.17.254] ([195.39.17.254]:13572 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265393AbSJaWCn>;
	Thu, 31 Oct 2002 17:02:43 -0500
Date: Thu, 31 Oct 2002 23:57:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031225729.GD4331@elf.ucw.cz>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.GSO.4.21.0210302135150.13031-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210302135150.13031-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > ext2/ext3 ACLs and Extended Attributes
> > 
> > I don't know why people still want ACL's. There were noises about them for 
> > samba, but I'v enot heard anything since. Are vendors using this?
> 
> Because People Are Stupid(tm).  Because it's cheaper to put "ACL support: yes"
> in the feature list under "Security" than to make sure than userland can cope
> with anything more complex than  "Me Og.  Og see directory.  Directory Og's.
> Nobody change it".  C.f. snake oil, P.T.Barnum and esp. LSM users

Okay... Have ~/bin/phonebook and I'd like it to be rw- to me, r-- to
jarka and mj, and --- to everyone else. How do I do that without ACLs?
Adding a group is root-only operation.

This seems like a pretty common situation to me, and current solutions
are not nice. [I guess ~/bin/ with --x and
~/bin/my-secret-password-only-jarka-and-mj-knows/phonebook would solve
the problem, but...!]
								Pavel
-- 
When do you have heart between your knees?
