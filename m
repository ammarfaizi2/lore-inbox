Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUH0JeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUH0JeA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269384AbUH0J2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:28:41 -0400
Received: from web41504.mail.yahoo.com ([66.218.93.87]:52120 "HELO
	web41504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269388AbUH0J0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:26:07 -0400
Message-ID: <20040827092605.63433.qmail@web41504.mail.yahoo.com>
Date: Fri, 27 Aug 2004 10:26:05 +0100 (BST)
From: =?iso-8859-1?q?Arne=20Henrichsen?= <ahenric@yahoo.com>
Subject: Re: sys_sem* undefined
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040826092825.0fc2eeb9.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From an application (userspace) or from inside the
> kernel?

I need to do the syscalls from kernel space. Basically
I am porting our custom vxWorks driver to Linux. We
want to basically keep the structure of the vxWorks
driver the same, so I am porting the individual
vxWorks functions such as semBcreate, semGive etc.
Thats why I want to use the SysV IPC semaphores, as
they seem to most closely resemble the vxWorks ones. I
know that there are much better ways of writing a
driver, but that wouldn't fit in with the currect
structure we have at the moment.

Now if I want to call lets say sys_semget() from
kernel space, must I use the _syscall3() function? I
saw some people using this. 

Thanks for the help.
Arne


	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun!  http://uk.messenger.yahoo.com
