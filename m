Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSGENrl>; Fri, 5 Jul 2002 09:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSGENrk>; Fri, 5 Jul 2002 09:47:40 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:29142 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S317446AbSGENrk>;
	Fri, 5 Jul 2002 09:47:40 -0400
Subject: prevent breaking a chroot() jail?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 05 Jul 2002 09:50:02 -0400
Message-Id: <1025877004.11004.59.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to develop a way to ensure that one can't break out of a
chroot() jail, even as root.  I'm willing to change the way the syscalls
work (most likely only for a subset of processes, i.e. processes that
are run in the jail end up getting a marker which is passed down to all
their children that causes the syscalls to behave differently).

What should I be aware of?  I figure devices (no need to run mknod in
this jail) and chroot (as per man page), is there any other way of
breaking the chroot jail (at a syscall level or otherwise)?

or is this 100% impossible?

thanks,

shaya



