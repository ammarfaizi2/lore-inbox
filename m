Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSGINK1>; Tue, 9 Jul 2002 09:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315222AbSGINJC>; Tue, 9 Jul 2002 09:09:02 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:24299 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S315245AbSGINIo>; Tue, 9 Jul 2002 09:08:44 -0400
Date: Tue, 9 Jul 2002 05:07:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: prevent breaking a chroot() jail?
Message-ID: <20020709030755.GB113@elf.ucw.cz>
References: <1025877004.11004.59.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025877004.11004.59.camel@zaphod>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm trying to develop a way to ensure that one can't break out of a
> chroot() jail, even as root.  I'm willing to change the way the syscalls
> work (most likely only for a subset of processes, i.e. processes that
> are run in the jail end up getting a marker which is passed down to all
> their children that causes the syscalls to behave differently).
> 
> What should I be aware of?  I figure devices (no need to run mknod in
> this jail) and chroot (as per man page), is there any other way of
> breaking the chroot jail (at a syscall level or otherwise)?

subterfugue.sf.net, or UML. Its hard to do with chroot(). Think
kill(-9, -1).
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
